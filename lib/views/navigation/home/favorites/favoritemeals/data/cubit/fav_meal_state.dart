part of 'fav_meal_cubit.dart';


sealed class FavMealState {}

final class FavMealInitial extends FavMealState {}
class FavMealSuccessState extends FavMealState {
  final List<MealsResponseModel> favMealList;

  FavMealSuccessState({required this.favMealList});

}