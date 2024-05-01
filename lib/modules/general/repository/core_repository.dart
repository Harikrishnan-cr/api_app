import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/api_exception.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/general/model/country_model.dart';

class CoreRepository {
  final DioClient dioClient = DioClient();

  Future<String?> getImageUrl(String path) async {
    try {
      final response = await dioClient.get(Urls.getSignedURL + path);
      return response.data['response'];
    } catch (e) {
      return null;
    }
  }

  Future<List<CountryModel>> fetchCountriesList(String keyword) async {
    try {
      final DioClient dioClient = di.sl<DioClient>();
      final response = await dioClient.get(
        Urls.countries,
      );

      return List.generate(response.data['data'].length,
          (index) => CountryModel.fromJson(response.data['data'][index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }

  Future<List<CountryModel>> fetchStateList(int countryId) async {
    try {
      final DioClient dioClient = di.sl<DioClient>();
      final response =
          await dioClient.post(Urls.states, data: {'countryId': countryId});

      return List.generate(response.data['data'].length,
          (index) => CountryModel.fromJson(response.data['data'][index]));
    } catch (e) {
      return throw ApiException(e);
    }
  }
}
