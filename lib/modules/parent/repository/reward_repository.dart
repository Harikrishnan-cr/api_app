import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/parent/model/reward_model.dart';

class RewardsRepo {
  final DioClient dioClient = di.sl<DioClient>();

  Future<RewardModel> getRewards() async {
    try {
      final response = await dioClient.get(
        Urls.rewardsUrl,
      );
      return RewardModel.fromJson(response.data['data']);
    } catch (e) {
      print('errorrs $e');
      return throw ApiException(e);
    }
  }
}
