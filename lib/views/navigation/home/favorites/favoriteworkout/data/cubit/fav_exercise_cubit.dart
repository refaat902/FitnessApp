import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/navigation/exercise/data/models/exercise_model.dart';
import 'package:flutter_application_1/views/navigation/exercise/data/repository/get_all_categories_repo.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/repository/get_fav_exercise_repo.dart';
import 'package:meta/meta.dart';

part 'fav_exercise_state.dart';

class FavExerciseCubit extends Cubit<FavExerciseState> {
    final GetFavExerciseRepo getFavExerciseRepo;
  FavExerciseCubit(this.getFavExerciseRepo) : super(FavExerciseInitial());



  void emitGetFavExercise() {
    try {
      getFavExerciseRepo.getFavExercise().then((exerciseList) {
        emit(FavExerciseSuccessState(favExerciseList: exerciseList));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }

}
