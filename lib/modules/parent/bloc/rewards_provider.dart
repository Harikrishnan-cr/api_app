import 'package:flutter/cupertino.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/modules/parent/model/reward_model.dart';
import 'package:samastha/helper/service_locator.dart' as di;

class RewardProvider extends ChangeNotifier {
  final DioClient dioClient = di.sl<DioClient>();
  RewardProvider() {
    onRewardModelAdded();
  }

  RewardModelData? rewardData;

  bool isLoading = false;

  void onRewardModelAdded() async {
    isLoading = true;

    final response = await dioClient.get(
      Urls.rewardsUrl,
    );

    try {
      final data = RewardModel.fromJson(response.data);

      rewardData = data.data;
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }

    isLoading = false;
    notifyListeners();
  }
}
