part of 'fav_exercise_cubit.dart';

@immutable
sealed class FavExerciseState {}

final class FavExerciseInitial extends FavExerciseState {}
class FavExerciseSuccessState extends FavExerciseState {
  final List<ExeResponseModel> favExerciseList;

  FavExerciseSuccessState({required this.favExerciseList});

}
