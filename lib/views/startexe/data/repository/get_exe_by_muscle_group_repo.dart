import 'package:flutter_application_1/core/helpers/shared_pref_helper.dart';
import 'package:flutter_application_1/core/netwroking/web_services.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';

class GetExeByMuscleGroupRepo {
  final WebServices webServices;

  GetExeByMuscleGroupRepo(this.webServices);

    Future<List<ExeResponseModel>> getExeByMuscleGroup(String muscleGroup) async {
    final token = await SharedPrefService.getToken();
    return await webServices.getExeByMusleGroup(muscleGroup, 'Bearer $token');
  }
}