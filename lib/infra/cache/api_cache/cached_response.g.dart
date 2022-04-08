// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedResponseAdapter extends TypeAdapter<CachedResponse> {
  @override
  final int typeId = 1;

  @override
  CachedResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedResponse(
      key: fields[0] as String,
      statusCode: fields[3] as int?,
      maxAgeMilliseconds: fields[1] as int,
      content: fields[2] as String?,
      headers: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CachedResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.maxAgeMilliseconds)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.statusCode)
      ..writeByte(4)
      ..write(obj.headers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedResponseAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
