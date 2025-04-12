import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/category/data/model/meals_response_model.dart';
import 'package:flutter_application_1/views/category/data/repository/category_repo.dart';
import 'package:meta/meta.dart';

part 'lunch_state.dart';

class LunchCubit extends Cubit<LunchState> {
      final CategoryRepo categoryRepo;
  LunchCubit(this.categoryRepo) : super(LunchInitial());




  void emitMealsByType(String mealType) {
    try {
      categoryRepo.getMealsByType(mealType).then((mealByType) {
        emit(MealByTypeLunchSuccessState(mealByTypeList: mealByType));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
