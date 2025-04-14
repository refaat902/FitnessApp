import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/startexe/data/repository/get_exe_by_muscle_group_repo.dart';
import 'package:meta/meta.dart';

part 'legs_state.dart';

class LegsCubit extends Cubit<LegsState> {
  final GetExeByMuscleGroupRepo getExeByMuscleGroupRepo;
  LegsCubit(this.getExeByMuscleGroupRepo) : super(LegsInitial());

  void emitExeByMuscleGroupLegs(String muscleGroup) {
    try {
      getExeByMuscleGroupRepo
          .getExeByMuscleGroup(muscleGroup)
          .then((muscleGroup) {
        emit(GetExeByMuscleGroupLegsSuccessState(
            exeByMuscleGroupLegsList: muscleGroup));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
