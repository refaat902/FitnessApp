import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/startexe/data/repository/get_exe_by_muscle_group_repo.dart';
import 'package:meta/meta.dart';

part 'back_state.dart';

class BackCubit extends Cubit<BackState> {
  final GetExeByMuscleGroupRepo getExeByMuscleGroupRepo;
  BackCubit(this.getExeByMuscleGroupRepo) : super(BackInitial());

  void emitExeByMuscleGroupBack(String muscleGroup) {
    try {
      getExeByMuscleGroupRepo
          .getExeByMuscleGroup(muscleGroup)
          .then((muscleGroup) {
        emit(GetExeByMuscleGroupBackSuccessState(
            exeByMuscleGroupBackList: muscleGroup));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
