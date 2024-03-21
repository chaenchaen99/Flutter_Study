import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FutureBuilderExample2 extends StatelessWidget {
  const FutureBuilderExample2({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('사용자 리스트')),
    body: FutureBuilder<List<dynamic>>(
      future: fetchUsers(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }else if (snapshot.hasError){
          return Center(child: Text('Error: ${snapshot.error}'));
        }else {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder:
          (context, index) {
              var user = snapshot.data![index];
              return ListTile(
                title: Text(user['name']),
                subtitle: Text(user['email']),
              );
          },
          );
        }
      },
    ),
  );
}

Future<List<dynamic>> fetchUsers() async {
  final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200){
    return json.decode(response.body);
  }else{
    throw Exception('데이터를 불러오는 데 실패했습니다.');
  }
}
