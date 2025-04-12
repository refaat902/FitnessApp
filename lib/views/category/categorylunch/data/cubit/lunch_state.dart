part of 'lunch_cubit.dart';

@immutable
sealed class LunchState {}

final class LunchInitial extends LunchState {}

class MealByTypeLunchSuccessState extends LunchState {
  final List<MealsResponseModel> mealByTypeList;

  MealByTypeLunchSuccessState({required this.mealByTypeList});

}
