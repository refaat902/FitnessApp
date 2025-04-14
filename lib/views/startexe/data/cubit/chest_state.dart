part of 'chest_cubit.dart';

@immutable
sealed class ChestState {}

final class ChestInitial extends ChestState {}
class GetExeByMuscleGroupChestSuccessState extends ChestState {
  final List<ExeResponseModel> exeByMuscleGroupChestList;

  GetExeByMuscleGroupChestSuccessState({required this.exeByMuscleGroupChestList});

}