// NotificationService: 알림 서비스 추상 클래스
abstract class NotificationService {
  void sendNotification(String message);
}

// NotificationService를 구현한 EmailNotificationService : 이메일 알림 서비스
class EmailNotificationService implements NotificationService {
  @override
  void sendNotification(String message) {
    print('이메일로 알림을 보냅니다: $message');
  }
}

// NotificationService를 구현한 SmsNotificationService : Sms 문자 알림 서비스
class SmsNotificationService implements NotificationService {
  @override
  void sendNotification(String message) {
    print('SMS로 알림을 보냅니다: $message');
  }
}

// NotificationService를 구현한 PushNotificationService : 푸시 알림 서비스
class PushNotificationService implements NotificationService {
  @override
  void sendNotification(String message) {
    print('푸시 알림으로 보냅니다: $message');
  }
}
