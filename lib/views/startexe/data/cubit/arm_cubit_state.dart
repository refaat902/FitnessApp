part of 'arm_cubit_cubit.dart';

@immutable
sealed class ArmCubitState {}

final class ArmCubitInitial extends ArmCubitState {}
class GetExeByMuscleGroupArmSuccessState extends ArmCubitState {
  final List<ExeResponseModel> exeByMuscleGroupArmsList;

  GetExeByMuscleGroupArmSuccessState({required this.exeByMuscleGroupArmsList});

}