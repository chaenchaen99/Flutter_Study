import 'package:hive_flutter/hive_flutter.dart';

part 'message_role_model.g.dart';

//@HiveType 어노테이션은 이 열거형이 Hive 데이터베이스에 저장될 객체임을 나타낸다.
@HiveType(typeId: 2)
enum MessageRoleModel {
  @HiveField(0)
  ai,
  @HiveField(1)
  user,
}