// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageItemModelAdapter extends TypeAdapter<MessageItemModel> {
  @override
  final int typeId = 1;

  @override
  MessageItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageItemModel(
      fields[0] as String,
      fields[1] as MessageRoleModel,
      fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MessageItemModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.role)
      ..writeByte(2)
      ..write(obj.createAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
