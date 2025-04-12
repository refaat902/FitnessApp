part of 'full_exercise_cubit.dart';

@immutable
sealed class FullExerciseState {}

final class FullExerciseInitial extends FullExerciseState {}

class FullExerciseSuccessState extends FullExerciseState {
  final List<ExerciseModel> allExerciseList;

  FullExerciseSuccessState({required this.allExerciseList});

}

// class FullExerciseErrorState extends FullExerciseState {}

// class FullExerciseWaitingState extends FullExerciseState {}
