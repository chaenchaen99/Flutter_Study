// Dart의 비동기 프로그래밍을 위한 라이브러리를 임포트합니다.
import 'dart:async';

// API 호출을 위한 서비스와 Hive 데이터베이스를 사용하기 위한 라이브러리를 임포트합니다.
import 'package:async_cache_example/api/api_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ToDo 모델을 정의한 파일을 임포트합니다.
import '../model/todo.dart';

// ToDoRepository 클래스를 정의합니다. 이 클래스는 API 호출과 로컬 캐싱을 관리합니다.
class ToDoRepository {
  // ApiService와 Hive 데이터베이스의 Box<ToDo> 인스턴스를 멤버 변수로 선언합니다.
  final ApiService _apiService;
  final Box<ToDo> _todoBox;
  // ToDo 목록을 스트림으로 관리하기 위한 StreamController를 선언합니다.
  final _toDosController = StreamController<List<ToDo>>();

  // 생성자에서 ApiService와 Box<ToDo> 인스턴스를 받아 멤버 변수에 할당하고 초기화 메서드를 호출합니다.
  ToDoRepository(this._apiService, this._todoBox) {
    _initialize();
  }

  // ToDo 목록을 스트림으로 제공하는 getter를 정의합니다.
  Stream<List<ToDo>> get toDosStream => _toDosController.stream;

  // 초기화 메서드에서는 캐시된 데이터를 스트림에 추가하고, API를 통해 새로운 데이터를 가져와 캐시를 업데이트합니다.
  void _initialize() async {
    _emitCachedData(); // 캐시된 데이터를 스트림에 추가합니다.
    await _fetchAndCacheToDos(); // API를 통해 새로운 데이터를 가져와 캐시를 업데이트합니다.
  }

  // 캐시된 데이터를 스트림에 추가하는 메서드입니다.
  void _emitCachedData() {
    final cachedToDos = _todoBox.values.toList();
    _toDosController.add(cachedToDos);
  }

  // API를 통해 ToDo 목록을 가져와 로컬 데이터베이스에 캐싱하고, 캐시된 데이터로 스트림을 업데이트하는 메서드입니다.
  Future<void> _fetchAndCacheToDos() async {
    try {
      final toDos = await _apiService.getToDos();
      for (var toDo in toDos){
        _todoBox.put(toDo.id, toDo); // 각 ToDo 항목을 로컬 데이터베이스에 저장합니다.
      }
      _emitCachedData(); // 새로운 데이터로 스트림을 업데이트합니다.
    } catch (e) {
      print('Error fetching ToDos: $e'); // API 호출 중 오류가 발생하면 오류 메시지를 출력합니다.
    }
  }
  void dispose() {
    _toDosController.close();
  }
}
