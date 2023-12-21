// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libreria.module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LibreriaModelAdapter extends TypeAdapter<LibreriaModel> {
  @override
  final int typeId = 1;

  @override
  LibreriaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LibreriaModel(
      sigla: fields[0] as String,
      nome: fields[1] as String,
      nrLibriCaricati: fields[2] as int,
      isLibreriaDefault: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LibreriaModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sigla)
      ..writeByte(1)
      ..write(obj.nome)
      ..writeByte(2)
      ..write(obj.nrLibriCaricati)
      ..writeByte(3)
      ..write(obj.isLibreriaDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibreriaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
