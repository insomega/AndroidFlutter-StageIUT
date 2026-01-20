// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GBSystem_LocalData_DataToStore.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDataToStoreCollection on Isar {
  IsarCollection<DataToStore> get dataToStores => this.collection();
}

const DataToStoreSchema = CollectionSchema(
  name: r'DataToStore',
  id: -6370097490884124364,
  properties: {
    r'clientData': PropertySchema(
      id: 0,
      name: r'clientData',
      type: IsarType.string,
    ),
    r'dossierId': PropertySchema(
      id: 1,
      name: r'dossierId',
      type: IsarType.string,
    ),
    r'entityName': PropertySchema(
      id: 2,
      name: r'entityName',
      type: IsarType.string,
    ),
    r'loadDate': PropertySchema(
      id: 3,
      name: r'loadDate',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 4,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _dataToStoreEstimateSize,
  serialize: _dataToStoreSerialize,
  deserialize: _dataToStoreDeserialize,
  deserializeProp: _dataToStoreDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _dataToStoreGetId,
  getLinks: _dataToStoreGetLinks,
  attach: _dataToStoreAttach,
  version: '3.1.0+1',
);

int _dataToStoreEstimateSize(
  DataToStore object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.clientData.length * 3;
  bytesCount += 3 + object.dossierId.length * 3;
  bytesCount += 3 + object.entityName.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _dataToStoreSerialize(
  DataToStore object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.clientData);
  writer.writeString(offsets[1], object.dossierId);
  writer.writeString(offsets[2], object.entityName);
  writer.writeDateTime(offsets[3], object.loadDate);
  writer.writeString(offsets[4], object.userId);
}

DataToStore _dataToStoreDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DataToStore();
  object.clientData = reader.readString(offsets[0]);
  object.dossierId = reader.readString(offsets[1]);
  object.entityName = reader.readString(offsets[2]);
  object.id = id;
  object.loadDate = reader.readDateTime(offsets[3]);
  object.userId = reader.readString(offsets[4]);
  return object;
}

P _dataToStoreDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dataToStoreGetId(DataToStore object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dataToStoreGetLinks(DataToStore object) {
  return [];
}

void _dataToStoreAttach(
    IsarCollection<dynamic> col, Id id, DataToStore object) {
  object.id = id;
}

extension DataToStoreQueryWhereSort
    on QueryBuilder<DataToStore, DataToStore, QWhere> {
  QueryBuilder<DataToStore, DataToStore, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DataToStoreQueryWhere
    on QueryBuilder<DataToStore, DataToStore, QWhereClause> {
  QueryBuilder<DataToStore, DataToStore, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DataToStoreQueryFilter
    on QueryBuilder<DataToStore, DataToStore, QFilterCondition> {
  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      clientDataEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      clientDataGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      clientDataLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      clientDataBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      clientDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clientData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      clientDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clientData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      clientDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clientData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      clientDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clientData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      clientDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientData',
        value: '',
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      clientDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clientData',
        value: '',
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      dossierIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dossierId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      dossierIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dossierId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      dossierIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dossierId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      dossierIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dossierId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      dossierIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dossierId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      dossierIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dossierId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      dossierIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dossierId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      dossierIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dossierId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      dossierIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dossierId',
        value: '',
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      dossierIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dossierId',
        value: '',
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      entityNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      entityNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entityName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      entityNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entityName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      entityNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entityName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      entityNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entityName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      entityNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entityName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      entityNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entityName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      entityNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entityName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      entityNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entityName',
        value: '',
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      entityNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entityName',
        value: '',
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition> loadDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loadDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      loadDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loadDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      loadDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loadDate',
        value: value,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition> loadDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loadDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition> userIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition> userIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension DataToStoreQueryObject
    on QueryBuilder<DataToStore, DataToStore, QFilterCondition> {}

extension DataToStoreQueryLinks
    on QueryBuilder<DataToStore, DataToStore, QFilterCondition> {}

extension DataToStoreQuerySortBy
    on QueryBuilder<DataToStore, DataToStore, QSortBy> {
  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> sortByClientData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientData', Sort.asc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> sortByClientDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientData', Sort.desc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> sortByDossierId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dossierId', Sort.asc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> sortByDossierIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dossierId', Sort.desc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> sortByEntityName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityName', Sort.asc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> sortByEntityNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityName', Sort.desc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> sortByLoadDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loadDate', Sort.asc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> sortByLoadDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loadDate', Sort.desc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension DataToStoreQuerySortThenBy
    on QueryBuilder<DataToStore, DataToStore, QSortThenBy> {
  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> thenByClientData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientData', Sort.asc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> thenByClientDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientData', Sort.desc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> thenByDossierId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dossierId', Sort.asc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> thenByDossierIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dossierId', Sort.desc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> thenByEntityName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityName', Sort.asc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> thenByEntityNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entityName', Sort.desc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> thenByLoadDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loadDate', Sort.asc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> thenByLoadDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loadDate', Sort.desc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension DataToStoreQueryWhereDistinct
    on QueryBuilder<DataToStore, DataToStore, QDistinct> {
  QueryBuilder<DataToStore, DataToStore, QDistinct> distinctByClientData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientData', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QDistinct> distinctByDossierId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dossierId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QDistinct> distinctByEntityName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entityName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DataToStore, DataToStore, QDistinct> distinctByLoadDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loadDate');
    });
  }

  QueryBuilder<DataToStore, DataToStore, QDistinct> distinctByUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension DataToStoreQueryProperty
    on QueryBuilder<DataToStore, DataToStore, QQueryProperty> {
  QueryBuilder<DataToStore, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DataToStore, String, QQueryOperations> clientDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientData');
    });
  }

  QueryBuilder<DataToStore, String, QQueryOperations> dossierIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dossierId');
    });
  }

  QueryBuilder<DataToStore, String, QQueryOperations> entityNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entityName');
    });
  }

  QueryBuilder<DataToStore, DateTime, QQueryOperations> loadDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loadDate');
    });
  }

  QueryBuilder<DataToStore, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
