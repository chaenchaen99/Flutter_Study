import 'package:flutter/foundation.dart';

class UserState with ChangeNotifier {
  String _username = "Chaeyeon"; // 기본 사용자 이름

  String get username => _username; // 사용자 이름 가져오기

  void updateUsername(String username) {
    _username = username; // 사용자 이름 업데이트
    notifyListeners(); // 상태 변경 알리기
  }
}
