import 'package:adawat_provider_app/helpers/common_functions.dart';
import 'package:adawat_provider_app/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'notifications_viewmodel.dart';
import 'notifications_model.dart';

final NotificationsViewModel viewModel = Get.find();

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: viewModel.notificationsList.length,
            itemBuilder: (context, index) {
              return NotificationItem(
                  notification: viewModel.notificationsList[index]);
            }
        )
      ],
    );
  }
}

/// Notification Tile widget
class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7.0, top: 7, right: 15),
      child: Row(
        children: [
          Expanded(
            child: notification.imageUrl == null ? Image.asset(
              'assets/icons/person_circle.png',
              color: Theme.of(context).colorScheme.secondary,
              fit: BoxFit.fitHeight,
              height: 50,
              width: 50,
            ) : Image.network(notification.imageUrl!),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.message!,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5,),
                Text(
                  CommonFunctions().getTimeDifference(notification.notificationTime!),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: darkThemeLightGrey
                    ),
                )
              ],
            ),
          ),
          notification.isRead! ? const SizedBox() : CircleAvatar(
            backgroundColor: Get.isDarkMode ? primaryDullYellow : primaryYellow,
            radius: 5,
          ),
        ],
      ),
    );
  }
}