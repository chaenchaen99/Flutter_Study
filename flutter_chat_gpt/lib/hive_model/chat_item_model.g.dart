// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatItemModelAdapter extends TypeAdapter<ChatItemModel> {
  @override
  final int typeId = 0;

  @override
  ChatItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatItemModel(
      fields[0] as String,
      (fields[1] as List).cast<MessageItemModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ChatItemModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.messages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
