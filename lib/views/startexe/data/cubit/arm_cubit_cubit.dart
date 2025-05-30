import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/startexe/data/repository/get_exe_by_muscle_group_repo.dart';
import 'package:meta/meta.dart';

part 'arm_cubit_state.dart';

class ArmCubitCubit extends Cubit<ArmCubitState> {
    final GetExeByMuscleGroupRepo getExeByMuscleGroupRepo;
  ArmCubitCubit(this.getExeByMuscleGroupRepo) : super(ArmCubitInitial());





  void emitExeByMuscleGroupLegs(String muscleGroup) {
    try {
      getExeByMuscleGroupRepo
          .getExeByMuscleGroup(muscleGroup)
          .then((muscleGroup) {
        emit(GetExeByMuscleGroupArmSuccessState(
            exeByMuscleGroupArmsList: muscleGroup));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}

