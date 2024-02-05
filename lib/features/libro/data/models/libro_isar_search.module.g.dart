// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libro_isar_search.module.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLibroIsarSearchModelCollection on Isar {
  IsarCollection<LibroIsarSearchModel> get libroIsarSearchModels =>
      this.collection();
}

const LibroIsarSearchModelSchema = CollectionSchema(
  name: r'LibroIsarSearchModel',
  id: 393772897559687583,
  properties: {
    r'country': PropertySchema(
      id: 0,
      name: r'country',
      type: IsarType.string,
    ),
    r'dataPubblicazione': PropertySchema(
      id: 1,
      name: r'dataPubblicazione',
      type: IsarType.string,
    ),
    r'descrizione': PropertySchema(
      id: 2,
      name: r'descrizione',
      type: IsarType.string,
    ),
    r'editore': PropertySchema(
      id: 3,
      name: r'editore',
      type: IsarType.string,
    ),
    r'googleBookId': PropertySchema(
      id: 4,
      name: r'googleBookId',
      type: IsarType.string,
    ),
    r'immagineCopertina': PropertySchema(
      id: 5,
      name: r'immagineCopertina',
      type: IsarType.string,
    ),
    r'isEbook': PropertySchema(
      id: 6,
      name: r'isEbook',
      type: IsarType.bool,
    ),
    r'isbn': PropertySchema(
      id: 7,
      name: r'isbn',
      type: IsarType.string,
    ),
    r'lstAutori': PropertySchema(
      id: 8,
      name: r'lstAutori',
      type: IsarType.stringList,
    ),
    r'lstCategoria': PropertySchema(
      id: 9,
      name: r'lstCategoria',
      type: IsarType.stringList,
    ),
    r'nrPagine': PropertySchema(
      id: 10,
      name: r'nrPagine',
      type: IsarType.long,
    ),
    r'previewLink': PropertySchema(
      id: 11,
      name: r'previewLink',
      type: IsarType.string,
    ),
    r'prezzo': PropertySchema(
      id: 12,
      name: r'prezzo',
      type: IsarType.string,
    ),
    r'titolo': PropertySchema(
      id: 13,
      name: r'titolo',
      type: IsarType.string,
    ),
    r'valuta': PropertySchema(
      id: 14,
      name: r'valuta',
      type: IsarType.string,
    )
  },
  estimateSize: _libroIsarSearchModelEstimateSize,
  serialize: _libroIsarSearchModelSerialize,
  deserialize: _libroIsarSearchModelDeserialize,
  deserializeProp: _libroIsarSearchModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _libroIsarSearchModelGetId,
  getLinks: _libroIsarSearchModelGetLinks,
  attach: _libroIsarSearchModelAttach,
  version: '3.1.0+1',
);

int _libroIsarSearchModelEstimateSize(
  LibroIsarSearchModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.country.length * 3;
  bytesCount += 3 + object.dataPubblicazione.length * 3;
  bytesCount += 3 + object.descrizione.length * 3;
  bytesCount += 3 + object.editore.length * 3;
  bytesCount += 3 + object.googleBookId.length * 3;
  bytesCount += 3 + object.immagineCopertina.length * 3;
  bytesCount += 3 + object.isbn.length * 3;
  bytesCount += 3 + object.lstAutori.length * 3;
  {
    for (var i = 0; i < object.lstAutori.length; i++) {
      final value = object.lstAutori[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.lstCategoria.length * 3;
  {
    for (var i = 0; i < object.lstCategoria.length; i++) {
      final value = object.lstCategoria[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.previewLink.length * 3;
  bytesCount += 3 + object.prezzo.length * 3;
  bytesCount += 3 + object.titolo.length * 3;
  bytesCount += 3 + object.valuta.length * 3;
  return bytesCount;
}

void _libroIsarSearchModelSerialize(
  LibroIsarSearchModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.country);
  writer.writeString(offsets[1], object.dataPubblicazione);
  writer.writeString(offsets[2], object.descrizione);
  writer.writeString(offsets[3], object.editore);
  writer.writeString(offsets[4], object.googleBookId);
  writer.writeString(offsets[5], object.immagineCopertina);
  writer.writeBool(offsets[6], object.isEbook);
  writer.writeString(offsets[7], object.isbn);
  writer.writeStringList(offsets[8], object.lstAutori);
  writer.writeStringList(offsets[9], object.lstCategoria);
  writer.writeLong(offsets[10], object.nrPagine);
  writer.writeString(offsets[11], object.previewLink);
  writer.writeString(offsets[12], object.prezzo);
  writer.writeString(offsets[13], object.titolo);
  writer.writeString(offsets[14], object.valuta);
}

LibroIsarSearchModel _libroIsarSearchModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LibroIsarSearchModel(
    country: reader.readStringOrNull(offsets[0]) ?? '',
    dataPubblicazione: reader.readStringOrNull(offsets[1]) ?? '',
    descrizione: reader.readStringOrNull(offsets[2]) ?? '',
    editore: reader.readStringOrNull(offsets[3]) ?? '',
    googleBookId: reader.readStringOrNull(offsets[4]) ?? '',
    immagineCopertina: reader.readStringOrNull(offsets[5]) ?? '',
    isEbook: reader.readBoolOrNull(offsets[6]) ?? false,
    isbn: reader.readStringOrNull(offsets[7]) ?? '',
    lstAutori: reader.readStringList(offsets[8]) ?? const [],
    lstCategoria: reader.readStringList(offsets[9]) ?? const [],
    nrPagine: reader.readLongOrNull(offsets[10]) ?? 0,
    previewLink: reader.readStringOrNull(offsets[11]) ?? '',
    prezzo: reader.readStringOrNull(offsets[12]) ?? '',
    titolo: reader.readStringOrNull(offsets[13]) ?? '',
    valuta: reader.readStringOrNull(offsets[14]) ?? '',
  );
  object.id = id;
  return object;
}

P _libroIsarSearchModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 8:
      return (reader.readStringList(offset) ?? const []) as P;
    case 9:
      return (reader.readStringList(offset) ?? const []) as P;
    case 10:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 11:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 12:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 13:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 14:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _libroIsarSearchModelGetId(LibroIsarSearchModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _libroIsarSearchModelGetLinks(
    LibroIsarSearchModel object) {
  return [];
}

void _libroIsarSearchModelAttach(
    IsarCollection<dynamic> col, Id id, LibroIsarSearchModel object) {
  object.id = id;
}

extension LibroIsarSearchModelQueryWhereSort
    on QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QWhere> {
  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LibroIsarSearchModelQueryWhere
    on QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QWhereClause> {
  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterWhereClause>
      idBetween(
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

extension LibroIsarSearchModelQueryFilter on QueryBuilder<LibroIsarSearchModel,
    LibroIsarSearchModel, QFilterCondition> {
  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> countryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> countryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> countryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> countryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'country',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> countryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> countryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      countryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      countryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'country',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> countryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> countryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> dataPubblicazioneEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataPubblicazione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> dataPubblicazioneGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataPubblicazione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> dataPubblicazioneLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataPubblicazione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> dataPubblicazioneBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataPubblicazione',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> dataPubblicazioneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dataPubblicazione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> dataPubblicazioneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dataPubblicazione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      dataPubblicazioneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dataPubblicazione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      dataPubblicazioneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dataPubblicazione',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> dataPubblicazioneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataPubblicazione',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> dataPubblicazioneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dataPubblicazione',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> descrizioneEqualTo(
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

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> descrizioneGreaterThan(
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

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> descrizioneLessThan(
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

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> descrizioneBetween(
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

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> descrizioneStartsWith(
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

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> descrizioneEndsWith(
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

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      descrizioneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      descrizioneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descrizione',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> descrizioneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descrizione',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> descrizioneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descrizione',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> editoreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> editoreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'editore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> editoreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'editore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> editoreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'editore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> editoreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'editore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> editoreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'editore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      editoreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'editore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      editoreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'editore',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> editoreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editore',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> editoreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'editore',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> googleBookIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleBookId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> googleBookIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'googleBookId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> googleBookIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'googleBookId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> googleBookIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'googleBookId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> googleBookIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'googleBookId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> googleBookIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'googleBookId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      googleBookIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'googleBookId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      googleBookIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'googleBookId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> googleBookIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleBookId',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> googleBookIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'googleBookId',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> immagineCopertinaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'immagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> immagineCopertinaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'immagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> immagineCopertinaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'immagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> immagineCopertinaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'immagineCopertina',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> immagineCopertinaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'immagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> immagineCopertinaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'immagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      immagineCopertinaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'immagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      immagineCopertinaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'immagineCopertina',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> immagineCopertinaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'immagineCopertina',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> immagineCopertinaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'immagineCopertina',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> isEbookEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEbook',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> isbnEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isbn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> isbnGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isbn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> isbnLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isbn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> isbnBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isbn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> isbnStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'isbn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> isbnEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'isbn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      isbnContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'isbn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      isbnMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'isbn',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> isbnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isbn',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> isbnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'isbn',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lstAutori',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lstAutori',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lstAutori',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lstAutori',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lstAutori',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lstAutori',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      lstAutoriElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lstAutori',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      lstAutoriElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lstAutori',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lstAutori',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lstAutori',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lstAutori',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lstAutori',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lstAutori',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lstAutori',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lstAutori',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstAutoriLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lstAutori',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lstCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lstCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lstCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lstCategoria',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lstCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lstCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      lstCategoriaElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lstCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      lstCategoriaElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lstCategoria',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lstCategoria',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lstCategoria',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lstCategoria',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lstCategoria',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lstCategoria',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lstCategoria',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lstCategoria',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> lstCategoriaLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lstCategoria',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> nrPagineEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nrPagine',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> nrPagineGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nrPagine',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> nrPagineLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nrPagine',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> nrPagineBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nrPagine',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> previewLinkEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previewLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> previewLinkGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'previewLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> previewLinkLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'previewLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> previewLinkBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'previewLink',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> previewLinkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'previewLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> previewLinkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'previewLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      previewLinkContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'previewLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      previewLinkMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'previewLink',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> previewLinkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previewLink',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> previewLinkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'previewLink',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> prezzoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prezzo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> prezzoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prezzo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> prezzoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prezzo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> prezzoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prezzo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> prezzoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'prezzo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> prezzoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'prezzo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      prezzoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'prezzo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      prezzoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'prezzo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> prezzoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prezzo',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> prezzoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'prezzo',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> titoloEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> titoloGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> titoloLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> titoloBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titolo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> titoloStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> titoloEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      titoloContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      titoloMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titolo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> titoloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titolo',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> titoloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titolo',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> valutaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valuta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> valutaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valuta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> valutaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valuta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> valutaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valuta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> valutaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'valuta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> valutaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'valuta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      valutaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'valuta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
          QAfterFilterCondition>
      valutaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'valuta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> valutaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valuta',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel,
      QAfterFilterCondition> valutaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'valuta',
        value: '',
      ));
    });
  }
}

extension LibroIsarSearchModelQueryObject on QueryBuilder<LibroIsarSearchModel,
    LibroIsarSearchModel, QFilterCondition> {}

extension LibroIsarSearchModelQueryLinks on QueryBuilder<LibroIsarSearchModel,
    LibroIsarSearchModel, QFilterCondition> {}

extension LibroIsarSearchModelQuerySortBy
    on QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QSortBy> {
  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByDataPubblicazione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataPubblicazione', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByDataPubblicazioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataPubblicazione', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByDescrizione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByDescrizioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByEditore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editore', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByEditoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editore', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByGoogleBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleBookId', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByGoogleBookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleBookId', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByImmagineCopertina() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'immagineCopertina', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByImmagineCopertinaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'immagineCopertina', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByIsEbook() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEbook', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByIsEbookDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEbook', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByIsbn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isbn', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByIsbnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isbn', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByNrPagine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nrPagine', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByNrPagineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nrPagine', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByPreviewLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewLink', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByPreviewLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewLink', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByPrezzo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prezzo', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByPrezzoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prezzo', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByTitolo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titolo', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByTitoloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titolo', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByValuta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuta', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      sortByValutaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuta', Sort.desc);
    });
  }
}

extension LibroIsarSearchModelQuerySortThenBy
    on QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QSortThenBy> {
  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByDataPubblicazione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataPubblicazione', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByDataPubblicazioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataPubblicazione', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByDescrizione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByDescrizioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByEditore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editore', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByEditoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editore', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByGoogleBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleBookId', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByGoogleBookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleBookId', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByImmagineCopertina() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'immagineCopertina', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByImmagineCopertinaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'immagineCopertina', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByIsEbook() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEbook', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByIsEbookDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEbook', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByIsbn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isbn', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByIsbnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isbn', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByNrPagine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nrPagine', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByNrPagineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nrPagine', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByPreviewLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewLink', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByPreviewLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewLink', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByPrezzo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prezzo', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByPrezzoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prezzo', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByTitolo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titolo', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByTitoloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titolo', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByValuta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuta', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QAfterSortBy>
      thenByValutaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuta', Sort.desc);
    });
  }
}

extension LibroIsarSearchModelQueryWhereDistinct
    on QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct> {
  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByCountry({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'country', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByDataPubblicazione({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataPubblicazione',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByDescrizione({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descrizione', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByEditore({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editore', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByGoogleBookId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'googleBookId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByImmagineCopertina({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'immagineCopertina',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByIsEbook() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEbook');
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByIsbn({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isbn', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByLstAutori() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lstAutori');
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByLstCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lstCategoria');
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByNrPagine() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nrPagine');
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByPreviewLink({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'previewLink', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByPrezzo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prezzo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByTitolo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titolo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarSearchModel, LibroIsarSearchModel, QDistinct>
      distinctByValuta({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valuta', caseSensitive: caseSensitive);
    });
  }
}

extension LibroIsarSearchModelQueryProperty on QueryBuilder<
    LibroIsarSearchModel, LibroIsarSearchModel, QQueryProperty> {
  QueryBuilder<LibroIsarSearchModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LibroIsarSearchModel, String, QQueryOperations>
      countryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'country');
    });
  }

  QueryBuilder<LibroIsarSearchModel, String, QQueryOperations>
      dataPubblicazioneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataPubblicazione');
    });
  }

  QueryBuilder<LibroIsarSearchModel, String, QQueryOperations>
      descrizioneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descrizione');
    });
  }

  QueryBuilder<LibroIsarSearchModel, String, QQueryOperations>
      editoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editore');
    });
  }

  QueryBuilder<LibroIsarSearchModel, String, QQueryOperations>
      googleBookIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'googleBookId');
    });
  }

  QueryBuilder<LibroIsarSearchModel, String, QQueryOperations>
      immagineCopertinaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'immagineCopertina');
    });
  }

  QueryBuilder<LibroIsarSearchModel, bool, QQueryOperations> isEbookProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEbook');
    });
  }

  QueryBuilder<LibroIsarSearchModel, String, QQueryOperations> isbnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isbn');
    });
  }

  QueryBuilder<LibroIsarSearchModel, List<String>, QQueryOperations>
      lstAutoriProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lstAutori');
    });
  }

  QueryBuilder<LibroIsarSearchModel, List<String>, QQueryOperations>
      lstCategoriaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lstCategoria');
    });
  }

  QueryBuilder<LibroIsarSearchModel, int, QQueryOperations> nrPagineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nrPagine');
    });
  }

  QueryBuilder<LibroIsarSearchModel, String, QQueryOperations>
      previewLinkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'previewLink');
    });
  }

  QueryBuilder<LibroIsarSearchModel, String, QQueryOperations>
      prezzoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prezzo');
    });
  }

  QueryBuilder<LibroIsarSearchModel, String, QQueryOperations>
      titoloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titolo');
    });
  }

  QueryBuilder<LibroIsarSearchModel, String, QQueryOperations>
      valutaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valuta');
    });
  }
}
