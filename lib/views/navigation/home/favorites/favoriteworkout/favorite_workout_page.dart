import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/navigation/exercise/data/models/exercise_model.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/fav_exercise_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteWorkoutPage extends StatefulWidget {
  const FavoriteWorkoutPage({super.key});

  @override
  State<FavoriteWorkoutPage> createState() => _FavoriteWorkoutPageState();
}

class _FavoriteWorkoutPageState extends State<FavoriteWorkoutPage> {
  List<ExerciseModel> favExercise = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FavExerciseCubit>(context).emitGetFavExercise();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocBuilder<FavExerciseCubit, FavExerciseState>(
        builder: (context, state) {
          if (state is FavExerciseSuccessState) {
            favExercise = state.favExerciseList;
            return ListView.builder(
              itemCount: favExercise.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favExercise[index].name.toString()),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
