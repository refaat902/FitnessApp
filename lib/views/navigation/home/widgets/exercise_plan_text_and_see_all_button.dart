import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/category/categorystrength/category_strength_page.dart';
import 'package:flutter_application_1/views/category/categorystrength/data/cubit/strength_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/data/model/exercise_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ExercisePlanTextAndSeeAllButton extends StatelessWidget {
  final List<ExerciseItem> exercises;

  const ExercisePlanTextAndSeeAllButton({super.key, required this.exercises});

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
              Text("Exercises", style: Theme.of(context).textTheme.titleLarge),
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
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final meal = exercises[index];
                return GestureDetector(
                  onTap: () {
                    if (exercises[index].name == 'Strength') {
                      Navigator.push(
                          context,
                          CustomPageRoute(
                              page: BlocProvider(
                                create: (context) => getIt<StrengthCubit>(),
                                child: CategoryStrengthPage(
                                  name: exercises[index].name,
                                ),
                              ),
                              transitionType: TransitionType.slide));
                    } 
                    // else if (exercises[index].name == 'Lunch') {
                    //   Navigator.push(
                    //       context,
                    //       CustomPageRoute(
                    //           page: BlocProvider(
                    //             create: (context) => getIt<LunchCubit>(),
                    //             child: CategoryLunchPage(
                    //               name: exercises[index].name,
                    //             ),
                    //           ),
                    //           transitionType: TransitionType.slide));
                    // } 
                    else {
                      // Navigator.push(
                      //     context,
                      //     CustomPageRoute(
                      //         page: BlocProvider(
                      //           create: (context) => getIt<DinnerCubit>(),
                      //           child: CategoryDinnerPage(
                      //             name: exercises[index].name,
                      //           ),
                      //         ),
                      //         transitionType: TransitionType.slide));
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
