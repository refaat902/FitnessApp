import 'package:flutter_application_1/core/netwroking/web_services.dart';
import 'package:flutter_application_1/views/aimeal/data/model/ai_meal_request_model.dart';
import 'package:flutter_application_1/views/aimeal/data/model/ai_meal_response_model.dart';

class AiMealRepo {
        final WebServices webServices;
  AiMealRepo(this.webServices);

  Future<AiMealResponsetModel> getAiMeals(AiMealRequestModel requestData) async {
    return await webServices.getAiMeals(requestData);
  }
}