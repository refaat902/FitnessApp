import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/repository/add_fav_meal_repo.dart';
import 'package:meta/meta.dart';

part 'add_to_fav_meal_state.dart';

class AddToFavMealCubit extends Cubit<AddToFavMealState> {
      final AddFavMealRepo addFavMealRepo;
  AddToFavMealCubit(this.addFavMealRepo) : super(AddToFavMealInitial());



  void emitAddToFavMeal(String id) {
    try {
      addFavMealRepo.addToFavMeal(id).then((addToFavMeal) {
        emit(AddToFavMealSuccessState());
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }

    void emitDeleteFavMeal(String id) {
    try {
      addFavMealRepo.deleteFavMeal(id).then((addToFavMeal) {
        emit(DeleteFavMealSuccessState());
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
