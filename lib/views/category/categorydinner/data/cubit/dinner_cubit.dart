import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/category/data/model/meals_response_model.dart';
import 'package:flutter_application_1/views/category/data/repository/category_repo.dart';
import 'package:meta/meta.dart';

part 'dinner_state.dart';

class DinnerCubit extends Cubit<DinnerState> {
  final CategoryRepo categoryRepo;
  DinnerCubit(this.categoryRepo) : super(DinnerInitial());

  void emitMealsByType(String mealType) {
    try {
      categoryRepo.getMealsByType(mealType).then((mealByType) {
        emit(MealByTypeDinnerSuccessState(mealByTypeList: mealByType));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
