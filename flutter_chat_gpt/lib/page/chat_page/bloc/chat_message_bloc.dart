import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_gpt/api/api_service.dart';
import 'package:flutter_chat_gpt/api/helper.dart';
import 'package:flutter_chat_gpt/constants.dart';
import 'package:flutter_chat_gpt/hive_model/message_role_model.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:loggy/loggy.dart';
import '../../../hive_model/chat_item_model.dart';
import '../../../hive_model/message_item_model.dart';

part 'chat_message_event.dart';

part 'chat_message_state.dart';

class ChatMessagesBloc extends Bloc<ChatMessageEvent, ChatMessagesState> {
  ChatMessagesBloc() : super(ChatMessagesLoadingState()) {
    on<ChatMessagesInitialEvent>(_onChatMessageInit);
    on<ChatMessagesAddEvent>(_addMessage);
  }

  final _apiService = ApiService(
    Dio()
      ..interceptors.addAll([
        LoggyDioInterceptor(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          responseLevel: LogLevel.all,
          requestLevel: LogLevel.all,
          errorLevel: LogLevel.all,
        )
      ])
      ..options.headers['Authorization'] = kApiKey,
  );

  void _onChatMessageInit(
      ChatMessagesInitialEvent event, Emitter<ChatMessagesState> emit) {
    final chatItem = event.chatItem;
    final messages = chatItem.messages;

    emit(state.copyWith(
      chatItem: chatItem,
      messages: messages,
    ));
  }

  void _addMessage(
      ChatMessagesAddEvent event, Emitter<ChatMessagesState> emit) async {
    final message = event.message;
    final newMessage = MessageItemModel(message, MessageRoleModel.user, DateTime.now());
    state.chatItem?.messages.add(newMessage);
    state.chatItem?.save();
    emit(state.copyWith(messages: state.messages, isLoading: true));
    //사용자가 채팅을 입력 후 API로부터 응답을 기다리는 상황

    final response = await _apiService.getCompletion(state.messages.toCompletionRequest());
    final completion = response.choices.first.message.content;
    final newAiMessage = MessageItemModel(message, MessageRoleModel.ai, DateTime.now());
    state.chatItem?.messages.add(newAiMessage);
    state.chatItem?.save();
    emit(state.copyWith(messages: state.messages, isLoading: false));
  }
}
