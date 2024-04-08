import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/constants.dart';
import 'package:flutter_chat_gpt/hive_model/chat_item_model.dart';
import 'package:flutter_chat_gpt/hive_model/message_item_model.dart';
import 'package:flutter_chat_gpt/hive_model/message_role_model.dart';
import 'package:flutter_chat_gpt/page/chat_list_page/chat_list_page.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChatListPage(),
    );
  }
}
