import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/startexe/data/repository/get_exe_by_muscle_group_repo.dart';
import 'package:meta/meta.dart';

part 'chest_state.dart';

class ChestCubit extends Cubit<ChestState> {
  final GetExeByMuscleGroupRepo getExeByMuscleGroupRepo;
  ChestCubit(this.getExeByMuscleGroupRepo) : super(ChestInitial());
  void emitExeByMuscleGroupChest(String muscleGroup) {
    try {
      getExeByMuscleGroupRepo
          .getExeByMuscleGroup(muscleGroup)
          .then((muscleGroup) {
        emit(GetExeByMuscleGroupChestSuccessState(
            exeByMuscleGroupChestList: muscleGroup));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
