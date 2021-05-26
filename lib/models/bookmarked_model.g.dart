// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarked_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedArticleModelAdapter extends TypeAdapter<SavedArticleModel> {
  @override
  final int typeId = 0;

  @override
  SavedArticleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedArticleModel(
      title: fields[0] as String,
      description: fields[1] as String,
      url: fields[2] as String,
      urlToImage: fields[3] as String,
      content: fields[4] as String,
      source: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedArticleModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.urlToImage)
      ..writeByte(4)
      ..write(obj.content)
      ..writeByte(5)
      ..write(obj.source);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedArticleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}