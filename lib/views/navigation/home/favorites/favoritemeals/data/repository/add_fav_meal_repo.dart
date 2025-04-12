import 'package:flutter_application_1/core/helpers/shared_pref_helper.dart';
import 'package:flutter_application_1/core/netwroking/web_services.dart';

class AddFavMealRepo {
      final WebServices webServices;
  AddFavMealRepo(this.webServices);

  Future<void> addToFavMeal(String id) async {
    return await webServices.addToFavMeal(id,'Bearer ${await SharedPrefService.getToken()}');
  }

    Future<void> deleteFavMeal(String id) async {
    return await webServices.deleteFavMeal(id,'Bearer ${await SharedPrefService.getToken()}');
  }
}