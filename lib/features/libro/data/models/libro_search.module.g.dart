// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libro_search.module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LibroSearchModelAdapter extends TypeAdapter<LibroSearchModel> {
  @override
  final int typeId = 2;

  @override
  LibroSearchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LibroSearchModel(
      googleBookId: fields[0] as String,
      isbn: fields[1] as String,
      titolo: fields[2] as String,
      lstAutori: (fields[3] as List).cast<String>(),
      editore: fields[4] as String,
      descrizione: fields[5] as String,
      immagineCopertina: fields[6] as String,
      dataPubblicazione: fields[7] as String,
      nrPagine: fields[8] as int,
      lstCategoria: (fields[9] as List).cast<String>(),
      previewLink: fields[10] as String,
      isEbook: fields[11] as bool,
      country: fields[12] as String,
      valuta: fields[13] as String,
      prezzo: fields[14] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LibroSearchModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.googleBookId)
      ..writeByte(1)
      ..write(obj.isbn)
      ..writeByte(2)
      ..write(obj.titolo)
      ..writeByte(3)
      ..write(obj.lstAutori)
      ..writeByte(4)
      ..write(obj.editore)
      ..writeByte(5)
      ..write(obj.descrizione)
      ..writeByte(6)
      ..write(obj.immagineCopertina)
      ..writeByte(7)
      ..write(obj.dataPubblicazione)
      ..writeByte(8)
      ..write(obj.nrPagine)
      ..writeByte(9)
      ..write(obj.lstCategoria)
      ..writeByte(10)
      ..write(obj.previewLink)
      ..writeByte(11)
      ..write(obj.isEbook)
      ..writeByte(12)
      ..write(obj.country)
      ..writeByte(13)
      ..write(obj.valuta)
      ..writeByte(14)
      ..write(obj.prezzo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibroSearchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
