
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class ToDo extends HiveObject {
  @HiveField(0)
  @JsonKey(name: '_id')
  String id;

  @HiveField(1)
  String text;

  @HiveField(2)
  bool done;

  ToDo({
    required this.id,
    required this.text,
    this.done = false
  });

  //JSON 형태의 데이터를 받아서 ToDo 클래스의 인스턴스로 변환하는 팩토리 생성자
  factory ToDo.fromJson(Map<String, dynamic> json) => _$ToDoFromJson(json);
 //ToDo 객체를 JSON 형태의 Map<String, dynamic>으로 변환하는 메서드
  Map<String, dynamic> toJson() => _$ToDoToJson(this);

}