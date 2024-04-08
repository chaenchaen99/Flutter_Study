// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_role_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageRoleModelAdapter extends TypeAdapter<MessageRoleModel> {
  @override
  final int typeId = 2;

  @override
  MessageRoleModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MessageRoleModel.ai;
      case 1:
        return MessageRoleModel.user;
      default:
        return MessageRoleModel.ai;
    }
  }

  @override
  void write(BinaryWriter writer, MessageRoleModel obj) {
    switch (obj) {
      case MessageRoleModel.ai:
        writer.writeByte(0);
        break;
      case MessageRoleModel.user:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageRoleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
