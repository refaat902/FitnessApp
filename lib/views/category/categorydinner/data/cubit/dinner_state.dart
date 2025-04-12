part of 'dinner_cubit.dart';

@immutable
sealed class DinnerState {}

final class DinnerInitial extends DinnerState {}

class MealByTypeDinnerSuccessState extends DinnerState {
  final List<MealsResponseModel> mealByTypeList;

  MealByTypeDinnerSuccessState({required this.mealByTypeList});

}
