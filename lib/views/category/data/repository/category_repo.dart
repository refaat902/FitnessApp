import 'package:flutter_application_1/core/helpers/shared_pref_helper.dart';
import 'package:flutter_application_1/core/netwroking/web_services.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/category/data/model/meals_response_model.dart';

class CategoryRepo {
  final WebServices webServices;

  CategoryRepo(this.webServices);

  Future<List<MealsResponseModel>> getMealsByType(String mealType) async {
    final token = await SharedPrefService.getToken();
    return await webServices.getMeals(mealType, 'Bearer $token');
  }



    Future<List<ExeResponseModel>> getExeByType(String exeType) async {
    final token = await SharedPrefService.getToken();
    return await webServices.getExe(exeType, 'Bearer $token');
  }
}
