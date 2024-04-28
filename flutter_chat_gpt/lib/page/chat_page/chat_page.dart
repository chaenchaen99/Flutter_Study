import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_gpt/hive_model/chat_item_model.dart';
import 'package:flutter_chat_gpt/hive_model/message_item_model.dart';
import 'package:flutter_chat_gpt/page/chat_page/bloc/chat_message_bloc.dart';
import 'package:flutter_chat_gpt/page/chat_page/widgets/chat_input.dart';
import 'package:flutter_chat_gpt/page/chat_page/widgets/message_date_item.dart';
import 'package:flutter_chat_gpt/page/chat_page/widgets/message_item.dart';
import 'package:flutter_chat_gpt/utils/chat_date_utils.dart';

class ChatPage extends StatefulWidget {
  final ChatItemModel chatItem;
  const ChatPage({super.key, required this.chatItem});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    BlocProvider.of<ChatMessagesBloc>(context)
        .add(ChatMessagesInitialEvent(widget.chatItem));
  }

  void _scrollListener() {
    if (_scrollController.offset < _scrollController.position.maxScrollExtent) {
      setState(() {
        _showScrollButton = true;
      });
    } else {
      //scroll의 offset이 가장 하단에 위치한다면 -> 다음 내용을 불러와야 한다면
      setState(() {
        _showScrollButton = false;
      });
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void _addMessage(String message) {
    BlocProvider.of<ChatMessagesBloc>(context)
        .add(ChatMessagesAddEvent(message));
  }

  Map<String, List<MessageItemModel>> _groupMessagesByDate(
      List<MessageItemModel> messages) {
    Map<String, List<MessageItemModel>> grouped = {};
    for (var message in messages) {
      String formattedDate = ChatDateUtils.formatDateTime(message.createAt);
      if (grouped.containsKey(formattedDate)) {
        // 날짜로 구분되어 있으면
        grouped[formattedDate]?.add(message); // 메세지 추가
      } else {
        grouped[formattedDate] = [message]; //날짜로 구분후 리스트 추가
      }
    }
    return grouped;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<ChatMessagesBloc, ChatMessagesState>(
        listener: (context, state) {
          if (state.messages.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (_scrollController.hasClients) {
                _scrollToBottom();
              }
            });
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Chat Room'),
          ),
          body: CustomScrollView(
            controller: _scrollController,
            slivers:
                _groupMessagesByDate(state.messages).entries.expand((entry) {
              String date = entry.key;
              List<MessageItemModel> messages = entry.value;
              List<Widget> children = [];

              children
                  .add(SliverToBoxAdapter(child: MessageDateItem(date: date)));

              children.add(
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: messages.length,
                    (context, index) => MessageItem(item: messages[index]),
                  ),
                ),
              );

              return children;
            }).toList(),
          ),
          floatingActionButton: _showScrollButton
              ? FloatingActionButton(
                  onPressed: _scrollToBottom,
                  child: const Icon(Icons.arrow_downward))
              : null,
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
            child: ChatInput(
              isLoading: state.isLoading,
              onSend: _addMessage,
            ),
          ),
        ),
      );
}
