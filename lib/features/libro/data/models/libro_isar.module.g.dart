// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libro_isar.module.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLibroIsarModelCollection on Isar {
  IsarCollection<LibroIsarModel> get libroIsarModels => this.collection();
}

const LibroIsarModelSchema = CollectionSchema(
  name: r'LibroIsarModel',
  id: 4880223275885515185,
  properties: {
    r'country': PropertySchema(
      id: 0,
      name: r'country',
      type: IsarType.string,
    ),
    r'dataInserimento': PropertySchema(
      id: 1,
      name: r'dataInserimento',
      type: IsarType.string,
    ),
    r'dataPubblicazione': PropertySchema(
      id: 2,
      name: r'dataPubblicazione',
      type: IsarType.string,
    ),
    r'dataUltimaModifica': PropertySchema(
      id: 3,
      name: r'dataUltimaModifica',
      type: IsarType.string,
    ),
    r'descrizione': PropertySchema(
      id: 4,
      name: r'descrizione',
      type: IsarType.string,
    ),
    r'editore': PropertySchema(
      id: 5,
      name: r'editore',
      type: IsarType.string,
    ),
    r'googleBookId': PropertySchema(
      id: 6,
      name: r'googleBookId',
      type: IsarType.string,
    ),
    r'immagineCopertina': PropertySchema(
      id: 7,
      name: r'immagineCopertina',
      type: IsarType.string,
    ),
    r'isEbook': PropertySchema(
      id: 8,
      name: r'isEbook',
      type: IsarType.bool,
    ),
    r'isbn': PropertySchema(
      id: 9,
      name: r'isbn',
      type: IsarType.string,
    ),
    r'lstAutori': PropertySchema(
      id: 10,
      name: r'lstAutori',
      type: IsarType.stringList,
    ),
    r'lstCategoria': PropertySchema(
      id: 11,
      name: r'lstCategoria',
      type: IsarType.stringList,
    ),
    r'note': PropertySchema(
      id: 12,
      name: r'note',
      type: IsarType.string,
    ),
    r'nrPagine': PropertySchema(
      id: 13,
      name: r'nrPagine',
      type: IsarType.long,
    ),
    r'pathImmagineCopertina': PropertySchema(
      id: 14,
      name: r'pathImmagineCopertina',
      type: IsarType.string,
    ),
    r'previewLink': PropertySchema(
      id: 15,
      name: r'previewLink',
      type: IsarType.string,
    ),
    r'prezzo': PropertySchema(
      id: 16,
      name: r'prezzo',
      type: IsarType.double,
    ),
    r'siglaLibreria': PropertySchema(
      id: 17,
      name: r'siglaLibreria',
      type: IsarType.long,
    ),
    r'stars': PropertySchema(
      id: 18,
      name: r'stars',
      type: IsarType.long,
    ),
    r'titolo': PropertySchema(
      id: 19,
      name: r'titolo',
      type: IsarType.string,
    ),
    r'valuta': PropertySchema(
      id: 20,
      name: r'valuta',
      type: IsarType.string,
    )
  },
  estimateSize: _libroIsarModelEstimateSize,
  serialize: _libroIsarModelSerialize,
  deserialize: _libroIsarModelDeserialize,
  deserializeProp: _libroIsarModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'lstAutori_titolo_editore': IndexSchema(
      id: -6425596949695108645,
      name: r'lstAutori_titolo_editore',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lstAutori',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'titolo',
          type: IndexType.hash,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'editore',
          type: IndexType.hash,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'links': LinkSchema(
      id: 2795732110193184968,
      name: r'links',
      target: r'LinkIsarModule',
      single: false,
    ),
    r'setPdf': LinkSchema(
      id: -1822680997384933721,
      name: r'setPdf',
      target: r'PdfIsarModule',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _libroIsarModelGetId,
  getLinks: _libroIsarModelGetLinks,
  attach: _libroIsarModelAttach,
  version: '3.1.0+1',
);

int _libroIsarModelEstimateSize(
  LibroIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.country.length * 3;
  bytesCount += 3 + object.dataInserimento.length * 3;
  bytesCount += 3 + object.dataPubblicazione.length * 3;
  bytesCount += 3 + object.dataUltimaModifica.length * 3;
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
  bytesCount += 3 + object.note.length * 3;
  {
    final value = object.pathImmagineCopertina;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.previewLink.length * 3;
  bytesCount += 3 + object.titolo.length * 3;
  bytesCount += 3 + object.valuta.length * 3;
  return bytesCount;
}

void _libroIsarModelSerialize(
  LibroIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.country);
  writer.writeString(offsets[1], object.dataInserimento);
  writer.writeString(offsets[2], object.dataPubblicazione);
  writer.writeString(offsets[3], object.dataUltimaModifica);
  writer.writeString(offsets[4], object.descrizione);
  writer.writeString(offsets[5], object.editore);
  writer.writeString(offsets[6], object.googleBookId);
  writer.writeString(offsets[7], object.immagineCopertina);
  writer.writeBool(offsets[8], object.isEbook);
  writer.writeString(offsets[9], object.isbn);
  writer.writeStringList(offsets[10], object.lstAutori);
  writer.writeStringList(offsets[11], object.lstCategoria);
  writer.writeString(offsets[12], object.note);
  writer.writeLong(offsets[13], object.nrPagine);
  writer.writeString(offsets[14], object.pathImmagineCopertina);
  writer.writeString(offsets[15], object.previewLink);
  writer.writeDouble(offsets[16], object.prezzo);
  writer.writeLong(offsets[17], object.siglaLibreria);
  writer.writeLong(offsets[18], object.stars);
  writer.writeString(offsets[19], object.titolo);
  writer.writeString(offsets[20], object.valuta);
}

LibroIsarModel _libroIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LibroIsarModel(
    reader.readLong(offsets[17]),
    reader.readString(offsets[1]),
    reader.readString(offsets[3]),
    country: reader.readStringOrNull(offsets[0]) ?? '',
    dataPubblicazione: reader.readStringOrNull(offsets[2]) ?? '',
    descrizione: reader.readStringOrNull(offsets[4]) ?? '',
    editore: reader.readStringOrNull(offsets[5]) ?? '',
    googleBookId: reader.readStringOrNull(offsets[6]) ?? '',
    immagineCopertina: reader.readStringOrNull(offsets[7]) ?? '',
    isEbook: reader.readBoolOrNull(offsets[8]) ?? false,
    isbn: reader.readString(offsets[9]),
    lstAutori: reader.readStringList(offsets[10]) ?? const [],
    lstCategoria: reader.readStringList(offsets[11]) ?? const [],
    note: reader.readStringOrNull(offsets[12]) ?? '',
    nrPagine: reader.readLongOrNull(offsets[13]) ?? 0,
    pathImmagineCopertina: reader.readStringOrNull(offsets[14]),
    previewLink: reader.readStringOrNull(offsets[15]) ?? '',
    prezzo: reader.readDoubleOrNull(offsets[16]) ?? 0,
    stars: reader.readLongOrNull(offsets[18]) ?? 0,
    titolo: reader.readStringOrNull(offsets[19]) ?? '',
    valuta: reader.readStringOrNull(offsets[20]) ?? '',
  );
  object.id = id;
  return object;
}

P _libroIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 8:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readStringList(offset) ?? const []) as P;
    case 11:
      return (reader.readStringList(offset) ?? const []) as P;
    case 12:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 13:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 16:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    case 18:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 19:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 20:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _libroIsarModelGetId(LibroIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _libroIsarModelGetLinks(LibroIsarModel object) {
  return [object.lstLinkIsarModule, object.lstPdfIsarModule];
}

void _libroIsarModelAttach(
    IsarCollection<dynamic> col, Id id, LibroIsarModel object) {
  object.id = id;
  object.lstLinkIsarModule.attach(col, col.isar.collection<LinkIsarModule>(), r'links', id);
  object.lstPdfIsarModule.attach(col, col.isar.collection<PdfIsarModule>(), r'setPdf', id);
}

extension LibroIsarModelQueryWhereSort
    on QueryBuilder<LibroIsarModel, LibroIsarModel, QWhere> {
  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LibroIsarModelQueryWhere
    on QueryBuilder<LibroIsarModel, LibroIsarModel, QWhereClause> {
  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterWhereClause>
      lstAutoriEqualToAnyTitoloEditore(List<String> lstAutori) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lstAutori_titolo_editore',
        value: [lstAutori],
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterWhereClause>
      lstAutoriNotEqualToAnyTitoloEditore(List<String> lstAutori) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lstAutori_titolo_editore',
              lower: [],
              upper: [lstAutori],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lstAutori_titolo_editore',
              lower: [lstAutori],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lstAutori_titolo_editore',
              lower: [lstAutori],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lstAutori_titolo_editore',
              lower: [],
              upper: [lstAutori],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterWhereClause>
      lstAutoriTitoloEqualToAnyEditore(List<String> lstAutori, String titolo) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lstAutori_titolo_editore',
        value: [lstAutori, titolo],
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterWhereClause>
      lstAutoriEqualToTitoloNotEqualToAnyEditore(
          List<String> lstAutori, String titolo) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lstAutori_titolo_editore',
              lower: [lstAutori],
              upper: [lstAutori, titolo],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lstAutori_titolo_editore',
              lower: [lstAutori, titolo],
              includeLower: false,
              upper: [lstAutori],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lstAutori_titolo_editore',
              lower: [lstAutori, titolo],
              includeLower: false,
              upper: [lstAutori],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lstAutori_titolo_editore',
              lower: [lstAutori],
              upper: [lstAutori, titolo],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterWhereClause>
      lstAutoriTitoloEditoreEqualTo(
          List<String> lstAutori, String titolo, String editore) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lstAutori_titolo_editore',
        value: [lstAutori, titolo, editore],
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterWhereClause>
      lstAutoriTitoloEqualToEditoreNotEqualTo(
          List<String> lstAutori, String titolo, String editore) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lstAutori_titolo_editore',
              lower: [lstAutori, titolo],
              upper: [lstAutori, titolo, editore],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lstAutori_titolo_editore',
              lower: [lstAutori, titolo, editore],
              includeLower: false,
              upper: [lstAutori, titolo],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lstAutori_titolo_editore',
              lower: [lstAutori, titolo, editore],
              includeLower: false,
              upper: [lstAutori, titolo],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lstAutori_titolo_editore',
              lower: [lstAutori, titolo],
              upper: [lstAutori, titolo, editore],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LibroIsarModelQueryFilter
    on QueryBuilder<LibroIsarModel, LibroIsarModel, QFilterCondition> {
  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      countryEqualTo(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      countryGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      countryLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      countryBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      countryStartsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      countryEndsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      countryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'country',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      countryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'country',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      countryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      countryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'country',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataInserimentoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataInserimento',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataInserimentoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataInserimento',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataInserimentoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataInserimento',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataInserimentoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataInserimento',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataInserimentoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dataInserimento',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataInserimentoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dataInserimento',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataInserimentoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dataInserimento',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataInserimentoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dataInserimento',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataInserimentoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataInserimento',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataInserimentoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dataInserimento',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataPubblicazioneEqualTo(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataPubblicazioneGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataPubblicazioneLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataPubblicazioneBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataPubblicazioneStartsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataPubblicazioneEndsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataPubblicazioneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dataPubblicazione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataPubblicazioneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dataPubblicazione',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataPubblicazioneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataPubblicazione',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataPubblicazioneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dataPubblicazione',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataUltimaModificaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataUltimaModifica',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataUltimaModificaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataUltimaModifica',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataUltimaModificaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataUltimaModifica',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataUltimaModificaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataUltimaModifica',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataUltimaModificaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dataUltimaModifica',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataUltimaModificaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dataUltimaModifica',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataUltimaModificaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dataUltimaModifica',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataUltimaModificaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dataUltimaModifica',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataUltimaModificaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataUltimaModifica',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      dataUltimaModificaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dataUltimaModifica',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      descrizioneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'descrizione',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      descrizioneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'descrizione',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      descrizioneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'descrizione',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      descrizioneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'descrizione',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      editoreEqualTo(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      editoreGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      editoreLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      editoreBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      editoreStartsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      editoreEndsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      editoreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'editore',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      editoreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'editore',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      editoreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'editore',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      editoreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'editore',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      googleBookIdEqualTo(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      googleBookIdGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      googleBookIdLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      googleBookIdBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      googleBookIdStartsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      googleBookIdEndsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      googleBookIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'googleBookId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      googleBookIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'googleBookId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      googleBookIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'googleBookId',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      googleBookIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'googleBookId',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      immagineCopertinaEqualTo(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      immagineCopertinaGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      immagineCopertinaLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      immagineCopertinaBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      immagineCopertinaStartsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      immagineCopertinaEndsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      immagineCopertinaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'immagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      immagineCopertinaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'immagineCopertina',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      immagineCopertinaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'immagineCopertina',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      immagineCopertinaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'immagineCopertina',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      isEbookEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEbook',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      isbnEqualTo(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      isbnGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      isbnLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      isbnBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      isbnStartsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      isbnEndsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      isbnContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'isbn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      isbnMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'isbn',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      isbnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isbn',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      isbnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'isbn',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriElementEqualTo(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriElementGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriElementLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriElementBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriElementStartsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriElementEndsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lstAutori',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lstAutori',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lstAutori',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lstAutori',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriLengthEqualTo(int length) {
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriIsEmpty() {
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriIsNotEmpty() {
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriLengthLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriLengthGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstAutoriLengthBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaElementEqualTo(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaElementGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaElementLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaElementBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaElementStartsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaElementEndsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lstCategoria',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lstCategoria',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lstCategoria',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lstCategoria',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaLengthEqualTo(int length) {
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaIsEmpty() {
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaIsNotEmpty() {
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaLengthLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaLengthGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      lstCategoriaLengthBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      noteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      noteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      noteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      noteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      noteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      nrPagineEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nrPagine',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      nrPagineGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      nrPagineLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      nrPagineBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      pathImmagineCopertinaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pathImmagineCopertina',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      pathImmagineCopertinaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pathImmagineCopertina',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      pathImmagineCopertinaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pathImmagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      pathImmagineCopertinaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pathImmagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      pathImmagineCopertinaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pathImmagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      pathImmagineCopertinaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pathImmagineCopertina',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      pathImmagineCopertinaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pathImmagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      pathImmagineCopertinaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pathImmagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      pathImmagineCopertinaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pathImmagineCopertina',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      pathImmagineCopertinaMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pathImmagineCopertina',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      pathImmagineCopertinaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pathImmagineCopertina',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      pathImmagineCopertinaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pathImmagineCopertina',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      previewLinkEqualTo(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      previewLinkGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      previewLinkLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      previewLinkBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      previewLinkStartsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      previewLinkEndsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      previewLinkContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'previewLink',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      previewLinkMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'previewLink',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      previewLinkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previewLink',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      previewLinkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'previewLink',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      prezzoEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prezzo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      prezzoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prezzo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      prezzoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prezzo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      prezzoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prezzo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      siglaLibreriaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siglaLibreria',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      siglaLibreriaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'siglaLibreria',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      siglaLibreriaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'siglaLibreria',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      siglaLibreriaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'siglaLibreria',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      starsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stars',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      starsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stars',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      starsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stars',
        value: value,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      starsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stars',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      titoloEqualTo(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      titoloGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      titoloLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      titoloBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      titoloStartsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      titoloEndsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      titoloContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titolo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      titoloMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titolo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      titoloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titolo',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      titoloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titolo',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      valutaEqualTo(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      valutaGreaterThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      valutaLessThan(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      valutaBetween(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      valutaStartsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      valutaEndsWith(
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

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      valutaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'valuta',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      valutaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'valuta',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      valutaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valuta',
        value: '',
      ));
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      valutaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'valuta',
        value: '',
      ));
    });
  }
}

extension LibroIsarModelQueryObject
    on QueryBuilder<LibroIsarModel, LibroIsarModel, QFilterCondition> {}

extension LibroIsarModelQueryLinks
    on QueryBuilder<LibroIsarModel, LibroIsarModel, QFilterCondition> {
  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition> links(
      FilterQuery<LinkIsarModule> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'links');
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      linksLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'links', length, true, length, true);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      linksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'links', 0, true, 0, true);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      linksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'links', 0, false, 999999, true);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      linksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'links', 0, true, length, include);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      linksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'links', length, include, 999999, true);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      linksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'links', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition> setPdf(
      FilterQuery<PdfIsarModule> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'setPdf');
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      setPdfLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'setPdf', length, true, length, true);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      setPdfIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'setPdf', 0, true, 0, true);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      setPdfIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'setPdf', 0, false, 999999, true);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      setPdfLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'setPdf', 0, true, length, include);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      setPdfLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'setPdf', length, include, 999999, true);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterFilterCondition>
      setPdfLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'setPdf', lower, includeLower, upper, includeUpper);
    });
  }
}

extension LibroIsarModelQuerySortBy
    on QueryBuilder<LibroIsarModel, LibroIsarModel, QSortBy> {
  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByDataInserimento() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataInserimento', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByDataInserimentoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataInserimento', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByDataPubblicazione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataPubblicazione', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByDataPubblicazioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataPubblicazione', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByDataUltimaModifica() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataUltimaModifica', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByDataUltimaModificaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataUltimaModifica', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByDescrizione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByDescrizioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByEditore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editore', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByEditoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editore', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByGoogleBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleBookId', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByGoogleBookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleBookId', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByImmagineCopertina() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'immagineCopertina', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByImmagineCopertinaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'immagineCopertina', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByIsEbook() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEbook', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByIsEbookDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEbook', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByIsbn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isbn', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByIsbnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isbn', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByNrPagine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nrPagine', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByNrPagineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nrPagine', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByPathImmagineCopertina() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pathImmagineCopertina', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByPathImmagineCopertinaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pathImmagineCopertina', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByPreviewLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewLink', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByPreviewLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewLink', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByPrezzo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prezzo', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByPrezzoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prezzo', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortBySiglaLibreria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siglaLibreria', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortBySiglaLibreriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siglaLibreria', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByStars() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stars', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByStarsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stars', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByTitolo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titolo', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByTitoloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titolo', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> sortByValuta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuta', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      sortByValutaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuta', Sort.desc);
    });
  }
}

extension LibroIsarModelQuerySortThenBy
    on QueryBuilder<LibroIsarModel, LibroIsarModel, QSortThenBy> {
  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByCountry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByCountryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'country', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByDataInserimento() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataInserimento', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByDataInserimentoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataInserimento', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByDataPubblicazione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataPubblicazione', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByDataPubblicazioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataPubblicazione', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByDataUltimaModifica() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataUltimaModifica', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByDataUltimaModificaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataUltimaModifica', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByDescrizione() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByDescrizioneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descrizione', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByEditore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editore', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByEditoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'editore', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByGoogleBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleBookId', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByGoogleBookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'googleBookId', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByImmagineCopertina() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'immagineCopertina', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByImmagineCopertinaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'immagineCopertina', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByIsEbook() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEbook', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByIsEbookDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isEbook', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByIsbn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isbn', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByIsbnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isbn', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByNrPagine() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nrPagine', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByNrPagineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nrPagine', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByPathImmagineCopertina() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pathImmagineCopertina', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByPathImmagineCopertinaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pathImmagineCopertina', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByPreviewLink() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewLink', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByPreviewLinkDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewLink', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByPrezzo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prezzo', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByPrezzoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prezzo', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenBySiglaLibreria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siglaLibreria', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenBySiglaLibreriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siglaLibreria', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByStars() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stars', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByStarsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stars', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByTitolo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titolo', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByTitoloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'titolo', Sort.desc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy> thenByValuta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuta', Sort.asc);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QAfterSortBy>
      thenByValutaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuta', Sort.desc);
    });
  }
}

extension LibroIsarModelQueryWhereDistinct
    on QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> {
  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> distinctByCountry(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'country', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct>
      distinctByDataInserimento({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataInserimento',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct>
      distinctByDataPubblicazione({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataPubblicazione',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct>
      distinctByDataUltimaModifica({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataUltimaModifica',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> distinctByDescrizione(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descrizione', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> distinctByEditore(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'editore', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct>
      distinctByGoogleBookId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'googleBookId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct>
      distinctByImmagineCopertina({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'immagineCopertina',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> distinctByIsEbook() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isEbook');
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> distinctByIsbn(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isbn', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct>
      distinctByLstAutori() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lstAutori');
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct>
      distinctByLstCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lstCategoria');
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> distinctByNrPagine() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nrPagine');
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct>
      distinctByPathImmagineCopertina({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pathImmagineCopertina',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> distinctByPreviewLink(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'previewLink', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> distinctByPrezzo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prezzo');
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct>
      distinctBySiglaLibreria() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'siglaLibreria');
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> distinctByStars() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stars');
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> distinctByTitolo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titolo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LibroIsarModel, LibroIsarModel, QDistinct> distinctByValuta(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valuta', caseSensitive: caseSensitive);
    });
  }
}

extension LibroIsarModelQueryProperty
    on QueryBuilder<LibroIsarModel, LibroIsarModel, QQueryProperty> {
  QueryBuilder<LibroIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations> countryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'country');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations>
      dataInserimentoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataInserimento');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations>
      dataPubblicazioneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataPubblicazione');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations>
      dataUltimaModificaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataUltimaModifica');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations> descrizioneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descrizione');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations> editoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'editore');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations>
      googleBookIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'googleBookId');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations>
      immagineCopertinaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'immagineCopertina');
    });
  }

  QueryBuilder<LibroIsarModel, bool, QQueryOperations> isEbookProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isEbook');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations> isbnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isbn');
    });
  }

  QueryBuilder<LibroIsarModel, List<String>, QQueryOperations>
      lstAutoriProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lstAutori');
    });
  }

  QueryBuilder<LibroIsarModel, List<String>, QQueryOperations>
      lstCategoriaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lstCategoria');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<LibroIsarModel, int, QQueryOperations> nrPagineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nrPagine');
    });
  }

  QueryBuilder<LibroIsarModel, String?, QQueryOperations>
      pathImmagineCopertinaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pathImmagineCopertina');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations> previewLinkProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'previewLink');
    });
  }

  QueryBuilder<LibroIsarModel, double, QQueryOperations> prezzoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prezzo');
    });
  }

  QueryBuilder<LibroIsarModel, int, QQueryOperations> siglaLibreriaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'siglaLibreria');
    });
  }

  QueryBuilder<LibroIsarModel, int, QQueryOperations> starsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stars');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations> titoloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titolo');
    });
  }

  QueryBuilder<LibroIsarModel, String, QQueryOperations> valutaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valuta');
    });
  }
}
