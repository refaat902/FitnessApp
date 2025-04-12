import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/navigation/home/data/model/exercise_model.dart';
import 'package:flutter_application_1/views/navigation/home/data/model/meal_model.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favorites_page.dart';
import 'package:flutter_application_1/views/navigation/home/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/views/navigation/home/widgets/drawer.dart';
import 'package:flutter_application_1/views/navigation/home/widgets/exercise_plan_text_and_see_all_button.dart';
import 'package:flutter_application_1/views/navigation/home/widgets/green_card.dart';
import 'package:flutter_application_1/views/navigation/home/widgets/meals_paln_text_and_see_all_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List<MealItem> mealList = [
    MealItem(name: "Breakfast", imageUrl: "assets/images/breakfastCat.jpg"),
    MealItem(name: "Lunch", imageUrl: "assets/images/lunchCat.jpg"),
    MealItem(name: "Dinner", imageUrl: "assets/images/dinnerCat.jpg"),
  ];
    final List<ExerciseItem> exercisList = [
    ExerciseItem(name: "Strength", imageUrl: "assets/images/exeCat1.jpg"),
    ExerciseItem(name: "Cardio", imageUrl: "assets/images/exeCat2.jpg"),
    ExerciseItem(name: "Body Weight", imageUrl: "assets/images/exeCat3.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.sizeOf(context).height * .2,
            floating: false,
            pinned: false,
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CustomPageRoute(
                      page: const FavoritesPage(),
                      transitionType: TransitionType.slide,
                    ),
                  );
                },
                icon: const Icon(Icons.favorite_border_outlined,
                    color: Colors.white),
              ),
            ],
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Color(0xff289004),
                ),
                child: const CustomAppBar(),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: GreenCard(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * .2),
              child: const Divider(color: Color(0xffF5F5F5)),
            ),
          ),
          SliverToBoxAdapter(
            child: MealsPlanTextAndSeeAllButton(
              meals: mealList,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * .2),
              child: const Divider(color: Color(0xffF5F5F5)),
            ),
          ),
           SliverToBoxAdapter(
            child: ExercisePlanTextAndSeeAllButton(exercises: exercisList,),
          ),
        ],
      ),
    );
  }
}
