import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GBSystemData {
  // Constantes
  static const String EntityData_Name = 'EntityData_Name';
  static const String TIDB_EntityData = 'TIDB_EntityData';
  static const String TIDB_BinaryData = 'TIDB_BinaryData';
  static const String TIDB_PhotoData = 'TIDB_PhotoData';
  static const String TIDB_System = 'TIDB_System';
  static const String TIDB_ServerDB = 'TIDB_ServerDB';
  static const String cnx_db = 'cnx';

  // Variables d'état
  String usr_uid = '';
  String dos_uid = '';
  String usr_code = '';
  String dbType = '';
  bool IsIdbActive = true;
  bool isCnxMode = false;

  // Base de données
  Database? _serverDB;

  // Singleton
  static final GBSystemData _instance = GBSystemData._internal();
  factory GBSystemData() => _instance;
  GBSystemData._internal();

  // Méthodes principales
  Future<void> activateDBData(String aDOS_UIDF, String aUSR_UIDF) async {
    try {
      if (aDOS_UIDF.isNotEmpty && aUSR_UIDF.isNotEmpty) {
        usr_uid = aUSR_UIDF.replaceAll(RegExp(r'[-{}]'), '');
        dos_uid = aDOS_UIDF.replaceAll(RegExp(r'[-{}]'), '');
        return await _activeDBConnection();
      }
    } catch (e) {
      _addLogEvent('activateDBData', e.toString());
      rethrow;
    }
  }

  Future<void> activateDBDataCxn(String aUSR_Code) async {
    try {
      isCnxMode = true;
      if (aUSR_Code.isNotEmpty) {
        usr_code = aUSR_Code.toLowerCase();
        dbType = cnx_db;
        return await _activeDBConnection();
      }
    } catch (e) {
      _addLogEvent('activateDBDataCxn', e.toString());
      rethrow;
    }
  }

  Future<void> deleteDBData() async {
    try {
      await _deleteDBConnection();
    } catch (e) {
      _addLogEvent('deleteDBData', e.toString());
      rethrow;
    }
  }

  Future<void> deleteEntityData(Map<String, dynamic> sender) async {
    try {
      if (!IsIdbActive) {
        throw Exception('Is Idb inactive');
      }

      final key = _getEntityDataKey(sender);
      final dataItem = await _serverDB!.query(TIDB_EntityData, where: '$EntityData_Name = ?', whereArgs: [key]);

      if (dataItem.isNotEmpty) {
        await _serverDB!.delete(TIDB_EntityData, where: '$EntityData_Name = ?', whereArgs: [key]);

        await _serverDB!.delete(TIDB_ServerDB, where: '$EntityData_Name = ?', whereArgs: [dataItem.first['USRLD_IDF']]);
      }
    } catch (e) {
      _addLogEvent('deleteEntityData', e.toString());
      rethrow;
    }
  }

  Future<void> getEntityData(Map<String, dynamic> sender) async {
    try {
      if (!IsIdbActive || sender['LoadDataFromServer'] == true) {
        _sendRequest(sender);
        return;
      }

      final key = _getEntityDataKey(sender);
      final dataItem = await _serverDB!.query(TIDB_EntityData, where: '$EntityData_Name = ?', whereArgs: [key]);

      if (dataItem.isEmpty) {
        sender['bm_complete'] = _setEntityData;
        final exchange = _deparam(sender['exchange']);
        exchange['rows'] = 0;
        sender['exchange'] = _param(exchange);
        _sendRequest(sender);
      } else {
        sender['ClientData'] = json.decode(dataItem.first['ClientData'] as String);
        sender['USRLD_LOAD_DATE'] = dataItem.first['USRLD_LOAD_DATE'];
        _setEntityDataCallBack(sender);
      }
    } catch (e) {
      _addLogEvent('getEntityData', e.toString());
      rethrow;
    }
  }

  Future<void> loadPagesWithDAccess(Map<String, dynamic> sender) async {
    try {
      if (!IsIdbActive) {
        _sendRequest(sender);
        return;
      }

      final exchange = _deparam(sender['exchange']);
      sender['TIdb_Key'] = exchange['bmsyu_objet'].replaceAll(RegExp(r'^.*[\\\/]'), '').replaceAll('.', '_');

      final dataItem = await _serverDB!.query(TIDB_BinaryData, where: '$EntityData_Name = ?', whereArgs: [sender['TIdb_Key']]);

      if (dataItem.isEmpty) {
        sender['bm_complete'] = _setBinaryData;
        if (sender['TIdb_Key'].isNotEmpty) {
          exchange['LDB_NAME'] = sender['TIdb_Key'];
        }
        sender['exchange'] = _param(exchange);
        _sendRequest(sender);
      } else {
        sender['ClientData'] = json.decode(dataItem.first['ClientData'] as String);
        sender['BinaryData'] = dataItem.first['BinaryData'];
        sender['Pageinfo'] = dataItem.first['Pageinfo'];
        sender['USRLD_LOAD_DATE'] = dataItem.first['USRLD_LOAD_DATE'];
        _setDBDataCallBack(sender);
      }
    } catch (e) {
      _addLogEvent('loadPagesWithDAccess', e.toString());
      rethrow;
    }
  }

  // Méthodes privées
  Future<void> _activeDBConnection() async {
    try {
      if (!IsIdbActive) return;

      if ((dos_uid.isNotEmpty && usr_uid.isNotEmpty) || usr_code.isNotEmpty) {
        final dbInfo = _gbsDatabaseInfo();
        _serverDB = await openDatabase(
          join(await getDatabasesPath(), dbInfo['server']),
          version: dbInfo['version'],
          onCreate: (db, version) async {
            await db.execute('''
              CREATE TABLE $TIDB_EntityData (
                $EntityData_Name TEXT PRIMARY KEY,
                ClientData TEXT,
                USRLD_IDF TEXT,
                USRLD_LOAD_DATE TEXT
              )
            ''');

            await db.execute('''
              CREATE TABLE $TIDB_BinaryData (
                $EntityData_Name TEXT PRIMARY KEY,
                ClientData TEXT,
                BinaryData TEXT,
                Pageinfo TEXT,
                USRLD_IDF TEXT,
                USRLD_LOAD_DATE TEXT
              )
            ''');

            // Ajouter les autres tables...
          },
        );

        if (!isCnxMode) {
          await _checkUserLocalData();
        }
      }
    } catch (e) {
      _addLogEvent('_activeDBConnection', e.toString());
      rethrow;
    }
  }

  Future<void> _deleteDBConnection() async {
    try {
      final dbInfo = _gbsDatabaseInfo();
      final dbPath = join(await getDatabasesPath(), dbInfo['server']);
      await deleteDatabase(dbPath);
    } catch (e) {
      _addLogEvent('_deleteDBConnection', e.toString());
      rethrow;
    }
  }

  Map<String, dynamic> _gbsDatabaseInfo() {
    String server = 'BMDataBase_${usr_uid}_${dos_uid}';
    if (usr_code.isNotEmpty) {
      server = 'BMDataBase_${usr_code}_C8827F48FFFE4462AC86E9D8CEA0617C';
    }

    return {'server': server, 'version': 1};
  }

  String _getEntityDataKey(Map<String, dynamic> sender) {
    // Implémentation simplifiée - à adapter selon vos besoins
    String objectName = sender['object_name'] ?? '';
    String actionName = sender['action_name'] ?? '';

    if (actionName.toLowerCase() == 'select_all_data') {
      objectName += '__all_data';
    }

    return objectName;
  }

  void _setEntityDataCallBack(Map<String, dynamic> sender) {
    try {
      var requestData = sender['ClientData'];
      final completeCallback = sender['Sender_Complete'];

      if (completeCallback != null) {
        completeCallback(requestData, null, sender);
      }
    } catch (e) {
      _addLogEvent('_setEntityDataCallBack', e.toString());
      rethrow;
    }
  }

  void _setDBDataCallBack(Map<String, dynamic> sender) {
    try {
      final completeCallback = sender['Sender_Complete'];
      if (completeCallback != null) {
        completeCallback(sender);
      }
    } catch (e) {
      _addLogEvent('_setDBDataCallBack', e.toString());
      rethrow;
    }
  }

  void _setBinaryData(Map<String, dynamic> sender) {
    try {
      final completeCallback = sender['Sender_Complete'];
      if (completeCallback != null) {
        completeCallback(sender);
      }
    } catch (e) {
      _addLogEvent('_setBinaryData', e.toString());
      rethrow;
    }
  }

  void _setEntityData(Map<String, dynamic> sender) {
    try {
      var requestData = sender['ClientData'];
      final completeCallback = sender['Sender_Complete'];
      if (completeCallback != null) {
        completeCallback(requestData, null, sender);
      }
    } catch (e) {
      _addLogEvent('_setEntityData', e.toString());
      rethrow;
    }
  }

  Future<void> _checkUserLocalData() async {
    try {
      final result = await _serverDB!.query(TIDB_System, where: '$EntityData_Name = ?', whereArgs: ['DB_NAME']);

      // Implémentation simplifiée
      // ... reste de l'implémentation
    } catch (e) {
      _addLogEvent('_checkUserLocalData', e.toString());
      rethrow;
    }
  }

  // Méthodes utilitaires
  Map<String, dynamic> _deparam(String query) {
    return Uri.splitQueryString(query);
  }

  String _param(Map<String, dynamic> params) {
    return Uri(queryParameters: params).query;
  }

  void _addLogEvent(String method, String error) {
    print('Error in $method: $error');
  }

  void _sendRequest(Map<String, dynamic> sender) {
    // Implémentation dépendante de votre système de requêtes
    print('Send request: $sender');
  }
}

// Exemple d'utilisation
void main() async {
  final gbSystemData = GBSystemData();

  try {
    await gbSystemData.activateDBData('dos123', 'usr456');

    final sender = {'object_name': 'test_data', 'action_name': 'select', 'exchange': 'param1=value1&param2=value2'};

    await gbSystemData.getEntityData(sender);
  } catch (e) {
    print('Error: $e');
  }
}
