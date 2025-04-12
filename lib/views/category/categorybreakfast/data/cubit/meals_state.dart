part of 'meals_cubit.dart';

@immutable
sealed class MealsState {}

final class MealsInitial extends MealsState {}
class MealByTypeBreakFastState extends MealsState {
  final List<MealsResponseModel> mealByTypeList;

  MealByTypeBreakFastState({required this.mealByTypeList});

}
