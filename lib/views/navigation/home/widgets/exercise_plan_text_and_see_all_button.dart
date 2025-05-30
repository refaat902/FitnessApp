// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/category/categorybodyweight/category_body_weight_page.dart';
import 'package:flutter_application_1/views/category/categorybodyweight/data/cubit/bodyweight_cubit.dart';
import 'package:flutter_application_1/views/category/categorycardio/category_cardio_page.dart';
import 'package:flutter_application_1/views/category/categorycardio/data/cubit/cardio_cubit.dart';
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
        horizontal: MediaQuery.sizeOf(context).width * .03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row with Exercise Plans and See All
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Exercises",
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

          // ListView with exercise items
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return _ExerciseItemCard(
                  exercise: exercise,
                  onTap: () {
                    _navigateToExerciseCategory(context, exercise);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToExerciseCategory(BuildContext context, ExerciseItem exercise) {
    if (exercise.name == 'Strength') {
      Navigator.push(
        context,
        CustomPageRoute(
          page: BlocProvider(
            create: (context) => getIt<StrengthCubit>(),
            child: CategoryStrengthPage(
              name: exercise.name,
            ),
          ),
          transitionType: TransitionType.slide,
        ),
      );
    } else if (exercise.name == 'Cardio') {
      Navigator.push(
        context,
        CustomPageRoute(
          page: BlocProvider(
            create: (context) => getIt<CardioCubit>(),
            child: CategoryCardioPage(
              name: exercise.name,
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
            create: (context) => getIt<BodyweightCubit>(),
            child: CategoryBodyWeightPage(
              name: exercise.name,
            ),
          ),
          transitionType: TransitionType.slide,
        ),
      );
    }
  }
}

class _ExerciseItemCard extends StatelessWidget {
  final ExerciseItem exercise;
  final VoidCallback onTap;

  const _ExerciseItemCard({
    required this.exercise,
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
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(exercise.imageUrl),
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

                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    exercise.name,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
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