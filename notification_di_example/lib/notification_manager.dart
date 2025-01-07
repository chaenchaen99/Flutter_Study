import 'package:notification_di_example/notification_service.dart';

class NotificationManager {
  final NotificationService notificationService;

  // NotificationManager는 주입된 NotificationService를 사용하여 알림을 보냄
  NotificationManager(this.notificationService);

  void notifyUser(String message) {
    notificationService.sendNotification(message);
  }
}
