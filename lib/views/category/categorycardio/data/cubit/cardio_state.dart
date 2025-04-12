part of 'cardio_cubit.dart';

@immutable
sealed class CardioState {}

final class CardioInitial extends CardioState {}

class ExeByTypeCardioSuccessState extends CardioState {
  final List<ExeResponseModel> exeByTypeList;

  ExeByTypeCardioSuccessState({required this.exeByTypeList});

}
