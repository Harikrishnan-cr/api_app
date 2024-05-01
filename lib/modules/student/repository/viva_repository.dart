import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/date_converter.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/student/models/time_slots_model.dart';
import 'package:samastha/modules/student/models/viva_call_model.dart';

class VivaRepository {
  final DioClient dioClient = di.sl<DioClient>();

  Future<List<DateTime>> fetchDates(DateTime date, int studentId) async {
    try {
      final response = await dioClient.post(Urls.vivaDates, data: {
        "student_id": studentId,
        "month": date.month,
        "year": date.year
      });
      var data = response.data['data']['vivaDetails'];
      return List.generate(
          data.length, (index) => DateTime.parse(data[index]['vivaDate']));
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<TimeSlotModel>> fetchSlots(
      DateTime currentDate, int studentId) async {
    try {
      final response = await dioClient.post(Urls.fetchSlots,
          data: {"student_id": studentId, "viva_date": currentDate.yyyymmdd});
      var data = response.data['data']['vivaTimes'];
      return List.generate(
          data.length, (index) => TimeSlotModel.fromJson(data[index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }

  submitSlotForViva(int studentId, TimeSlotModel model) async {
    try {
      final response = await dioClient.post(Urls.scheduleSlot,
          data: {"student_id": studentId, "viva_id": model.id});
      return response.data['status'];
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<VivaCallModel> vivaCall(int? studentId, vivaId) async {
    try {
      final response = await dioClient.post(Urls.vivaCall,
          data: {"student_id": studentId, "viva_id": vivaId});
      return VivaCallModel.fromJson(response.data['data']);
    } catch (e) {
      return throw ApiException(e);
    }
  }

  submitViva(int? studentId, int? vivaId) async {
    try {
      final response = await dioClient.post(Urls.submitViva,
          data: {"student_id": studentId, "viva_id": vivaId});
      return response.data['status'];
    } catch (e) {
      return throw ApiException(e);
    }
  }
}
