import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/dashboard/models/banner_model.dart';

class HomeRepository {
  final DioClient dioClient = di.sl<DioClient>();

  Future<List<BannerModel>> fetchBanners() async {
    try {
      final response = await dioClient.get(
        Urls.bannersList,
      );

      return List.generate(
          response.data['data']['data'].length,
          (index) =>
              BannerModel.fromJson(response.data['data']['data'][index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }

}
