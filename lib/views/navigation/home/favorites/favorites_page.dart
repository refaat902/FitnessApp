import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/favorite_meals.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/favorite_workout_page.dart';

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
                  icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                floating: true,
                bottom:  TabBar(
                                    indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * .05),
                  labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                  indicator: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                  dividerHeight: 0,
                  overlayColor: WidgetStateColor.transparent,
                  tabs:  const [
                    Tab(text: "Meals"),
                    Tab(text: "Workouts"),
                  ],
                ),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              FavoriteMeals(),
              FavoriteWorkoutPage(),
            ],
          ),
        ),
      ),
    );
  }
}
