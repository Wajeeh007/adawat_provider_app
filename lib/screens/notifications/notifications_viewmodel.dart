import 'package:get/get.dart';
import 'notifications_model.dart';

class NotificationsViewModel extends GetxController {

  RxList<NotificationModel> notificationsList = <NotificationModel>[
    NotificationModel(message: 'Test Message, Your provider or serviceman is on the way', isRead: false, notificationTime: DateTime.now()),
    NotificationModel(message: 'Test Message, Your provider or serviceman is on the way', isRead: false, notificationTime: DateTime.now()),
    NotificationModel(message: 'Test Message, Your provider or serviceman is on the way', isRead: true, notificationTime: DateTime.now().subtract(const Duration(days: 2))),
    NotificationModel(message: 'Test Message, Your provider or serviceman is on the way', isRead: true, notificationTime: DateTime.now().subtract(const Duration(days: 4))),
    NotificationModel(message: 'Test Message, Your provider or serviceman is on the way', isRead: true, notificationTime: DateTime.now().subtract(const Duration(days: 4))),
    NotificationModel(message: 'Test Message, Your provider or serviceman is on the way', isRead: true, notificationTime: DateTime.now().subtract(const Duration(days: 5))),
  ].obs;



}