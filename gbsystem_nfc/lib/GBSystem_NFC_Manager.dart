import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:ndef/ndef.dart' as ndef; // pour TypeNameFormat (si nécessaire)

/// Classe wrapper pour encapsuler toutes les fonctionnalités NFC
/// Utilise flutter_nfc_kit pour une meilleure compatibilité
class GBSystem_NFC_Manager {
  static GBSystem_NFC_Manager? _instance;
  static GBSystem_NFC_Manager get instance => _instance ??= GBSystem_NFC_Manager._();

  GBSystem_NFC_Manager._();

  /// Vérifie si NFC est disponible sur l'appareil
  Future<bool> isNFCAvailable() async {
    try {
      final availability = await FlutterNfcKit.nfcAvailability;
      return availability == NFCAvailability.available;
    } catch (e) {
      Get.log('Erreur lors de la vérification NFC: $e');
      return false;
    }
  }

  /// Démarre une session de lecture NFC
  /// [onTagDetected] : Callback appelé quand un tag est détecté
  /// [onError] : Callback appelé en cas d'erreur
  /// [timeout] : Timeout pour la session (optionnel)
  Future<void> startNFCReading({
    required Function(String tagData) onTagDetected,
    Function(String error)? onError,
    Duration? timeout,
  }) async {
    try {
      bool isAvailable = await isNFCAvailable();
      if (!isAvailable) {
        onError?.call('NFC non disponible sur cet appareil');
        return;
      }

      // Démarrer la session de lecture
      NFCTag tag = await FlutterNfcKit.poll(
        timeout: timeout ?? const Duration(seconds: 30),
        iosMultipleTagMessage: "Plusieurs tags détectés",
        iosAlertMessage: "Approchez votre tag NFC de l'appareil",
      );

      try {
        String tagData = await _extractTagData(tag);
        onTagDetected(tagData);
      } catch (e) {
        onError?.call('Erreur lors de la lecture du tag: $e');
      } finally {
        await FlutterNfcKit.finish();
      }
    } catch (e) {
      onError?.call('Erreur lors du démarrage de la session NFC: $e');
      await FlutterNfcKit.finish();
    }
  }

  /// Arrête la session de lecture NFC
  Future<void> stopNFCReading() async {
    try {
      await FlutterNfcKit.finish();
    } catch (e) {
      Get.log('Erreur lors de l\'arrêt de la session NFC: $e');
    }
  }

  /// Écrit des données sur un tag NFC
  /// [data] : Données à écrire
  /// [onSuccess] : Callback appelé en cas de succès
  /// [onError] : Callback appelé en cas d'erreur
  Future<void> writeNFCTag({
    required String data,
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    try {
      bool isAvailable = await isNFCAvailable();
      if (!isAvailable) {
        onError?.call('NFC non disponible sur cet appareil');
        return;
      }

      // Démarrer la session d'écriture
      NFCTag tag = await FlutterNfcKit.poll(
        timeout: const Duration(seconds: 30),
        iosMultipleTagMessage: "Plusieurs tags détectés",
        iosAlertMessage: "Approchez le tag à programmer de l'appareil",
      );

      try {
        await _writeDataToTag(tag, data);
        onSuccess?.call();
      } catch (e) {
        onError?.call('Erreur lors de l\'écriture: $e');
      } finally {
        await FlutterNfcKit.finish();
      }
    } catch (e) {
      onError?.call('Erreur lors de l\'écriture NFC: $e');
      await FlutterNfcKit.finish();
    }
  }

  Future<String> _extractTagData(NFCTag tag) async {
    try {
      if (tag.ndefAvailable == true) {
        try {
          final ndefRecords = await FlutterNfcKit.readNDEFRecords();

          for (var record in ndefRecords) {
            if (record.payload!.isNotEmpty) {
              final text = String.fromCharCodes(record.payload!);
              if (text.trim().isNotEmpty) {
                return text.trim();
              }
            }
          }
        } catch (e) {
          Get.log('Erreur lecture NDEF: $e');
        }
      }

      // fallback: lecture directe
      try {
        if (tag.standard == "ISO 14443 Type A") {
          return await _readMifareData();
        }
        if (tag.standard == "ISO 14443 Type B") {
          return await _readISO14443BData();
        }
      } catch (e) {
        Get.log('Erreur lecture données brutes: $e');
      }

      return tag.id;
    } catch (e) {
      Get.log('Erreur extraction données tag: $e');
      return tag.id;
    }
  }

  // String _decodeNDEFRecord(NDEFRawRecord record) {
  //   try {
  //     if (record.payload.isEmpty) return '';

  //     // Convertir hex → bytes
  //     final payload = _hexToBytes(record.payload);
  //     final typeBytes = _hexToBytes(record.type);

  //     // Cas texte ("T" = 0x54)
  //     if (typeBytes.isNotEmpty && typeBytes[0] == 0x54) {
  //       if (payload.length > 3) {
  //         final statusByte = payload[0];
  //         final langLength = statusByte & 0x3F;
  //         final textStart = 1 + langLength;
  //         if (payload.length > textStart) {
  //           return utf8.decode(payload.sublist(textStart));
  //         }
  //       }
  //     }

  //     // Cas URI ("U" = 0x55)
  //     if (typeBytes.isNotEmpty && typeBytes[0] == 0x55) {
  //       if (payload.isNotEmpty) {
  //         final prefixCode = payload[0];
  //         final uriPart = utf8.decode(payload.sublist(1));
  //         return _getURIPrefix(prefixCode) + uriPart;
  //       }
  //     }

  //     // Sinon → essai brut
  //     return utf8.decode(payload, allowMalformed: true);
  //   } catch (e) {
  //     Get.log('Erreur décodage record: $e');
  //     return '';
  //   }
  // }

  /// Lit les données d'une carte Mifare
  Future<String> _readMifareData() async {
    try {
      String allData = '';

      // Essayer de lire plusieurs blocs de données (4 à 15)
      for (int block = 4; block < 16; block++) {
        try {
          // Commande READ pour Mifare Ultralight
          final blockHex = block.toRadixString(16).padLeft(2, '0').toUpperCase();
          final response = await FlutterNfcKit.transceive("30$blockHex");

          if (response.isNotEmpty && response != "00000000000000000000000000000000") {
            final blockData = _hexToString(response);
            if (blockData.trim().isNotEmpty) {
              allData += blockData.trim();
            }
          }
        } catch (e) {
          // Continuer avec le bloc suivant si échec
          continue;
        }
      }

      return allData.isNotEmpty ? allData : '';
    } catch (e) {
      Get.log('Erreur lecture Mifare: $e');
      return '';
    }
  }

  /// Lit les données d'une carte ISO14443-B
  Future<String> _readISO14443BData() async {
    try {
      // Commande SELECT pour ISO14443-B
      final response = await FlutterNfcKit.transceive("00A404000E325041592E5359532E4444463031");
      return _hexToString(response);
    } catch (e) {
      Get.log('Erreur lecture ISO14443-B: $e');
      return '';
    }
  }

  /// helper: convert bytes -> hex string (no 0x, lowercase/uppercase ok)
  String _bytesToHex(List<int> bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  /// helper: convert hex string -> bytes
  // List<int> _hexToBytes(String hex) {
  //   final cleaned = hex.replaceAll(RegExp(r'[^0-9a-fA-F]'), '');
  //   final bytes = <int>[];
  //   for (var i = 0; i < cleaned.length; i += 2) {
  //     final byte = int.parse(cleaned.substring(i, i + 2), radix: 16);
  //     bytes.add(byte);
  //   }
  //   return bytes;
  // }

  /// Crée le payload NDEF "Text" (status + lang + texte) -> List<int>
  List<int> _createSimpleTextPayloadBytes(String text, {String lang = 'en'}) {
    final languageBytes = utf8.encode(lang);
    final textBytes = utf8.encode(text);
    final status = languageBytes.length; // status byte: longueur du code langue
    final payload = <int>[];
    payload.add(status);
    payload.addAll(languageBytes);
    payload.addAll(textBytes);
    return payload;
  }

  /// Méthode corrigée pour écrire un record texte NDEF sur le tag
  Future<void> _writeDataToTag(NFCTag tag, String data) async {
    try {
      if (tag.ndefWritable == true) {
        // 1) créer les bytes du payload texte
        final payloadBytes = _createSimpleTextPayloadBytes(data);

        // 2) convertir en hex string (champ attendu par NDEFRawRecord)
        final payloadHex = _bytesToHex(payloadBytes); // ex: "02656e48656c6c6f"
        final typeHex = _bytesToHex([0x54]); // 'T' -> "54"
        final identifierHex = ''; // vide si pas d'identifiant

        // 3) Construire le NDEFRawRecord (positional args)
        // Utilise ndef.TypeNameFormat.wellKnown si importé via package:ndef
        final record = NDEFRawRecord(
          identifierHex, // String hex (vide si none)
          payloadHex, // payload en hex string
          typeHex, // type en hex string ("54")
          ndef.TypeNameFormat.nfcWellKnown, // TypeNameFormat (wellKnown pour les records 'T')
        );

        // 4) écrire
        await FlutterNfcKit.writeNDEFRawRecords([record]);
      } else {
        // si pas NDEF writable -> fallback (Mifare, etc.)
        if ((tag.standard).toLowerCase().contains('iso 14443')) {
          await _writeMifareData(data); // ta méthode existante
        } else {
          throw Exception('Type de tag non supporté pour l\'écriture');
        }
      }
    } catch (e) {
      throw Exception('Erreur lors de l\'écriture: $e');
    }
  }

  /// Crée le payload pour un record texte NDEF
  // List<int> _createNDEFTextPayload(String text) {
  //   final languageCode = 'en';
  //   final languageCodeBytes = utf8.encode(languageCode);
  //   final textBytes = utf8.encode(text);

  //   final payload = <int>[];
  //   payload.add(languageCodeBytes.length); // Status byte
  //   payload.addAll(languageCodeBytes);
  //   payload.addAll(textBytes);

  //   return payload;
  // }

  /// Écrit des données sur une carte Mifare
  Future<void> _writeMifareData(String data) async {
    final bytes = utf8.encode(data);

    // Écrire par blocs de 4 bytes pour Mifare Ultralight
    for (int i = 0; i < bytes.length; i += 4) {
      final blockNumber = 4 + (i ~/ 4); // Commencer au bloc 4
      if (blockNumber > 15) break; // Limite des blocs utilisateur

      final blockData = <int>[];
      for (int j = 0; j < 4; j++) {
        if (i + j < bytes.length) {
          blockData.add(bytes[i + j]);
        } else {
          blockData.add(0); // Padding
        }
      }

      final hexData = blockData.map((b) => b.toRadixString(16).padLeft(2, '0')).join('').toUpperCase();
      final blockHex = blockNumber.toRadixString(16).padLeft(2, '0').toUpperCase();

      await FlutterNfcKit.transceive("A2$blockHex$hexData");
    }
  }

  /// Convertit une chaîne hex en string
  String _hexToString(String hex) {
    try {
      hex = hex.replaceAll(' ', ''); // Supprimer les espaces
      final bytes = <int>[];

      for (int i = 0; i < hex.length; i += 2) {
        if (i + 1 < hex.length) {
          final hexByte = hex.substring(i, i + 2);
          final byte = int.tryParse(hexByte, radix: 16);
          if (byte != null && byte > 31 && byte < 127) {
            // Caractères imprimables
            bytes.add(byte);
          }
        }
      }

      return String.fromCharCodes(bytes);
    } catch (e) {
      Get.log('Erreur conversion hex: $e');
      return '';
    }
  }

  /// Obtient le préfixe URI selon le code
  // String _getURIPrefix(int code) {
  //   const uriPrefixes = {
  //     0x00: '',
  //     0x01: 'http://www.',
  //     0x02: 'https://www.',
  //     0x03: 'http://',
  //     0x04: 'https://',
  //     0x05: 'tel:',
  //     0x06: 'mailto:',
  //   };
  //   return uriPrefixes[code] ?? '';
  // }

  /// Parse les données d'authentification depuis un tag NFC
  /// Format attendu: "email:password" ou JSON {"email":"...", "password":"..."}
  Map<String, String>? parseAuthData(String tagData) {
    try {
      // Nettoyer les données
      tagData = tagData.trim();

      // Format simple: "email:password"
      if (tagData.contains(':') && !tagData.startsWith('{')) {
        final parts = tagData.split(':');
        if (parts.length >= 2) {
          return {
            'email': parts[0].trim(),
            'password': parts.sublist(1).join(':').trim(),
          };
        }
      }

      // Format JSON
      if (tagData.startsWith('{') && tagData.endsWith('}')) {
        try {
          final Map<String, dynamic> jsonData = jsonDecode(tagData);
          if (jsonData.containsKey('email') && jsonData.containsKey('password')) {
            return {
              'email': jsonData['email'].toString(),
              'password': jsonData['password'].toString(),
            };
          }
        } catch (e) {
          Get.log('Erreur parsing JSON: $e');
        }
      }

      // Format base64 encodé
      try {
        final decoded = base64Decode(tagData);
        final decodedString = utf8.decode(decoded);
        return parseAuthData(decodedString);
      } catch (e) {
        // Pas du base64 valide, continuer
      }

      return null;
    } catch (e) {
      Get.log('Erreur lors du parsing des données d\'auth: $e');
      return null;
    }
  }

  /// Encode les données d'authentification pour un tag NFC
  String encodeAuthData({
    required String email,
    required String password,
    String format = 'simple',
  }) {
    switch (format.toLowerCase()) {
      case 'json':
        final jsonData = {
          'email': email,
          'password': password,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };
        return jsonEncode(jsonData);

      case 'base64':
        final simpleFormat = '$email:$password';
        return base64Encode(utf8.encode(simpleFormat));

      case 'simple':
      default:
        return '$email:$password';
    }
  }

  /// Valide si les données du tag sont cohérentes
  bool validateTagData(String tagData) {
    if (tagData.isEmpty) return false;

    final authData = parseAuthData(tagData);
    if (authData == null) return false;

    final email = authData['email'];
    final password = authData['password'];

    return email != null && email.isNotEmpty && password != null && password.isNotEmpty && email.contains('@');
  }

  /// Démarre une session de lecture avec des paramètres par défaut pour l'authentification
  Future<void> startAuthenticationReading({
    required Function(Map<String, String> authData) onAuthDataDetected,
    Function(String error)? onError,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    await startNFCReading(
      onTagDetected: (tagData) {
        if (validateTagData(tagData)) {
          final authData = parseAuthData(tagData);
          if (authData != null) {
            onAuthDataDetected(authData);
          } else {
            onError?.call('Données d\'authentification invalides sur le tag');
          }
        } else {
          onError?.call('Format de tag non reconnu pour l\'authentification');
        }
      },
      onError: onError,
      timeout: timeout,
    );
  }

  /// Crée un tag d'authentification avec les credentials
  Future<void> createAuthenticationTag({
    required String email,
    required String password,
    String format = 'simple',
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    final encodedData = encodeAuthData(
      email: email,
      password: password,
      format: format,
    );

    await writeNFCTag(
      data: encodedData,
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  /// Lit les informations d'un tag sans traitement spécifique
  Future<Map<String, dynamic>> getTagInfo() async {
    try {
      final tag = await FlutterNfcKit.poll();

      return {
        'id': tag.id,
        'standard': tag.standard,
        'type': tag.type,
        'atqa': tag.atqa ?? '',
        'sak': tag.sak ?? '',
        'historicalBytes': tag.historicalBytes ?? '',
        'protocolInfo': tag.protocolInfo ?? {},
        'ndefAvailable': tag.ndefAvailable ?? false,
        'ndefType': tag.ndefType ?? '',
        'ndefWritable': tag.ndefWritable ?? false,
        'ndefCanMakeReadOnly': tag.ndefCanMakeReadOnly ?? false,
        'ndefCapacity': tag.ndefCapacity ?? 0,
      };
    } catch (e) {
      throw Exception('Erreur lors de la lecture des infos du tag: $e');
    } finally {
      await FlutterNfcKit.finish();
    }
  }

  /// Écrit des données texte simples avec l'API simplifiée
  Future<void> writeSimpleText(String text) async {
    try {
      final tag = await FlutterNfcKit.poll(
        iosAlertMessage: "Approchez le tag à programmer",
      );

      if (tag.ndefWritable == true) {
        // payload en bytes puis hex string
        final payloadBytes = _createSimpleTextPayloadBytes(text);
        final payloadHex = _bytesToHex(payloadBytes);

        // type 'T' (Text record) en hex
        final typeHex = _bytesToHex([0x54]); // => "54"

        // construire le record NDEF
        final record = NDEFRawRecord(
          "", // identifier vide
          payloadHex,
          typeHex,
          ndef.TypeNameFormat.nfcWellKnown,
        );

        // écrire
        await FlutterNfcKit.writeNDEFRawRecords([record]);
      } else {
        throw Exception('Tag non écritable');
      }
    } catch (e) {
      throw Exception('Erreur écriture texte simple: $e');
    } finally {
      await FlutterNfcKit.finish();
    }
  }

  // /// Crée un payload texte simple
  // List<int> _createSimpleTextPayload(String text) {
  //   final languageCode = 'en';
  //   final payload = <int>[];

  //   payload.add(languageCode.length); // Longueur du code langue
  //   payload.addAll(languageCode.codeUnits); // Code langue
  //   payload.addAll(utf8.encode(text)); // Texte

  //   return payload;
  // }

  /// Version simplifiée pour écrire seulement du texte
  Future<void> writeTextOnly({
    required String text,
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    try {
      bool isAvailable = await isNFCAvailable();
      if (!isAvailable) {
        onError?.call('NFC non disponible sur cet appareil');
        return;
      }

      await writeSimpleText(text);
      onSuccess?.call();
    } catch (e) {
      onError?.call('Erreur lors de l\'écriture: $e');
    }
  }

  /// Lit seulement le texte d'un tag NDEF
  Future<void> readTextOnly({
    required Function(String text) onTextDetected,
    Function(String error)? onError,
    Duration? timeout,
  }) async {
    await startNFCReading(
      onTagDetected: (tagData) {
        onTextDetected(tagData);
      },
      onError: onError,
      timeout: timeout,
    );
  }
}
