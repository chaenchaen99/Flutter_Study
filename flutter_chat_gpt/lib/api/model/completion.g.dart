// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletionRequest _$CompletionRequestFromJson(Map<String, dynamic> json) =>
    CompletionRequest(
      json['model'] as String,
      (json['messages'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$CompletionRequestToJson(CompletionRequest instance) =>
    <String, dynamic>{
      'model': instance.model,
      'messages': instance.messages,
    };

CompletionResponse _$CompletionResponseFromJson(Map<String, dynamic> json) =>
    CompletionResponse(
      json['id'] as String,
      json['created'] as int,
      json['model'] as String,
      (json['choices'] as List<dynamic>)
          .map((e) => ChoiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompletionResponseToJson(CompletionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices,
    };

ChoiceModel _$ChoiceModelFromJson(Map<String, dynamic> json) => ChoiceModel(
      json['index'] as int,
      MessageModel.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChoiceModelToJson(ChoiceModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'message': instance.message,
    };

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      json['role'] as String,
      json['content'] as String,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'role': instance.role,
      'content': instance.content,
    };
