import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/category/categorybreakfast/category_breakfast_page.dart';
import 'package:flutter_application_1/views/category/categorydinner/category_dinner.dart';
import 'package:flutter_application_1/views/category/categorydinner/data/cubit/dinner_cubit.dart';
import 'package:flutter_application_1/views/category/categorylunch/category_lunch_page.dart';
import 'package:flutter_application_1/views/category/categorylunch/data/cubit/lunch_cubit.dart';
import 'package:flutter_application_1/views/category/categorybreakfast/data/cubit/meals_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/data/model/meal_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MealsPlanTextAndSeeAllButton extends StatelessWidget {
  final List<MealItem> meals;

  const MealsPlanTextAndSeeAllButton({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * .03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row with Meal Plans and See All
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Meals",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              // TextButton(
              //   onPressed: () {

              //   },
              //   style: TextButton.styleFrom(
              //     foregroundColor: const Color(0xff289004),
              //     padding: EdgeInsets.zero,
              //   ),
              //   child: Text(
              //     "See all",
              //     style: GoogleFonts.dmSans(
              //       color: const Color(0xff289004),
              //       fontWeight: FontWeight.bold,
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .02),

          // ListView with meal items
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return _MealItemCard(
                  meal: meal,
                  onTap: () {
                    _navigateToMealCategory(context, meal);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToMealCategory(BuildContext context, MealItem meal) {
    if (meal.name == 'Breakfast') {
      Navigator.push(
        context,
        CustomPageRoute(
          page: BlocProvider(
            create: (context) => getIt<MealsCubit>(),
            child: CategoryBreakfastPage(
              name: meal.name,
            ),
          ),
          transitionType: TransitionType.slide,
        ),
      );
    } else if (meal.name == 'Lunch') {
      Navigator.push(
        context,
        CustomPageRoute(
          page: BlocProvider(
            create: (context) => getIt<LunchCubit>(),
            child: CategoryLunchPage(
              name: meal.name,
            ),
          ),
          transitionType: TransitionType.slide,
        ),
      );
    } else {
      Navigator.push(
        context,
        CustomPageRoute(
          page: BlocProvider(
            create: (context) => getIt<DinnerCubit>(),
            child: CategoryDinnerPage(
              name: meal.name,
            ),
          ),
          transitionType: TransitionType.slide,
        ),
      );
    }
  }
}

class _MealItemCard extends StatelessWidget {
  final MealItem meal;
  final VoidCallback onTap;

  const _MealItemCard({
    required this.meal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.75,
              height: MediaQuery.sizeOf(context).height * .25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(meal.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    // ignore: deprecated_member_use
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    meal.name,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
