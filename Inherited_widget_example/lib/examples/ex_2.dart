import 'package:flutter/material.dart';

// 사용자 설정을 나타내는 클래스
class UserSettings {
  bool darkMode; // 다크 모드 설정
  UserSettings({this.darkMode = false}); // 기본값으로 다크 모드를 끈 상태로 초기화
}

// InheritedWidget을 사용하는 StatefulWidget 예제
class InheritedWidgetExample2 extends StatefulWidget {
  const InheritedWidgetExample2({super.key});

  @override
  State<InheritedWidgetExample2> createState() => _InheritedWidgetExample2State();
}

// InheritedWidgetExample2의 상태를 관리하는 클래스
class _InheritedWidgetExample2State extends State<InheritedWidgetExample2> {
  UserSettings settings = UserSettings(darkMode: false); // 사용자 설정 초기화

  // 다크 모드를 토글하는 함수
  void _toggleDarkMode(bool value) {
    setState(() {
      settings.darkMode = value; // 다크 모드 설정 변경
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: settings.darkMode ? ThemeData.dark() : ThemeData.light(), // 다크 모드 설정에 따라 테마 변경
    home: Scaffold(
      appBar: AppBar(
        title: const Text('User Settings Inherited Widget'),
      ),
      body: UserSettingsInheritedWidget(
        settings: settings,
        toggleDartMode: _toggleDarkMode,
        child: Center( //const 붙이면 안됨, 화면이 바뀌지 않음.
          child: SettingsWidget(),
        ),
      ),
    ),
  );
}

// 사용자 설정을 표시하고, 다크 모드를 토글할 수 있는 스위치를 제공하는 위젯
class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = UserSettingsInheritedWidget.of(context); // UserSettingsInheritedWidget에서 사용자 설정 가져오기

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Dark Mode is ${inheritedWidget.settings.darkMode ? 'ON' : 'OFF'}'), // 다크 모드 상태 표시
        Switch(
          value: inheritedWidget.settings.darkMode, // 다크 모드 설정 값
          onChanged: inheritedWidget.toggleDartMode, // 다크 모드 토글 함수 호출
        ),
      ],
    );
  }
}

// 사용자 설정을 앱 전반에 걸쳐 공유하는 InheritedWidget 클래스
class UserSettingsInheritedWidget extends InheritedWidget {
  final UserSettings settings; // 사용자 설정
  final void Function(bool) toggleDartMode; // 다크 모드 토글 함수

  const UserSettingsInheritedWidget({
    super.key,
    required super.child,
    required this.settings,
    required this.toggleDartMode,
  });

  // 현재 context에서 UserSettingsInheritedWidget 찾아서 반환
  static UserSettingsInheritedWidget of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<UserSettingsInheritedWidget>();
    assert(result != null, 'No UserSettingsInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(UserSettingsInheritedWidget oldWidget) {
    return oldWidget.settings.darkMode != settings.darkMode; // 다크 모드 설정 변경 여부에 따라 알림 전달
  }
}
