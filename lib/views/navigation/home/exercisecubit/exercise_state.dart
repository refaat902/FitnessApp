part of 'exercise_cubit.dart';

@immutable
sealed class ExerciseState {}

final class ExerciseInitial extends ExerciseState {}
class ExerciseErrorState extends ExerciseState{}
class ExerciseWaitingState extends ExerciseState{}
class ExerciseSuccessState extends ExerciseState{}
