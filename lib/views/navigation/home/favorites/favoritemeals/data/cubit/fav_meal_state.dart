part of 'fav_meal_cubit.dart';

@immutable
sealed class FavMealState {}

final class FavMealInitial extends FavMealState {}
class FavMealSuccessState extends FavMealState {
  final List<MealModel> favMealList;

  FavMealSuccessState({required this.favMealList});

}