import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/category/categorybreakfast/category_breakfast_page.dart';
import 'package:flutter_application_1/views/category/categorydinner/category_dinner.dart';
import 'package:flutter_application_1/views/category/categorydinner/data/cubit/dinner_cubit.dart';
// import 'package:flutter_application_1/views/category/categorydinner/category_dinner.dart';
// import 'package:flutter_application_1/views/category/categorydinner/data/cubit/dinner_cubit.dart';
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
          horizontal: MediaQuery.sizeOf(context).width * .03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row with Meal Plans and See All
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Meals", style: Theme.of(context).textTheme.titleLarge),
              TextButton(
                onPressed: () {
                  // Navigate to full list
                },
                style: const ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(Color(0xffF5F5F5)),
                ),
                child: Text(
                  "See all",
                  style: GoogleFonts.dmSans(
                    color: const Color(0xff289004),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // ListView with meal items
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return GestureDetector(
                  onTap: () {
                    if (meals[index].name == 'Breakfast') {
                      Navigator.push(
                          context,
                          CustomPageRoute(
                              page: BlocProvider(
                                create: (context) => getIt<MealsCubit>(),
                                child: CategoryBreakfastPage(
                                  name: meals[index].name,
                                ),
                              ),
                              transitionType: TransitionType.slide));
                    } else if (meals[index].name == 'Lunch') {
                      Navigator.push(
                          context,
                          CustomPageRoute(
                              page: BlocProvider(
                                create: (context) => getIt<LunchCubit>(),
                                child: CategoryLunchPage(
                                  name: meals[index].name,
                                ),
                              ),
                              transitionType: TransitionType.slide));
                    } else {
                      Navigator.push(
                          context,
                          CustomPageRoute(
                              page: BlocProvider(
                                create: (context) => getIt<DinnerCubit>(),
                                child: CategoryDinnerPage(
                                  name: meals[index].name,
                                ),
                              ),
                              transitionType: TransitionType.slide));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height * .25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(meal.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          meal.name,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
