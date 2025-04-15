import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/aimeal/data/cubit/ai_meal_cubit.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
import 'package:flutter_application_1/views/navigation/navigation_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecomendationsPage extends StatefulWidget {
  const RecomendationsPage({super.key});

  @override
  State<RecomendationsPage> createState() => _RecomendationsPageState();
}

class _RecomendationsPageState extends State<RecomendationsPage> {
  late List breakfastMeals;
  late List dinnerMeals;
  late List lunchMeals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Text('Ai Meals'),
      ),
      body: BlocBuilder<AiMealCubit, AiMealState>(
        builder: (context, state) {
          if (state is GetAiMealsSuccessState) {
            breakfastMeals =
                state.responseData.recommendations!['breakfast_options'];
            lunchMeals = state.responseData.recommendations!['lunch_options'];
            dinnerMeals = state.responseData.recommendations!['dinner_options'];

            // Combine all three lists
            List allMeals = [
              {'mealType': 'Breakfast', 'meals': breakfastMeals},
              {'mealType': 'Lunch', 'meals': lunchMeals},
              {'mealType': 'Dinner', 'meals': dinnerMeals}
            ];

            return SingleChildScrollView(
              // Wrap the whole body in SingleChildScrollView
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.sizeOf(context).height * .02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allMeals.length,
                      itemBuilder: (context, index) {
                        var mealCategory = allMeals[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width * .02),
                              child: Text(
                                mealCategory['mealType'],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: mealCategory['meals'].length,
                              itemBuilder: (context, mealIndex) {
                                return Card(
                                  color: const Color(0xffFCFCFC),
                                  elevation: 0,
                                  child: ListTile(
                                    title: Text(
                                      mealCategory['meals'][mealIndex]
                                              ['meal'] ??
                                          '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(fontSize: 18),
                                    ),
                                    subtitle: Padding(
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.sizeOf(context).height *
                                            .01,
                                        left: MediaQuery.sizeOf(context).width *
                                            .02,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/meat.png',
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        .05,
                                              ),
                                              SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          .01),
                                              Text(
                                                mealCategory['meals'][mealIndex]
                                                        ['nutrition']['protein']
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          .02),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        .002,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        .03,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          .02),
                                              Image.asset(
                                                'assets/images/carb.png',
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        .05,
                                              ),
                                              SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          .01),
                                              Text(
                                                mealCategory['meals'][mealIndex]
                                                        ['nutrition']['carbs']
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          .02),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        .002,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        .03,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          .02),
                                              Image.asset(
                                                'assets/images/lipid.png',
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        .05,
                                              ),
                                              SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          .01),
                                              Text(
                                                mealCategory['meals'][mealIndex]
                                                        ['nutrition']['fats']
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  .02),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  MediaQuery.sizeOf(context)
                                                          .width *
                                                      .05,
                                            ),
                                            child: const Divider(
                                                color: Color(0xff7FB041)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    // Done Button at the bottom
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width * .02),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationPage()),
                                );
                              },
                              child: const Text('Done'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const ShimmerListTile();
          }
        },
      ),
    );
  }
}
