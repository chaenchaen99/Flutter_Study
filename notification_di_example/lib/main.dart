import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notification_viewmodel.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
// const MainApp({super.key});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ViewModel 접근
    final notificationViewModel =
        ref.watch(notificationViewModelProvider.notifier);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('알림 시스템')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // 알림 서비스로 SMS 선택
                  notificationViewModel
                      .selectNotificationService(NotificationType.sms);
                  notificationViewModel
                      .sendNotification('SMS로 새로운 알림이 도착했습니다!');
                },
                child: const Text('SMS로 알림 보내기'),
              ),
              ElevatedButton(
                onPressed: () {
                  // 알림 서비스로 이메일 선택
                  notificationViewModel
                      .selectNotificationService(NotificationType.email);
                  notificationViewModel
                      .sendNotification('이메일로 새로운 알림이 도착했습니다!');
                },
                child: const Text('이메일로 알림 보내기'),
              ),
              ElevatedButton(
                onPressed: () {
                  // 알림 서비스로 푸시 알림 선택
                  notificationViewModel
                      .selectNotificationService(NotificationType.push);
                  notificationViewModel
                      .sendNotification('푸시 알림으로 새로운 알림이 도착했습니다!');
                },
                child: const Text('푸시 알림 보내기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
