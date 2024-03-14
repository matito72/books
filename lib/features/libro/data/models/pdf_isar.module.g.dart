// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_isar.module.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPdfIsarModuleCollection on Isar {
  IsarCollection<PdfIsarModule> get pdfIsarModules => this.collection();
}

const PdfIsarModuleSchema = CollectionSchema(
  name: r'PdfIsarModule',
  id: -1126106332101086393,
  properties: {
    r'descrizione': PropertySchema(
      id: 0,
      name: r'descrizione',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'pathNameFile': PropertySchema(
      id: 2,
      name: r'pathNameFile',
      type: IsarType.string,
    ),
    r'testo': PropertySchema(
      id: 3,
      name: r'testo',
      type: IsarType.string,
    )
  },
  estimateSize: _pdfIsarModuleEstimateSize,
  serialize: _pdfIsarModuleSerialize,
  deserialize: _pdfIsarModuleDeserialize,
  deserializeProp: _pdfIsarModuleDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'pathNameFile': IndexSchema(
      id: -6533547897422983374,
      name: r'pathNameFile',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'pathNameFile',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _pdfIsarModuleGetId,
  getLinks: _pdfIsarModuleGetLinks,
  attach: _pdfIsarModuleAttach,
  version: '3.1.0+1',
);

int _pdfIsarModuleEstimateSize(
  PdfIsarModule object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.descrizione.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.pathNameFile.length * 3;
  bytesCount += 3 + object.testo.length * 3;
  return bytesCount;
}

void _pdfIsarModuleSerialize(
  PdfIsarModule object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.descrizione);
  writer.writeString(offsets[1], object.name);
  writer.writeString(offsets[2], object.pathNameFile);
  writer.writeString(offsets[3], object.testo);
}

PdfIsarModule _pdfIsarModuleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PdfIsarModule();
  object.descrizione = reader.readString(offsets[0]);
  object.id = id;
  object.name = reader.readString(offsets[1]);
  object.pathNameFile = reader.readString(offsets[2]);
  object.testo = reader.readString(offsets[3]);
  return object;
}

P _pdfIsarModuleDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pdfIsarModuleGetId(PdfIsarModule object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pdfIsarModuleGetLinks(PdfIsarModule object) {
  return [];
}

void _pdfIsarModuleAttach(
    IsarCollection<dynamic> col, Id id, PdfIsarModule object) {
  object.id = id;
}

extension PdfIsarModuleByIndex on IsarCollection<PdfIsarModule> {
  Future<PdfIsarModule?> getByPathNameFile(String pathNameFile) {
    return getByIndex(r'pathNameFile', [pathNameFile]);
  }

  PdfIsarModule? getByPathNameFileSync(String pathNameFile) {
    return getByIndexSync(r'pathNameFile', [pathNameFile]);
  }

  Future<bool> deleteByPathNameFile(String pathNameFile) {
    return deleteByIndex(r'pathNameFile', [pathNameFile]);
  }

  bool deleteByPathNameFileSync(String pathNameFile) {
    return deleteByIndexSync(r'pathNameFile', [pathNameFile]);
  }

  Future<List<PdfIsarModule?>> getAllByPathNameFile(
      List<String> pathNameFileValues) {
    final values = pathNameFileValues.map((e) => [e]).toList();
    return getAllByIndex(r'pathNameFile', values);
  }

  List<PdfIsarModule?> getAllByPathNameFileSync(
      List<String> pathNameFileValues) {
    final values = pathNameFileValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'pathNameFile', values);
  }

  Future<int> deleteAllByPathNameFile(List<String> pathNameFileValues) {
    final values = pathNameFileValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'pathNameFile', values);
  }

  int deleteAllByPathNameFileSync(List<String> pathNameFileValues) {
    final values = pathNameFileValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'pathNameFile', values);
  }

  Future<Id> putByPathNameFile(PdfIsarModule object) {
    return putByIndex(r'pathNameFile', object);
  }

  Id putByPathNameFileSync(PdfIsarModule object, {bool saveLinks = true}) {
    return putByIndexSync(r'pathNameFile', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPathNameFile(List<PdfIsarModule> objects) {
    return putAllByIndex(r'pathNameFile', objects);
  }

  List<Id> putAllByPathNameFileSync(List<PdfIsarModule> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'pathNameFile', objects, saveLinks: saveLinks);
  }
}

extension PdfIsarModuleQueryWhereSort
    on QueryBuilder<PdfIsarModule, PdfIsarModule, QWhere> {
  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PdfIsarModuleQueryWhere
    on QueryBuilder<PdfIsarModule, PdfIsarModule, QWhereClause> {
  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterWhereClause> idBetween(
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

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterWhereClause> nameNotEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterWhereClause>
      pathNameFileEqualTo(String pathNameFile) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'pathNameFile',
        value: [pathNameFile],
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterWhereClause>
      pathNameFileNotEqualTo(String pathNameFile) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pathNameFile',
              lower: [],
              upper: [pathNameFile],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pathNameFile',
              lower: [pathNameFile],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pathNameFile',
              lower: [pathNameFile],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pathNameFile',
              lower: [],
              upper: [pathNameFile],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PdfIsarModuleQueryFilter
    on QueryBuilder<PdfIsarModule, PdfIsarModule, QFilterCondition> {
  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      descrizioneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      descrizioneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      descrizioneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      descrizioneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'descrizione',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      descrizioneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      descrizioneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      descrizioneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      descrizioneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descrizione',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      descrizioneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descrizione',
        value: '',
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      descrizioneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descrizione',
        value: '',
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      pathNameFileEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pathNameFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      pathNameFileGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pathNameFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      pathNameFileLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pathNameFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      pathNameFileBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pathNameFile',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      pathNameFileStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pathNameFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      pathNameFileEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pathNameFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      pathNameFileContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pathNameFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      pathNameFileMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pathNameFile',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      pathNameFileIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pathNameFile',
        value: '',
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      pathNameFileIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pathNameFile',
        value: '',
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      testoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'testo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      testoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'testo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      testoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'testo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      testoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'testo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      testoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'testo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      testoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'testo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      testoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'testo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      testoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'testo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      testoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'testo',
        value: '',
      ));
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterFilterCondition>
      testoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'testo',
        value: '',
      ));
    });
  }
}

extension PdfIsarModuleQueryObject
    on QueryBuilder<PdfIsarModule, PdfIsarModule, QFilterCondition> {}

extension PdfIsarModuleQueryLinks
    on QueryBuilder<PdfIsarModule, PdfIsarModule, QFilterCondition> {}

extension PdfIsarModuleQuerySortBy
    on QueryBuilder<PdfIsarModule, PdfIsarModule, QSortBy> {
  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy> sortByDescrizione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.asc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy>
      sortByDescrizioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.desc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy>
      sortByPathNameFile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pathNameFile', Sort.asc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy>
      sortByPathNameFileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pathNameFile', Sort.desc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy> sortByTesto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'testo', Sort.asc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy> sortByTestoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'testo', Sort.desc);
    });
  }
}

extension PdfIsarModuleQuerySortThenBy
    on QueryBuilder<PdfIsarModule, PdfIsarModule, QSortThenBy> {
  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy> thenByDescrizione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.asc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy>
      thenByDescrizioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.desc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy>
      thenByPathNameFile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pathNameFile', Sort.asc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy>
      thenByPathNameFileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pathNameFile', Sort.desc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy> thenByTesto() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'testo', Sort.asc);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QAfterSortBy> thenByTestoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'testo', Sort.desc);
    });
  }
}

extension PdfIsarModuleQueryWhereDistinct
    on QueryBuilder<PdfIsarModule, PdfIsarModule, QDistinct> {
  QueryBuilder<PdfIsarModule, PdfIsarModule, QDistinct> distinctByDescrizione(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descrizione', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QDistinct> distinctByPathNameFile(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pathNameFile', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PdfIsarModule, PdfIsarModule, QDistinct> distinctByTesto(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'testo', caseSensitive: caseSensitive);
    });
  }
}

extension PdfIsarModuleQueryProperty
    on QueryBuilder<PdfIsarModule, PdfIsarModule, QQueryProperty> {
  QueryBuilder<PdfIsarModule, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PdfIsarModule, String, QQueryOperations> descrizioneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descrizione');
    });
  }

  QueryBuilder<PdfIsarModule, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PdfIsarModule, String, QQueryOperations> pathNameFileProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pathNameFile');
    });
  }

  QueryBuilder<PdfIsarModule, String, QQueryOperations> testoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'testo');
    });
  }
}
