import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/fav_exercise_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteWorkoutPage extends StatefulWidget {
  const FavoriteWorkoutPage({super.key});

  @override
  State<FavoriteWorkoutPage> createState() => _FavoriteWorkoutPageState();
}

class _FavoriteWorkoutPageState extends State<FavoriteWorkoutPage> {
  List<ExeResponseModel> favExe = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavExerciseCubit>(context).emitGetFavExercise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavExerciseCubit, FavExerciseState>(
      builder: (context, state) {
        if (state is FavExerciseSuccessState) {
          favExe = state.favExerciseList;
          return ListView.builder(
            itemCount: favExe.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.black,
                child: ListTile(
                  title: Text(
                    favExe[index].name.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 18,color: Colors.white),
                  ),
                  subtitle: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*.02,vertical: MediaQuery.sizeOf(context).height*.02),
                    child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.2), // Optional: Adds subtle shadow
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // Changes position of shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              state.favExerciseList[index].imageUrl.toString(),
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  ),
                ),
              );
            },
          );
        } else {
          return const ShimmerListTile();
        }
      },
    )
    );
  }
}
