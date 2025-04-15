import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/category/data/model/meals_response_model.dart';
import 'package:flutter_application_1/views/category/data/repository/category_repo.dart';


part 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  final CategoryRepo categoryRepo;
  MealsCubit(this.categoryRepo) : super(MealsInitial());

  void emitMealsByType(String mealType) {
    try {
      categoryRepo.getMealsByType(mealType).then((mealByType) {
        emit(MealByTypeBreakFastState(mealByTypeList: mealByType));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
