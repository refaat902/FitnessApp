part of 'meals_cubit.dart';

@immutable
sealed class MealsState {}

final class MealsInitial extends MealsState {}
class MealsErrorState extends MealsState{}
class MealsWaitingState extends MealsState{}
class MealsSuccessState extends MealsState{}
