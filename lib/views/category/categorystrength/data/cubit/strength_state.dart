part of 'strength_cubit.dart';

@immutable
sealed class StrengthState {}

final class StrengthInitial extends StrengthState {}
class ExeByTypeStrengthSuccessState extends StrengthState {
  final List<ExeResponseModel> exeByTypeList;

  ExeByTypeStrengthSuccessState({required this.exeByTypeList});

}