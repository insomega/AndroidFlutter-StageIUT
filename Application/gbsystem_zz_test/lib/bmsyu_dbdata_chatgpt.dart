// gb_system_data.dart
import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';

/// -----------------------------
/// Utilitaires (à remplacer si besoin)
/// -----------------------------
void addLogEvent(String file, String fn, Object error) {
  // Placeholder: remplace par ta journalisation réelle
  print('[LOG] $file::$fn -> $error');
}

/// Convertit Map <-> query string (simple)
String mapToParam(Map<String, dynamic> m) {
  if (m.isEmpty) return '';
  return m.entries.map((e) => '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent('${e.value}')}').join('&');
}

Map<String, String> paramToMap(String param) {
  if (param.isEmpty) return {};
  try {
    return Uri.splitQueryString(param);
  } catch (e) {
    return {};
  }
}

/// Récupère une "variante" simulée
dynamic getVariantResponse(String name) {
  // Placeholder : remplace par ta fonction réelle qui extrait `str_BinaryData` etc.
  // Exemple : renvoyer un JSON d'exemple si besoin.
  return null;
}

/// Placeholder pour send_request (appel serveur).
/// Doit accepter une structure similaire au 'Sender' JS : { act_uid, exchange, bm_complete, ... }
Future<void> sendRequest(Map<String, dynamic> request) async {
  // Remplace par ta logique réseau. L'original déclenchait un appel et appelait
  // bm_complete(...) à la fin.
  // Ici on simule une réponse vide pour permettre le flow local.
  await Future.delayed(Duration(milliseconds: 50));
  final callback = request['bm_complete'];
  if (callback != null && callback is Function) {
    callback([], null);
  }
}

/// Valeur globale utilisée dans le JS
String? ind_Indicateur_Type_Heures;

/// -----------------------------
/// Sender class (équivalent de "Sender" JS)
/// -----------------------------
class Sender {
  String? actUid;
  String objectName;
  String? actionName;
  String? serverName;
  String exchange; // query string ($.param in JS)
  bool? LoadDataFromServer;
  Function? bmComplete; // fonction de callback JS
  Function? SenderComplete; // équivalent
  Function? filterLocal; // fonction locale de filtrage
  bool? isMainLookup;
  bool? isAllData;
  bool? isCodeLib;
  bool? treeGrid;
  List<dynamic>? masterObjects;
  String? ZoomPrefix;
  String? TIdb_Key;
  dynamic ClientData;
  dynamic BinaryData;
  dynamic Pageinfo;
  String? USRLD_LOAD_DATE;
  Function? senderComplete; // alternative

  Sender({required this.objectName, this.exchange = '', this.actionName, this.serverName, this.actUid, this.LoadDataFromServer, this.bmComplete, this.filterLocal, this.isMainLookup, this.isAllData, this.isCodeLib, this.treeGrid, this.masterObjects, this.ZoomPrefix});
}

/// -----------------------------
/// GBSystemData (traduction complète)
/// -----------------------------
class GBSystemData {
  // Constants
  static const String ENTITY_DATA_NAME = 'EntityData_Name';
  static const String TIDB_ENTITY_DATA = 'TIDB_EntityData';
  static const String TIDB_BINARY_DATA = 'TIDB_BinaryData';
  static const String TIDB_PHOTO_DATA = 'TIDB_PhotoData';
  static const String TIDB_SYSTEM = 'TIDB_System';
  static const String TIDB_SERVERDB = 'TIDB_ServerDB';
  static const String CNX_DB = 'cnx';

  // Internal state
  String usrUid = '';
  String dosUid = '';
  String usrCode = '';
  String dbType = '';
  bool isIdbActive = true;
  bool isCnxMode = false;

  // Hive boxes (server name depends on user)
  Box? entityBox;
  Box? binaryBox;
  Box? photoBox;
  Box? systemBox;
  Box? serverDBBox; // stockage TIDB_ServerDB

  // Singleton
  static final GBSystemData _instance = GBSystemData._internal();
  factory GBSystemData() => _instance;
  GBSystemData._internal();

  static GBSystemData get instance => _instance;

  /// -----------------------------
  /// GBSDataBase_Info (construit la config 'server' similaire au JS)
  /// -----------------------------
  String getServerNameFromInfo() {
    // original: server: `BMDataBase_${usr_uid}_${dos_uid}` or using usr_code
    if (usrCode.isNotEmpty) {
      return 'BMDataBase_${usrCode}_C8827F48FFFE4462AC86E9D8CEA0617C';
    }
    return 'BMDataBase_${usrUid}_${dosUid}';
  }

  /// Ouvrir/initialiser les boxes Hive selon le server name
  Future<void> _openBoxes() async {
    try {
      final serverName = getServerNameFromInfo();
      entityBox = await Hive.openBox('${serverName}_$TIDB_ENTITY_DATA');
      binaryBox = await Hive.openBox('${serverName}_$TIDB_BINARY_DATA');
      photoBox = await Hive.openBox('${serverName}_$TIDB_PHOTO_DATA');
      systemBox = await Hive.openBox('${serverName}_$TIDB_SYSTEM');
      serverDBBox = await Hive.openBox('${serverName}_$TIDB_SERVERDB');
    } catch (e, st) {
      addLogEvent('gb_system_data.dart', '_openBoxes', '$e\n$st');
      rethrow;
    }
  }

  /// Fermeture / suppression des boxes (Delete_DBConnection)
  Future<bool> deleteDBConnection() async {
    try {
      final serverName = getServerNameFromInfo();
      // close and delete boxes if exist
      if (Hive.isBoxOpen('${serverName}_$TIDB_ENTITY_DATA')) {
        await Hive.box('${serverName}_$TIDB_ENTITY_DATA').close();
        await Hive.deleteBoxFromDisk('${serverName}_$TIDB_ENTITY_DATA');
      }
      if (Hive.isBoxOpen('${serverName}_$TIDB_BINARY_DATA')) {
        await Hive.box('${serverName}_$TIDB_BINARY_DATA').close();
        await Hive.deleteBoxFromDisk('${serverName}_$TIDB_BINARY_DATA');
      }
      if (Hive.isBoxOpen('${serverName}_$TIDB_PHOTO_DATA')) {
        await Hive.box('${serverName}_$TIDB_PHOTO_DATA').close();
        await Hive.deleteBoxFromDisk('${serverName}_$TIDB_PHOTO_DATA');
      }
      if (Hive.isBoxOpen('${serverName}_$TIDB_SYSTEM')) {
        await Hive.box('${serverName}_$TIDB_SYSTEM').close();
        await Hive.deleteBoxFromDisk('${serverName}_$TIDB_SYSTEM');
      }
      if (Hive.isBoxOpen('${serverName}_$TIDB_SERVERDB')) {
        await Hive.box('${serverName}_$TIDB_SERVERDB').close();
        await Hive.deleteBoxFromDisk('${serverName}_$TIDB_SERVERDB');
      }
      return true;
    } catch (errorMessage) {
      addLogEvent('bmsyu_dbdata.js', 'Delete_DBConnection', errorMessage);
      return false;
    }
  }

  /// Get ServerDB reference (Boxes aggregated)
  Map<String, Box?> getServerDB() {
    return {'TIDB_EntityData': entityBox, 'TIDB_BinaryData': binaryBox, 'TIDB_PhotoData': photoBox, 'TIDB_System': systemBox, 'TIDB_ServerDB': serverDBBox};
  }

  /// Active DB connection (Active_DBConnection)
  Future<bool> activeDBConnection() async {
    try {
      if (!isIdbActive) return false;
      if ((dosUid.isNotEmpty && usrUid.isNotEmpty) || usrCode.isNotEmpty) {
        // open hive boxes
        await _openBoxes();
        // if not in connection mode, check user local data
        if (!isCnxMode) {
          await checkUserLocalData();
        }
        return true;
      }
      return false;
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Active_DBConnection', err);
      return false;
    }
  }

  /// Activate_DBData (Activate_DBData in JS)
  Future<bool> activateDBData(String aDOS_UIDF, String aUSR_UIDF) async {
    try {
      if (aDOS_UIDF.isNotEmpty && aUSR_UIDF.isNotEmpty) {
        usrUid = aUSR_UIDF.replaceAll(RegExp(r'[-{}]'), '');
        dosUid = aDOS_UIDF.replaceAll(RegExp(r'[-{}]'), '');
        return await activeDBConnection();
      }
      return false;
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Activate_DBData', err);
      return false;
    }
  }

  /// Activate_DBData_Cxn (mode connexion)
  Future<bool> activateDBDataCxn(String aUSR_Code) async {
    try {
      isCnxMode = true;
      if (aUSR_Code.isNotEmpty) {
        usrCode = aUSR_Code.toLowerCase();
        dbType = CNX_DB;
        return await activeDBConnection();
      }
      return false;
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Activate_DBData_Cxn', err);
      return false;
    }
  }

  /// Delete_DBData (utilise deleteDBConnection)
  Future<bool> deleteDBData() async {
    try {
      return await deleteDBConnection();
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Delete_DBData', err);
      return false;
    }
  }

  /// -----------------------------
  /// Get entity key (Get_EntityData_Key)
  /// -----------------------------
  String getEntityDataKey(Sender sender) {
    try {
      String objectNameEntityData = '';
      final exchangeMap = paramToMap(sender.exchange);

      if (sender.actUid != null && sender.actUid!.isNotEmpty) {
        objectNameEntityData = sender.actUid!;
      } else {
        // logic mapped from JS switch cases
        if (sender.serverName == 'Parameters') {
          objectNameEntityData = sender.objectName;
        } else {
          switch (sender.objectName) {
            case 'Serveur_int':
              objectNameEntityData = 'SVR__${exchangeMap['svr_type'] ?? ''}';
              break;
            case 'System_Hour_Type':
            case 'hour_type':
              objectNameEntityData = 'TPH__${exchangeMap['TPH_FILTER'] ?? ''}';
              break;
            case 'Home_Indicateur':
              objectNameEntityData = 'INDHome__${exchangeMap['IND_NAME'] ?? ''}';
              // ajouter l'IDF si nécessaire
              if (exchangeMap['IND_NAME'] == ind_Indicateur_Type_Heures) {
                objectNameEntityData += '_${exchangeMap['KPI_TPH_IDF'] ?? ''}';
              }
              break;
            case 'lieu_int':
              objectNameEntityData = 'lieu_int__${exchangeMap['title'] ?? ''}';
              break;
            default:
              objectNameEntityData = sender.objectName;
              break;
          }
        }

        if (sender.actionName != null && sender.actionName!.toLowerCase() == 'select_all_data') {
          objectNameEntityData += '__all_data';
        }
      }

      if (exchangeMap.containsKey('LDB_NAME') && (exchangeMap['LDB_NAME'] ?? '') != '') {
        objectNameEntityData = exchangeMap['LDB_NAME']!;
      }

      if (objectNameEntityData.isNotEmpty) {
        // mettre à jour LDB_NAME
        final newExchange = Map<String, String>.from(exchangeMap);
        newExchange['LDB_NAME'] = objectNameEntityData;
        sender.exchange = mapToParam(newExchange);
      }

      sender.TIdb_Key = objectNameEntityData;
      return objectNameEntityData;
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Get_EntityData_Key', err);
      return '';
    }
  }

  /// -----------------------------
  /// Get_EntityData_Data (lecture)
  /// -----------------------------
  Future<void> getEntityDataData(Sender sender) async {
    try {
      if (!isIdbActive || (sender.LoadDataFromServer ?? false)) {
        // on demande au serveur
        final request = {'sender': sender, 'exchange': sender.exchange, 'bm_complete': sender.bmComplete};
        await sendRequest(request);
        return;
      }

      final key = getEntityDataKey(sender);
      if (entityBox == null) {
        addLogEvent('bmsyu_dbdata.js', 'Get_EntityData_Data', 'entityBox is null');
        // fallback to server
        await sendRequest({'sender': sender, 'exchange': sender.exchange, 'bm_complete': sender.bmComplete});
        return;
      }

      final item = entityBox!.get(key);
      sender.SenderComplete = sender.bmComplete; // store
      if (item == null) {
        // pas en local -> demander au serveur et enregistrer via Set_EntityData
        // on passe la callback Set_EntityData via sender.bmComplete = Set_EntityData
        // simulate: set a marker to process after server response
        // En JS: Sender.bm_complete = Set_EntityData; send_request(Sender);
        // Ici: on appelle sendRequest et attend que la réponse appelle setEntityData
        await sendRequest({
          'sender': sender,
          'exchange': sender.exchange,
          'bm_complete': (dynamic data, dynamic error) async {
            // data attendu depuis le serveur -> remplir sender.ClientData et appeler setEntityData
            sender.ClientData = data;
            await setEntityData(sender);
          },
        });
      } else {
        // found locally
        sender.ClientData = item['ClientData'];
        sender.USRLD_LOAD_DATE = item['USRLD_LOAD_DATE'];
        setEntityDataCallback(sender);
      }
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Get_EntityData_Data', err);
    }
  }

  /// -----------------------------
  /// Set_EntityData_CallBack
  /// -----------------------------
  void setEntityDataCallback(Sender sender) {
    try {
      dynamic requestData = sender.ClientData;
      // si la structure a rows
      if (requestData is Map && requestData['rows'] is List) {
        requestData = requestData['rows'];
      }

      // Appliquer filtrages masterObjects
      if (sender.masterObjects != null && sender.masterObjects!.isNotEmpty) {
        var filtered = <dynamic>[];
        for (var r in (requestData is List ? requestData : [requestData])) {
          bool ok = true;
          for (var master in sender.masterObjects!) {
            // master attendu comme { field: 'X', value: 'Y', isRequired: bool, NullValues: bool }
            final field = master['field'];
            final value = master['value'];
            final isRequired = master['isRequired'] ?? false;
            final nullValues = master['NullValues'] ?? false;
            final recordValue = (r is Map && r.containsKey(field)) ? r[field] : null;

            if (value != '' && recordValue != value) ok = false;
            if (value == '' && isRequired) ok = false;
            if (nullValues && (recordValue == '')) ok = ok || true;
          }
          if (ok) filtered.add(r);
        }
        requestData = filtered;
      }

      // filterLocal callback
      if (sender.filterLocal != null) {
        try {
          requestData = sender.filterLocal!(requestData);
        } catch (e) {
          // ignore filter error
        }
      }

      final dataSelected = requestData;
      // call the original complete
      if (sender.SenderComplete != null && sender.SenderComplete is Function) {
        try {
          (sender.SenderComplete as Function)(dataSelected, null, sender);
        } catch (e) {
          // fallback try other
          try {
            sender.bmComplete?.call(dataSelected, null, sender);
          } catch (e2) {}
        }
      } else if (sender.bmComplete != null) {
        try {
          sender.bmComplete!(dataSelected, null, sender);
        } catch (e) {}
      } else if (sender.senderComplete != null) {
        try {
          sender.senderComplete!(dataSelected);
        } catch (e) {}
      }
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Set_EntityData_CallBack', err);
    }
  }

  /// -----------------------------
  /// Set_EntityData (enregistre en local + serverDB)
  /// -----------------------------
  Future<void> setEntityData(Sender sender) async {
    try {
      if (sender.TIdb_Key == null || sender.TIdb_Key!.isEmpty) {
        getEntityDataKey(sender); // calcule TIdb_Key si nécessaire
      }
      final usrld = getUSRLD_IDF();
      if (usrld != null && usrld is Map && usrld.isNotEmpty) {
        // store reference in serverDB
        final serverEntry = {'EntityData_Name': usrld['USRLD_IDF'], 'Value': sender.TIdb_Key, 'TableName': TIDB_ENTITY_DATA};
        await serverDBBox?.put(usrld['USRLD_IDF'], serverEntry);

        // store entity data
        final dataToStore = {'EntityData_Name': sender.TIdb_Key, 'ClientData': sender.ClientData, 'USRLD_IDF': usrld['USRLD_IDF'], 'USRLD_LOAD_DATE': usrld['USRLD_LOAD_DATE'] ?? ''};
        await entityBox?.put(sender.TIdb_Key, dataToStore);
        sender.USRLD_LOAD_DATE = usrld['USRLD_LOAD_DATE'];
        setEntityDataCallback(sender);
      } else {
        // pas d'USRLD -> callback quand même
        setEntityDataCallback(sender);
      }
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Set_EntityData', err);
    }
  }

  /// -----------------------------
  /// Delete_EntityData
  /// -----------------------------
  Future<void> deleteEntityData(Sender sender) async {
    try {
      if (!isIdbActive) {
        throw Exception('Is Idb inactive');
      }
      final key = getEntityDataKey(sender);
      final item = entityBox?.get(key);
      if (item != null) {
        await entityBox?.delete(item['EntityData_Name']);
        // delete serverdb record linked
        final usrlIdf = item['USRLD_IDF'];
        if (usrlIdf != null) {
          await serverDBBox?.delete(usrlIdf);
        }
      }
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Delete_EntityData', err);
    }
  }

  /// -----------------------------
  /// loadPagesWithDAccess (Binary/Pages)
  /// -----------------------------
  Future<void> loadPagesWithDAccess(Sender sender) async {
    try {
      if (!isIdbActive) {
        // fallback to server
        await sendRequest({'sender': sender, 'exchange': sender.exchange, 'bm_complete': sender.bmComplete});
        return;
      }

      final exchange = paramToMap(sender.exchange);
      // TIdb_Key derived by filename in bmsyu_objet
      final bmsyuObj = exchange['bmsyu_objet'] ?? '';
      final key = bmsyuObj.replaceAll(RegExp(r'^.*[\\\/]'), '').replaceAll('.', '_');
      sender.TIdb_Key = key;

      final item = binaryBox?.get(sender.TIdb_Key);
      sender.SenderComplete = sender.bmComplete;
      if (item == null) {
        // request server then Set_BinaryData
        await sendRequest({
          'sender': sender,
          'exchange': sender.exchange,
          'bm_complete': (dynamic data, dynamic error) async {
            // server returns binary content? simulate
            sender.ClientData = data;
            await setBinaryData(sender);
          },
        });
      } else {
        sender.ClientData = item['ClientData'];
        sender.BinaryData = item['BinaryData'];
        sender.Pageinfo = item['Pageinfo'];
        sender.USRLD_LOAD_DATE = item['USRLD_LOAD_DATE'];
        setDBDataCallback(sender);
      }
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'loadPagesWithDAccess', err);
    }
  }

  /// -----------------------------
  /// Do_Fetch_links - version adaptée (pas de DOM dans Flutter)
  /// -----------------------------
  Future<Sender> doFetchLinks(Sender sender) async {
    try {
      // Dans le code JS, on parse le HTML et cherche <link> et <script> et les stocke.
      // Ici on renvoie sender tel quel — si tu veux récupérer des ressources,
      // tu dois implémenter un parser HTML côté Web ou effectuer des appels réseau.
      return sender;
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Do_Fetch_links', err);
      return sender;
    }
  }

  /// -----------------------------
  /// Set_BinaryData
  /// -----------------------------
  Future<void> setBinaryData(Sender sender) async {
    try {
      // équivalents JS: Sender.BinaryData = get_variant_response(str_BinaryData);
      // Sender.Pageinfo = get_variant_response(rs_pageinfo);
      // puis stocke en TIDB_BinaryData
      final binaryData = sender.BinaryData ?? getVariantResponseOr(sender, 'str_BinaryData');
      final pageInfo = sender.Pageinfo ?? getVariantResponseOr(sender, 'rs_pageinfo');
      final usrld = getUSRLD_IDF();

      if (usrld != null && usrld is Map && usrld.isNotEmpty) {
        final serverEntry = {'EntityData_Name': usrld['USRLD_IDF'], 'Value': sender.TIdb_Key, 'TableName': TIDB_BINARY_DATA};
        await serverDBBox?.put(usrld['USRLD_IDF'], serverEntry);

        final dataToStore = {'EntityData_Name': sender.TIdb_Key, 'ClientData': sender.ClientData, 'BinaryData': binaryData, 'Pageinfo': pageInfo, 'USRLD_IDF': usrld['USRLD_IDF'], 'USRLD_LOAD_DATE': usrld['USRLD_LOAD_DATE'] ?? ''};

        await binaryBox?.put(sender.TIdb_Key, dataToStore);
        setDBDataCallback(sender);
      } else {
        setDBDataCallback(sender);
      }
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Set_BinaryData', err);
    }
  }

  dynamic getVariantResponseOr(Sender sender, String name) {
    try {
      final v = getVariantResponse(name);
      return v ?? (name == 'str_BinaryData' ? '' : null);
    } catch (err) {
      return null;
    }
  }

  /// -----------------------------
  /// Set_PhotoData
  /// -----------------------------
  Future<void> setPhotoData(Sender sender) async {
    try {
      final binaryData = getVariantResponse('str_BinaryData');
      final usrld = getUSRLD_IDF();

      if (usrld != null && usrld is Map && usrld.isNotEmpty) {
        final serverEntry = {'EntityData_Name': usrld['USRLD_IDF'], 'Value': sender.TIdb_Key, 'TableName': TIDB_PHOTO_DATA};
        await serverDBBox?.put(usrld['USRLD_IDF'], serverEntry);

        final dataToStore = {'EntityData_Name': sender.TIdb_Key, 'ClientData': sender.ClientData, 'BinaryData': binaryData, 'USRLD_IDF': usrld['USRLD_IDF'], 'USRLD_LOAD_DATE': usrld['USRLD_LOAD_DATE'] ?? ''};

        await photoBox?.put(sender.TIdb_Key, dataToStore);
        sender.BinaryData = binaryData;
        setDBDataCallback(sender);
      } else {
        sender.BinaryData = binaryData;
        setDBDataCallback(sender);
      }
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'SetPhotoData', err);
    }
  }

  /// -----------------------------
  /// loadPhotoData
  /// -----------------------------
  Future<void> loadPhotoData(Sender sender) async {
    try {
      final item = photoBox?.get(sender.TIdb_Key);
      sender.SenderComplete = sender.bmComplete;
      if (item == null) {
        // ask server -> SetPhotoData afterwards
        await sendRequest({
          'sender': sender,
          'exchange': sender.exchange,
          'bm_complete': (dynamic data, dynamic error) async {
            sender.ClientData = data;
            await setPhotoData(sender);
          },
        });
      } else {
        sender.ClientData = item['ClientData'];
        sender.BinaryData = item['BinaryData'];
        setDBDataCallback(sender);
      }
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'loadPhotoData', err);
    }
  }

  /// -----------------------------
  /// Set_DBData_CallBack
  /// -----------------------------
  void setDBDataCallback(Sender sender) {
    try {
      if (sender.SenderComplete != null && sender.SenderComplete is Function) {
        try {
          (sender.SenderComplete as Function)(sender);
          return;
        } catch (e) {
          // ignore
        }
      }
      // fallback
      sender.bmComplete?.call(sender);
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Set_DBData_CallBack', err);
    }
  }

  /// -----------------------------
  /// Check_User_Local_Data
  /// -----------------------------
  Future<void> checkUserLocalData() async {
    try {
      // If no DB_NAME in system, call server with act_uid D9030B97...
      final dataItem = systemBox?.get('DB_NAME');
      final exch = {'DB_NAME': (dataItem != null) ? dataItem : ''};

      await sendRequest({
        'act_uid': "D9030B97DAA4430299DD33E269EC95EB",
        'exchange': mapToParam(exch),
        'bm_complete': (dynamic data, dynamic error) async {
          if (dataItem != null && dataItem != '') {
            // possible refresh
          } else {
            if (data is List && data.isNotEmpty && data[0]['DB_NAME'] != null) {
              final d = data[0]['DB_NAME'];
              await systemBox?.put('DB_NAME', d);
            }
          }
          // After use local data
          afterUseLocalData();
        },
        'async': true,
        'is_modal': true,
      });
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Check_User_Local_Data', err);
    }
  }

  void afterUseLocalData() {
    // In JS they manipulated DOM: add class idb_active
    // Here we simply log or set a flag if needed
    // Example: systemBox?.put('__bm_localData_active', true);
    try {
      systemBox?.put('__bm_localData_active', true);
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'After_Use_localData', err);
    }
  }

  /// -----------------------------
  /// refresh_DB
  /// -----------------------------
  Future<void> refreshDB(List<dynamic>? dbLocal) async {
    if (dbLocal == null || dbLocal.isEmpty) return;
    for (var elm in dbLocal) {
      final usrld = elm['USRLD_IDF'];
      if (usrld == '0') {
        initialiseDB();
      } else {
        await deleteEntityDataByServerId(usrld);
      }
    }
  }

  /// -----------------------------
  /// delete_EntityData_By_ServerId
  /// -----------------------------
  Future<void> deleteEntityDataByServerId(String USRLD_IDF) async {
    if (USRLD_IDF.isEmpty) return;
    final dataItem = serverDBBox?.get(USRLD_IDF);
    if (dataItem != null) {
      final tableName = dataItem['TableName'];
      final value = dataItem['Value'];
      switch (tableName) {
        case TIDB_ENTITY_DATA:
          await entityBox?.delete(value);
          break;
        case TIDB_BINARY_DATA:
          await binaryBox?.delete(value);
          break;
        case TIDB_PHOTO_DATA:
          await photoBox?.delete(value);
          break;
        default:
          break;
      }
      await serverDBBox?.delete(USRLD_IDF);
    }
  }

  /// -----------------------------
  /// initialise_DB
  /// -----------------------------
  Future<void> initialiseDB() async {
    try {
      await entityBox?.clear();
      await binaryBox?.clear();
      await photoBox?.clear();
      await serverDBBox?.clear();
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'initialise_DB', err);
    }
  }

  /// -----------------------------
  /// Get_USRLD_IDF (simulate reading DBLocalDS - adapt to your app)
  /// -----------------------------
  Map<String, String>? getUSRLD_IDF() {
    try {
      // in JS they used get_variant_response('DBLocalDS')
      final dbLocal = getVariantResponse('DBLocalDS');
      if (dbLocal is List && dbLocal.isNotEmpty && dbLocal[0]['USRLD_IDF'] != '') {
        return {'USRLD_IDF': dbLocal[0]['USRLD_IDF'].toString(), 'USRLD_LOAD_DATE': dbLocal[0]['USRLD_LOAD_DATE']?.toString() ?? ''};
      } else {
        if (isCnxMode) {
          return {'USRLD_IDF': '1', 'USRLD_LOAD_DATE': ''};
        }
      }
      return null;
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Get_USRLD_IDF', err);
      return null;
    }
  }

  /// -----------------------------
  /// db_is_empty
  /// -----------------------------
  Future<bool> dbIsEmpty() async {
    try {
      final eCount = await (entityBox?.length ?? 0);
      final bCount = await (binaryBox?.length ?? 0);
      final pCount = await (photoBox?.length ?? 0);
      return (eCount == 0 && bCount == 0 && pCount == 0);
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'db_is_empty', err);
      return false;
    }
  }

  /// -----------------------------
  /// Helper: set/get/delete generic wrappers
  /// -----------------------------
  Future<void> putEntity(String key, dynamic value) async {
    await entityBox?.put(key, value);
  }

  dynamic getEntity(String key) {
    return entityBox?.get(key);
  }

  Future<void> deleteEntity(String key) async {
    await entityBox?.delete(key);
  }

  Future<void> putBinary(String key, dynamic value) async {
    await binaryBox?.put(key, value);
  }

  dynamic getBinary(String key) {
    return binaryBox?.get(key);
  }

  Future<void> deleteBinary(String key) async {
    await binaryBox?.delete(key);
  }

  // expose convenience functions similar to original GBSDataBase
  Future<void> GBS_Get_EntityData_Data(Sender sender) => getEntityDataData(sender);
  Future<void> GBS_Activate_DBData(String dos, String usr) => activateDBData(dos, usr);
  Future<void> GBS_Activate_DBData_Cxn(String code) => activateDBDataCxn(code);
  Future<void> GBS_Delete_DBData() => deleteDBData();
  Future<void> GBS_Delete_EntityData(Sender sender) => deleteEntityData(sender);
  Future<void> GBS_loadPagesWithDAccess(Sender sender) => loadPagesWithDAccess(sender);
  Future<void> GBS_loadPhotoData(Sender sender) => loadPhotoData(sender);
  Future<void> GBS_initialise_DB() => initialiseDB();
  Future<void> GBS_refresh_DB(List<dynamic>? dbLocal) => refreshDB(dbLocal);

  /// -----------------------------
  /// getRefreshCode (Get_Rehresh_Code)
  /// -----------------------------
  String? getRefreshCodeFor(Sender sender) {
    try {
      final Map<String, String> refreshCodes = {"svr-svr_type=1": "297E87232C14407BB71239502CB8D166"};

      var aRefreshCode = (sender.ZoomPrefix ?? '').toLowerCase();
      final exch = paramToMap(sender.exchange);
      if (sender.exchange.isNotEmpty) {
        // if filter exists add
        if (exch.containsKey('filter') && (exch['filter'] ?? '') != '') {
          aRefreshCode = '$aRefreshCode-${(exch['filter'] ?? '').toLowerCase()}';
        }
      }
      return refreshCodes[aRefreshCode];
    } catch (err) {
      addLogEvent('bmsyu_dbdata.js', 'Get_Rehresh_Code', err);
      return null;
    }
  }
}
