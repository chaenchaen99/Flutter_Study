part of 'chat_list_bloc.dart';


class ChatListState {
  final List<ChatItemModel> chats;
  const ChatListState({this.chats = const []});

  ChatListState copyWith({ // ChatListState의 복사본을 생성하면서, 필요한 속성만 변경할 수 있게 해준다.
    List<ChatItemModel>? chats,
}) => ChatListState(
    chats: chats ?? this.chats
  );
}