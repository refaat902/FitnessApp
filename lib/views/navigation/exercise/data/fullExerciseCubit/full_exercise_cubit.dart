import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/navigation/exercise/data/models/exercise_model.dart';
import 'package:flutter_application_1/views/navigation/exercise/data/repository/get_all_categories_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'full_exercise_state.dart';

class FullExerciseCubit extends Cubit<FullExerciseState> {
  final GetAllCategoriesRepo getAllCategoriesRepo;
  FullExerciseCubit(this.getAllCategoriesRepo) : super(FullExerciseInitial());
  void emitGetAllExercise() {
    try {
      getAllCategoriesRepo.getAllExercise().then((exerciseList) {
        emit(FullExerciseSuccessState(allExerciseList: exerciseList));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
