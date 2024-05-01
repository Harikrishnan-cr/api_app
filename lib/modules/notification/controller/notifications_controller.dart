import 'package:samastha/modules/notification/models/notifications_model.dart';
import 'package:samastha/modules/notification/repository/notifications_repository.dart';
import 'package:samastha/widgets/custom_snackbar.dart';

class NotificationController {
  NotificationRepository repository = NotificationRepository();

  Future<List<NotificationModel>> fetchNotifications(
      type) async {
    try {
      return await repository.fetchNotifications(type);
    } catch (e) {
      SnackBarCustom.success(e.toString());
      return Future.error(e);
    }
  }
}
