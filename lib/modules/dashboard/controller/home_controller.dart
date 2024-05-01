import 'package:samastha/modules/dashboard/models/banner_model.dart';
import 'package:samastha/modules/dashboard/repository/home_repository.dart';

class HomeController {
  HomeRepository repository = HomeRepository();

  Future<List<BannerModel>> fetchBanners() async {
    try {
      return await repository.fetchBanners();
    } catch (e) {
      return Future.error(e);
    }
  }

 
}
