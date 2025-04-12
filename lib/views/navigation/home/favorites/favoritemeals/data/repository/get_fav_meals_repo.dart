import 'package:flutter_application_1/core/helpers/shared_pref_helper.dart';
import 'package:flutter_application_1/core/netwroking/web_services.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/model/meal_model.dart';

class GetFavMealsRepo {
    final WebServices webServices;
  GetFavMealsRepo(this.webServices);

  Future<List<MealModel>> getFavoritesMeal() async {
    return await webServices.getFavoritesMeal('Bearer ${await SharedPrefService.getToken()}');
  }
}