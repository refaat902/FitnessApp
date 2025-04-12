import 'package:flutter_application_1/core/helpers/shared_pref_helper.dart';
import 'package:flutter_application_1/core/netwroking/web_services.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';


class GetFavExerciseRepo {
    final WebServices webServices;
  GetFavExerciseRepo(this.webServices);

  Future<List<ExeResponseModel>> getFavExercise() async {
    return await webServices.getFavoritesExercise('Bearer ${await SharedPrefService.getToken()}');
  }
}
