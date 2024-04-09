import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_gpt/constants.dart';
import 'package:flutter_chat_gpt/hive_model/chat_item_model.dart';
import 'package:flutter_chat_gpt/hive_model/message_item_model.dart';
import 'package:flutter_chat_gpt/hive_model/message_role_model.dart';
import 'package:flutter_chat_gpt/page/chat_list_page/bloc/chat_list_bloc.dart';
import 'package:flutter_chat_gpt/page/chat_list_page/chat_list_page.dart';
import 'package:flutter_chat_gpt/page/chat_page/bloc/chat_message_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChatItemModelAdapter());
  Hive.registerAdapter(MessageItemModelAdapter());
  Hive.registerAdapter(MessageRoleModelAdapter());
  await Hive.openBox<ChatItemModel>(KChatBox);
  await Hive.openBox<MessageItemModel>(kMessageBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatListBloc>(create: (context) => ChatListBloc()..add(const ChatListInitEvent())),
        BlocProvider<ChatMessagesBloc>(create: (context) => ChatMessagesBloc()),
      ],
      child: MaterialApp(
        title: 'Chat GPT',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ChatListPage(),
      ),
    );
  }
}
