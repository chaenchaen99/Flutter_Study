import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import 'notification_manager.dart';
import 'notification_service.dart';

// 알림 서비스 선택 타입을 Enum으로 정의
enum NotificationType {
  sms,
  email,
  push,
}

// ViewModel 클래스
class NotificationViewModel extends StateNotifier<NotificationManager?> {
  NotificationViewModel() : super(null);

  // 알림 서비스를 선택하고, 그에 맞는 NotificationManager를 설정
  void selectNotificationService(NotificationType notificationType) {
    NotificationService notificationService;

    // 선택된 알림 서비스에 따라 알림 서비스를 설정
    switch (notificationType) {
      case NotificationType.sms:
        notificationService = SmsNotificationService();
        break;
      case NotificationType.email:
        notificationService = EmailNotificationService();
        break;
      case NotificationType.push:
        notificationService = PushNotificationService();
        break;
    }

    // NotificationManager 생성 및 상태 업데이트
    state = NotificationManager(notificationService);
  }

  // 알림 전송 메소드
  void sendNotification(String message) {
    state?.notifyUser(message);
  }
}

// Riverpod Provider: NotificationViewModel을 위한 Provider
final notificationViewModelProvider =
    StateNotifierProvider<NotificationViewModel, NotificationManager?>((ref) {
  return NotificationViewModel();
});
