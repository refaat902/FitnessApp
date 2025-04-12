import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/category/categorybreakfast/data/cubit/meals_cubit.dart';
import 'package:flutter_application_1/views/category/categorylunch/data/cubit/lunch_cubit.dart';
import 'package:flutter_application_1/views/category/data/model/meals_response_model.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/add_to_fav_meal_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/fav_meal_cubit.dart';
import 'package:flutter_application_1/views/navigation/meals/meals_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class BlocListLunch extends StatefulWidget {
  final bool showArrowBack;
  final int? tabIndex;
  const BlocListLunch({super.key, required this.showArrowBack, this.tabIndex});

  @override
  State<BlocListLunch> createState() => _BlocListLunchState();
}

class _BlocListLunchState extends State<BlocListLunch>
    with TickerProviderStateMixin {
  final Map<int, bool> favMealMap = {};
  final Map<int, AnimationController> _controllers = {};

  List<MealsResponseModel> mealsList = [];

  @override
  void initState() {
    super.initState();
    // Fetch favorites initially
    BlocProvider.of<FavMealCubit>(context).emitGetFavMeal();
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LunchCubit, LunchState>(
      builder: (context, mealState) {
        if (mealState is MealByTypeLunchSuccessState) {
          mealsList = mealState.mealByTypeList;

          return BlocBuilder<FavMealCubit, FavMealState>(
            builder: (context, favState) {
              Set<String> favoriteIds = {};
              if (favState is FavMealSuccessState) {
                favoriteIds = favState.favMealList
                    .map((meal) => meal.id.toString())
                    .toSet();
              }

              return ListView.builder(
                itemCount: mealsList.length,
                itemBuilder: (context, index) {
                  final meal = mealsList[index];
                  final mealsId = meal.id.toString();

                  // Determine initial favorite status
                  bool isFavorite = favoriteIds.contains(mealsId);
                  favMealMap[index] = isFavorite;

                  _controllers[index] ??= AnimationController(
                    vsync: this,
                    duration: const Duration(milliseconds: 1),
                  );

                  // Set animation controller value if already favorite
                  if (isFavorite && _controllers[index]!.isDismissed) {
                    _controllers[index]!.value = 1.0;
                  }

                  return Card(
                    color: const Color(0xffFCFCFC),
                    elevation: 0,
                    child: ListTile(
                      onTap: widget.showArrowBack
                          ? () {
                              Navigator.push(
                                context,
                                CustomPageRoute(
                                  page: MealsPage(
                                    showArrowBack: widget.showArrowBack,
                                    index: index,
                                    tabIndex: widget.tabIndex,
                                  ),
                                  transitionType: TransitionType.slide,
                                ),
                              );
                            }
                          : null,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              meal.name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontSize: 18),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (favMealMap[index] == false) {
                                setState(() {
                                  favMealMap[index] = true;
                                });
                                BlocProvider.of<AddToFavMealCubit>(context)
                                    .emitAddToFavMeal(mealsId);
                                _controllers[index]!.forward();
                              } else {
                                BlocProvider.of<AddToFavMealCubit>(context)
                                    .emitDeleteFavMeal(mealsId);
                                _controllers[index]!.reverse();
                              }
                            },
                            child: Lottie.asset(
                              'assets/animations/fav.json',
                              controller: _controllers[index],
                              onLoaded: (composition) {
                                _controllers[index]!.duration =
                                    composition.duration;
                                if (favMealMap[index] == true) {
                                  _controllers[index]!.value = 1.0;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).height * .01,
                          left: MediaQuery.sizeOf(context).width * .02,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/meat.png',
                                  width: MediaQuery.sizeOf(context).width * .05,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .01,
                                ),
                                Text(
                                  meal.protein.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .02,
                                ),
                                Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * .002,
                                  height:
                                      MediaQuery.sizeOf(context).height * .03,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .02,
                                ),
                                Image.asset(
                                  'assets/images/carb.png',
                                  width: MediaQuery.sizeOf(context).width * .05,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .01,
                                ),
                                Text(
                                  meal.carbs.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .02,
                                ),
                                Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * .002,
                                  height:
                                      MediaQuery.sizeOf(context).height * .03,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .02,
                                ),
                                Image.asset(
                                  'assets/images/lipid.png',
                                  width: MediaQuery.sizeOf(context).width * .05,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .01,
                                ),
                                Text(
                                  meal.fat.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * .02,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.sizeOf(context).width * .05,
                              ),
                              child: const Divider(color: Color(0xff7FB041)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const ShimmerListTile();
        }
      },
    );
  }
}
