// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_action_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardActionModelAdapter extends TypeAdapter<CardActionModel> {
  @override
  final int typeId = 0;

  @override
  CardActionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardActionModel(
      cardId: fields[0] as int,
      action: fields[1] as String,
      timestamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CardActionModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cardId)
      ..writeByte(1)
      ..write(obj.action)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardActionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
