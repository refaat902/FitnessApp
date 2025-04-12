import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/fav_meal_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/model/meal_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteMeals extends StatefulWidget {
  const FavoriteMeals({super.key});

  @override
  State<FavoriteMeals> createState() => _FavoriteMealsState();
}

class _FavoriteMealsState extends State<FavoriteMeals> {
  List<MealModel> favMeals = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FavMealCubit>(context).emitGetFavMeal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<FavMealCubit, FavMealState>(
      builder: (context, state) {
        if (state is FavMealSuccessState) {
          favMeals = state.favMealList;
          return ListView.builder(
            itemCount: favMeals.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(favMeals[index].name.toString()),
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    ));
  }
}
