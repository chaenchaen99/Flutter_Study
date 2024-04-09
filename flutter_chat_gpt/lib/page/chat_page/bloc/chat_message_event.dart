part of 'chat_message_bloc.dart';

sealed class ChatMessageEvent {
  const ChatMessageEvent();
}

final class ChatMessagesInitialEvent extends ChatMessageEvent {
  final ChatItemModel chatItem;
  const ChatMessagesInitialEvent(this.chatItem);
}

final class ChatMessagesAddEvent extends ChatMessageEvent {
  final String message;
  const ChatMessagesAddEvent(this.message);
}