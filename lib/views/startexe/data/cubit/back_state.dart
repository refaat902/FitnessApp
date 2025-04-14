part of 'back_cubit.dart';

@immutable
sealed class BackState {}

final class BackInitial extends BackState {}


class GetExeByMuscleGroupBackSuccessState extends BackState {
  final List<ExeResponseModel> exeByMuscleGroupBackList;

  GetExeByMuscleGroupBackSuccessState({required this.exeByMuscleGroupBackList});

}
