part of 'ai_meal_cubit.dart';

@immutable
sealed class AiMealState {}

final class AiMealInitial extends AiMealState {}

class GetAiMealsSuccessState extends AiMealState {
  final AiMealResponsetModel responseData;

  GetAiMealsSuccessState({required this.responseData});

}
