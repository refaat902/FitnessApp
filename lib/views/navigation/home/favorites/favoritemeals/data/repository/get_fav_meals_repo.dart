import 'package:flutter_application_1/core/helpers/shared_pref_helper.dart';
import 'package:flutter_application_1/core/netwroking/web_services.dart';
import 'package:flutter_application_1/views/category/data/model/meals_response_model.dart';


class GetFavMealsRepo {
    final WebServices webServices;
  GetFavMealsRepo(this.webServices);

  Future<List<MealsResponseModel>> getFavoritesMeal() async {
    return await webServices.getFavoritesMeal('Bearer ${await SharedPrefService.getToken()}');
  }
}