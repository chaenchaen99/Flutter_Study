import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('', () async {
      final response =
      await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200){
        print(json.decode(response.body));
      }else{
        throw Exception('데이터를 불러오는 데 실패했습니다.');
      }
  }, skip:false);
}

