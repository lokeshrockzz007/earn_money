import 'package:earn_money/actions/notification-manager.dart';
import 'package:flutter/material.dart';
import 'package:notifications/notifications.dart';

class NotificationsList extends StatefulWidget {
  NotificationsList();

  @override
  _NotificationsListState createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  NotificationsManager notificationsManager = NotificationsManager();
  static List<NotificationEvent> notificationsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationsSubscription();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notificationsList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(notificationsList[index].packageName),
        );
      },
    );
  }

  getNotificationsSubscription() {
    notificationsManager.subscribeNotifications().listen((notification) {
      notificationsList.add(notification);
    });
  }
}
