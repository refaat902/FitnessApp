part of 'bodyweight_cubit.dart';

@immutable
sealed class BodyweightState {}

final class BodyweightInitial extends BodyweightState {}

class ExeByTypeBodyWeightSuccessState extends BodyweightState {
  final List<ExeResponseModel> exeByTypeList;

  ExeByTypeBodyWeightSuccessState({required this.exeByTypeList});

}
