import 'package:flutter/material.dart';
import 'package:flutter_simple_app_statement/user_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserState(), // UserState 인스턴스 생성
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(), // 홈 화면으로 이동
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // 현재 선택된 탭 인덱스 (임시 상태)

  final List<Widget> _pages = [
    const UserPage(), // 사용자 페이지
    const SettingsPage(), // 설정 페이지
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ephemeral vs App State"), // 앱 바 제목
      ),
      body: _pages[_currentIndex], // 현재 선택된 페이지 표시
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // 현재 인덱스 설정
        onTap: (index) {
          setState(() {
            _currentIndex = index; // 탭 변경 시 상태 업데이트
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "User", // 사용자 탭
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings", // 설정 탭
          ),
        ],
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserState>(context); // 사용자 상태 가져오기

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome, ${userState.username}",
              style: const TextStyle(fontSize: 24)), // 사용자 이름 표시
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              userState.updateUsername("Suhyun"); // 버튼 클릭 시 사용자 이름 변경
            },
            child: const Text("Change Username"),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:
          Text("Settings Page", style: TextStyle(fontSize: 24)), // 설정 페이지 텍스트
    );
  }
}
