import 'dart:io';

import 'package:async_cache_example/api/api_service.dart';
import 'package:async_cache_example/data/todo_repository.dart';
import 'package:async_cache_example/model/todo.dart';
import 'package:async_cache_example/todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:dio/dio.dart';

void main() async {
  await Hive.initFlutter(); //Hive를 Flutter 앱과 함께 사용하기 위해 초기화하는 과정
  Hive.registerAdapter(
      ToDoAdapter()); //ToDo 객체를 Hive 데이터베이스에 저장하기 위해 필요한 어댑터를 등록
  await Hive.openBox<ToDo>(
      'todoBox'); //'todoBox'라는 이름의 Hive 박스(데이터베이스)를 열어 ToDo 객체를 저장하고 관리할 수 있다
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
      home: ToDoScreen(
        repository: ToDoRepository(
          ApiService(Dio(),
              baseUrl: Platform.isAndroid
                  ? 'http://10.0.2.2:3000'
                  : 'http://localhost:3000'),
          Hive.box<ToDo>('todoBox'),
        ),
      ),
    );
  }
}
