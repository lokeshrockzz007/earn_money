import 'package:notifications/notifications.dart';

class NotificationsManager {
  static Notifications notifications;
  Stream<NotificationEvent> subscribeNotifications() {
    notifications = Notifications();
    return notifications.stream;
  }
}
