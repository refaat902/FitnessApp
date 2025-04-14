part of 'legs_cubit.dart';

@immutable
sealed class LegsState {}

final class LegsInitial extends LegsState {}

class GetExeByMuscleGroupLegsSuccessState extends LegsState {
  final List<ExeResponseModel> exeByMuscleGroupLegsList;

  GetExeByMuscleGroupLegsSuccessState({required this.exeByMuscleGroupLegsList});

}
