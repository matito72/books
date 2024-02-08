// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libreria_isar.module.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLibreriaIsarModelCollection on Isar {
  IsarCollection<LibreriaIsarModel> get libreriaIsarModels => this.collection();
}

const LibreriaIsarModelSchema = CollectionSchema(
  name: r'LibreriaIsarModel',
  id: 4264182765973322893,
  properties: {
    r'isLibreriaDefault': PropertySchema(
      id: 0,
      name: r'isLibreriaDefault',
      type: IsarType.bool,
    ),
    r'nome': PropertySchema(
      id: 1,
      name: r'nome',
      type: IsarType.string,
    ),
    r'nrLibriCaricati': PropertySchema(
      id: 2,
      name: r'nrLibriCaricati',
      type: IsarType.long,
    )
  },
  estimateSize: _libreriaIsarModelEstimateSize,
  serialize: _libreriaIsarModelSerialize,
  deserialize: _libreriaIsarModelDeserialize,
  deserializeProp: _libreriaIsarModelDeserializeProp,
  idName: r'sigla',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _libreriaIsarModelGetId,
  getLinks: _libreriaIsarModelGetLinks,
  attach: _libreriaIsarModelAttach,
  version: '3.1.0+1',
);

int _libreriaIsarModelEstimateSize(
  LibreriaIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nome.length * 3;
  return bytesCount;
}

void _libreriaIsarModelSerialize(
  LibreriaIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isLibreriaDefault);
  writer.writeString(offsets[1], object.nome);
  writer.writeLong(offsets[2], object.nrLibriCaricati);
}

LibreriaIsarModel _libreriaIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LibreriaIsarModel(
    isLibreriaDefault: reader.readBoolOrNull(offsets[0]) ?? false,
    nome: reader.readStringOrNull(offsets[1]) ?? '-',
    nrLibriCaricati: reader.readLongOrNull(offsets[2]) ?? 0,
  );
  object.sigla = id;
  return object;
}

P _libreriaIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '-') as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _libreriaIsarModelGetId(LibreriaIsarModel object) {
  return object.sigla;
}

List<IsarLinkBase<dynamic>> _libreriaIsarModelGetLinks(
    LibreriaIsarModel object) {
  return [];
}

void _libreriaIsarModelAttach(
    IsarCollection<dynamic> col, Id id, LibreriaIsarModel object) {
  object.sigla = id;
}

extension LibreriaIsarModelQueryWhereSort
    on QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QWhere> {
  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterWhere> anySigla() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LibreriaIsarModelQueryWhere
    on QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QWhereClause> {
  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterWhereClause>
      siglaEqualTo(Id sigla) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: sigla,
        upper: sigla,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterWhereClause>
      siglaNotEqualTo(Id sigla) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: sigla, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: sigla, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: sigla, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: sigla, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterWhereClause>
      siglaGreaterThan(Id sigla, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: sigla, includeLower: include),
      );
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterWhereClause>
      siglaLessThan(Id sigla, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: sigla, includeUpper: include),
      );
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterWhereClause>
      siglaBetween(
    Id lowerSigla,
    Id upperSigla, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerSigla,
        includeLower: includeLower,
        upper: upperSigla,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LibreriaIsarModelQueryFilter
    on QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QFilterCondition> {
  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      isLibreriaDefaultEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLibreriaDefault',
        value: value,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nomeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nomeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nomeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nomeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nomeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nomeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nomeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nome',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nomeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nome',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nome',
        value: '',
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nrLibriCaricatiEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nrLibriCaricati',
        value: value,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nrLibriCaricatiGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nrLibriCaricati',
        value: value,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nrLibriCaricatiLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nrLibriCaricati',
        value: value,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      nrLibriCaricatiBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nrLibriCaricati',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      siglaEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sigla',
        value: value,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      siglaGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sigla',
        value: value,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      siglaLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sigla',
        value: value,
      ));
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterFilterCondition>
      siglaBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sigla',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LibreriaIsarModelQueryObject
    on QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QFilterCondition> {}

extension LibreriaIsarModelQueryLinks
    on QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QFilterCondition> {}

extension LibreriaIsarModelQuerySortBy
    on QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QSortBy> {
  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      sortByIsLibreriaDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLibreriaDefault', Sort.asc);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      sortByIsLibreriaDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLibreriaDefault', Sort.desc);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      sortByNrLibriCaricati() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nrLibriCaricati', Sort.asc);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      sortByNrLibriCaricatiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nrLibriCaricati', Sort.desc);
    });
  }
}

extension LibreriaIsarModelQuerySortThenBy
    on QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QSortThenBy> {
  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      thenByIsLibreriaDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLibreriaDefault', Sort.asc);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      thenByIsLibreriaDefaultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLibreriaDefault', Sort.desc);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      thenByNrLibriCaricati() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nrLibriCaricati', Sort.asc);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      thenByNrLibriCaricatiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nrLibriCaricati', Sort.desc);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      thenBySigla() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sigla', Sort.asc);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QAfterSortBy>
      thenBySiglaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sigla', Sort.desc);
    });
  }
}

extension LibreriaIsarModelQueryWhereDistinct
    on QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QDistinct> {
  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QDistinct>
      distinctByIsLibreriaDefault() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLibreriaDefault');
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QDistinct> distinctByNome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QDistinct>
      distinctByNrLibriCaricati() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nrLibriCaricati');
    });
  }
}

extension LibreriaIsarModelQueryProperty
    on QueryBuilder<LibreriaIsarModel, LibreriaIsarModel, QQueryProperty> {
  QueryBuilder<LibreriaIsarModel, int, QQueryOperations> siglaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sigla');
    });
  }

  QueryBuilder<LibreriaIsarModel, bool, QQueryOperations>
      isLibreriaDefaultProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLibreriaDefault');
    });
  }

  QueryBuilder<LibreriaIsarModel, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<LibreriaIsarModel, int, QQueryOperations>
      nrLibriCaricatiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nrLibriCaricati');
    });
  }
}
