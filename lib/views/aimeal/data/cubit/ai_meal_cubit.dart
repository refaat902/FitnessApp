import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/aimeal/data/model/ai_meal_request_model.dart';
import 'package:flutter_application_1/views/aimeal/data/model/ai_meal_response_model.dart';
import 'package:flutter_application_1/views/aimeal/data/repository/ai_meal_repo.dart';
import 'package:meta/meta.dart';

part 'ai_meal_state.dart';

class AiMealCubit extends Cubit<AiMealState> {
      final AiMealRepo aiMealRepo;
  AiMealCubit(this.aiMealRepo) : super(AiMealInitial());





  void emitGetAiMeals(AiMealRequestModel requestData) {
    try {
      aiMealRepo.getAiMeals(requestData).then((responseData) {
        emit(GetAiMealsSuccessState(responseData: responseData));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
