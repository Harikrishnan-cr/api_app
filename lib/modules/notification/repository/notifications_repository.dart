import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/notification/models/notifications_model.dart';

class NotificationRepository {
  DioClient dioClient = di.sl<DioClient>();

  Future<List<NotificationModel>> fetchNotifications(type) async {
    try {
      final response = await dioClient.post(Urls.fetchNotification, data: {
        "type": "students",
      });

      return List.generate(
        response.data["data"].length,
        (index) => NotificationModel.fromJson(response.data['data'][index]),
      );
    } catch (e) {
      return throw ApiException(e);
    }
  }
}
