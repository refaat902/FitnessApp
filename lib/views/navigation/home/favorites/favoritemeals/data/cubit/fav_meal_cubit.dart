import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/category/data/model/meals_response_model.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/repository/get_fav_meals_repo.dart';


part 'fav_meal_state.dart';

class FavMealCubit extends Cubit<FavMealState> {
  final GetFavMealsRepo getFavMealsRepo;
  FavMealCubit(this.getFavMealsRepo) : super(FavMealInitial());

  void emitGetFavMeal() {
    try {
      getFavMealsRepo.getFavoritesMeal().then((favMealList) {
        emit(FavMealSuccessState(favMealList: favMealList));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
