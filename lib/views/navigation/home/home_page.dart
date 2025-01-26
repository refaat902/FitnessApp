import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/navigation/home/exercisecubit/exercise_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favorites_page.dart';
import 'package:flutter_application_1/views/navigation/home/mealscubit/meals_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/widgets/shimmer_effect.dart';
import 'package:flutter_application_1/views/userprofile/user_profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MealsCubit.get(context).getMeals();
    ExerciseCubit.get(context).getExercises();
    return Scaffold(
      body: CustomScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.sizeOf(context).height * .2,
            floating: false,
            pinned: false,
            centerTitle: false,
            actions: [
              IconButton(
                                        style: const ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.transparent)),
                  onPressed: () {
                    
                    Navigator.push(
                        context,
                        CustomPageRoute(
                            page: const FavoritesPage(),
                            transitionType: TransitionType.slide));
                  },
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.white,
                  ))
            ],
            leading: IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                )),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Color(0xff289004),
                ),
                child: Stack(
                  children: [
                    Image.asset('assets/images/Ellipse4.png'),
                    Image.asset('assets/images/Ellipse3.png'),
                    Positioned(
                        top: MediaQuery.sizeOf(context).height * .03,
                        left: MediaQuery.sizeOf(context).width * .15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                                      style: const ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.transparent)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CustomPageRoute(
                                          page: const UserProfilePage(),
                                          transitionType:
                                              TransitionType.slide));
                                },
                                icon: Image.asset('assets/images/person.png')),
                            Row(
                              children: [
                                Text(
                                  "Hello, Good Morning",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Sophia !",
                                  style: GoogleFonts.dmSans(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        )),
                    Positioned(
                        left: MediaQuery.sizeOf(context).width * .04,
                        right: MediaQuery.sizeOf(context).width * .04,
                        top: MediaQuery.sizeOf(context).height * .15,
                        child: SearchBar(
                          elevation: const WidgetStatePropertyAll(5),
                          leading: const Icon(
                            Icons.search_outlined,
                            color: Color(0xff303841),
                          ),
                          hintText: "Search",
                          hintStyle: WidgetStatePropertyAll(
                            Theme.of(context).textTheme.labelMedium,
                          ),
                          shape: const WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          backgroundColor:
                              const WidgetStatePropertyAll(Colors.white),
                        )),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.sizeOf(context).height * .03),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width * .05),
                    child: Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * .2,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff43AF00),
                              Color(0xff289004),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: MediaQuery.sizeOf(context).height * .03,
                              right: MediaQuery.sizeOf(context).width * .1,
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Fit young woman doing ",
                                        style: GoogleFonts.bebasNeue(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Battle stretch traning",
                                          style: GoogleFonts.bebasNeue(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.normal))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              padding: WidgetStatePropertyAll(
                                                  EdgeInsets.symmetric(
                                                      horizontal:
                                                          MediaQuery.sizeOf(
                                                                      context)
                                                                  .width *
                                                              .02)),
                                              backgroundColor:
                                                  const WidgetStatePropertyAll(
                                                      Color(0xffFABC06))),
                                          onPressed: () {},
                                          child: Text(
                                            "Start Exercise",
                                            style: GoogleFonts.dmSans(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  Image.asset('assets/images/person2.png'),
                  Positioned(
                      top: MediaQuery.sizeOf(context).height * .14,
                      right: MediaQuery.sizeOf(context).width * .2,
                      child: Image.asset('assets/images/dumbbells.png')),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * .2),
              child: const Divider(
                color: Color(0xffF5F5F5),
                // color: Colors.black,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * .03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Meal Plans",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        style: const ButtonStyle(
                            overlayColor:
                                WidgetStatePropertyAll(Color(0xffF5F5F5))),
                        onPressed: () {},
                        child: Text(
                          "See all",
                          style: GoogleFonts.dmSans(
                              color: const Color(0xff289004),
                              // fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                BlocBuilder<MealsCubit, MealsState>(
                  builder: (context, state) {
                    if (state is MealsSuccessState) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * .3,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: MealsCubit.meals.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                if (index == 0)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: MediaQuery.sizeOf(context).width *
                                            .03),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              .2,
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  .9,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(MealsCubit
                                                  .meals[index].images![0]),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(30)),
                                          ),
                                        ),
                                        Text(
                                          MealsCubit.meals[index].title!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        Text(
                                            "${MealsCubit.meals[index].price!}")
                                      ],
                                    ),
                                  ),
                                if (index != 0)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .2,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                .9,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(MealsCubit
                                                .meals[index].images![0]),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                      ),
                                      Text(
                                        MealsCubit.meals[index].title!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      Text("${MealsCubit.meals[index].price!}")
                                    ],
                                  ),
                                if (index != MealsCubit.meals.length - 1)
                                  SizedBox(
                                    height:
                                        MediaQuery.sizeOf(context).height * .2,
                                    child: const VerticalDivider(
                                      color: Color(0xffF5F5F5),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      );
                    } else if (state is MealsWaitingState) {
                      return buildShimmerPlaceholderForHomePage(context);
                    } else {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * .2),
              child: const Divider(
                color: Color(0xffF5F5F5),
                // color: Colors.black,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * .03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Exercise Plans",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                          style: const ButtonStyle(
                              overlayColor:
                                  WidgetStatePropertyAll(Color(0xffF5F5F5))),
                          onPressed: () {},
                          child: Text(
                            "See all",
                            style: GoogleFonts.dmSans(
                                color: const Color(0xff289004),
                                // fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
                BlocBuilder<ExerciseCubit, ExerciseState>(
                  builder: (context, state) {
                    if (state is ExerciseSuccessState) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * .3,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ExerciseCubit.exercise.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                if (index == 0)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: MediaQuery.sizeOf(context).width *
                                            .03),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              .2,
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  .9,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(ExerciseCubit
                                                  .exercise[index].images![0]),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(30)),
                                          ),
                                        ),
                                        Text(
                                          ExerciseCubit.exercise[index].title!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        Text(
                                            "${ExerciseCubit.exercise[index].price!}")
                                      ],
                                    ),
                                  ),
                                if (index != 0)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                .2,
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                .9,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(ExerciseCubit
                                                .exercise[index].images![0]),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                      ),
                                      Text(
                                        ExerciseCubit.exercise[index].title!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      Text(
                                          "${ExerciseCubit.exercise[index].price!}")
                                    ],
                                  ),
                                if (index != ExerciseCubit.exercise.length - 1)
                                  SizedBox(
                                    height:
                                        MediaQuery.sizeOf(context).height * .2,
                                    child: const VerticalDivider(
                                      color: Color(0xffF5F5F5),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      );
                    } else if (state is ExerciseWaitingState) {
                      return buildShimmerPlaceholderForHomePage(context);
                    } else {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
