part of 'add_to_fav_meal_cubit.dart';

@immutable
sealed class AddToFavMealState {}

final class AddToFavMealInitial extends AddToFavMealState {}

class AddToFavMealSuccessState extends AddToFavMealState {}
class DeleteFavMealSuccessState extends AddToFavMealState {}