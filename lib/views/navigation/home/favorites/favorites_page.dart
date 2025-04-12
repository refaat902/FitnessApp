import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/fav_meal_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/favorite_meals.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/fav_exercise_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/favorite_workout_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text("My Favorites"),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                floating: true,
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * .05),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                  indicator: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  dividerHeight: 0,
                  overlayColor: WidgetStateColor.transparent,
                  tabs: const [
                    Tab(text: "Meals"),
                    Tab(text: "Workouts"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              BlocProvider(
                create: (context) => getIt<FavMealCubit>(),
                child: const FavoriteMeals(),
              ),
              BlocProvider(
                create: (context) => getIt<FavExerciseCubit>(),
                child: const FavoriteWorkoutPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
