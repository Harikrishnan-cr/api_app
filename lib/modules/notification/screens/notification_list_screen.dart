import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/core/date_time_converter.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/courses/models/lesson_media_model.dart';
import 'package:samastha/modules/notification/controller/notifications_controller.dart';
import 'package:samastha/modules/notification/models/notifications_model.dart';
import 'package:samastha/theme/dimensions.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key});
  static const String path = '/notifications-screen';

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  NotificationController bloc = NotificationController();

  late Future<List<NotificationModel>> future;

  @override
  void initState() {
    future = bloc.fetchNotifications('students');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(
          title: 'Notifications',
          leadingWidget: Icon(
            Icons.arrow_back,
            color: Colors.transparent,
          )),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return errorReload(snapshot.error.toString(),
                onTap: () => future = bloc.fetchNotifications('students'));
          }
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              List<NotificationModel> list = snapshot.data ?? [];
              return list.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.image.noNotifications.image(width: 315),
                        const Gap(15),
                        Text(
                          'You currently have no new notifications',
                          style: titleLarge.darkBG.copyWith(fontSize: 15),
                        ),
                        const Gap(30),
                      ],
                    ))
                  : ListView.builder(
                      itemCount: list.length,
                      padding: pagePadding,
                      itemBuilder: (context, index) => _Item(
                          title: list[index].title ?? '',
                          description: list[index].description ?? '',
                          time: getComabainedDateTime(
                                  dateStr: (list[index].scheduledDate ??
                                      'set-jan-2024'),
                                  timeStr: (list[index].scheduledTime ??
                                      'set-jan-2024'))
                              .toString()));
            case ConnectionState.waiting:
              return const LoadingWidget();
            default:
              return Container();
          }
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(
      {required this.title, required this.description, required this.time});
  final String title;
  final String description;
  final String? time;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: defaultDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Assets.image.notificationItem.image(height: 40),
          const Gap(12),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    // flex: 3,
                    child: Text(
                      title,
                      style: titleSmall.darkBG,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // const Spacer(),
                  // Expanded(
                  //   flex: 1,
                  //   child: Text(
                  //     timeAgo.format(
                  //       time == null ? DateTime.now() : DateTime.parse(time!),
                  //     ),
                  //     style: labelMedium.grey1,
                  //   ),
                  // ),
                ],
              ),
              description.isNotEmpty ? const Gap(8) : const Gap(0),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: labelMedium.grey1,
              ),
              description.isNotEmpty ? const Gap(10) : const Gap(0),
              Text(
                //'$time',
                timeAgo.format(
                  time == null ? DateTime.now() : DateTime.parse(time!),
                ),
                style: labelMedium.darkBG.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
