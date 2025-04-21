// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/views/aimeal/data/cubit/ai_meal_cubit.dart';
// import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
// import 'package:flutter_application_1/views/navigation/navigation_page.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class RecomendationsPage extends StatefulWidget {
//   const RecomendationsPage({super.key});

//   @override
//   State<RecomendationsPage> createState() => _RecomendationsPageState();
// }

// class _RecomendationsPageState extends State<RecomendationsPage> {
//   late List breakfastMeals;
//   late List dinnerMeals;
//   late List lunchMeals;

//   @override
//   Widget build(BuildContext context) {
//     // Get screen dimensions for responsive design
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     // Define theme colors
//     const primaryColor = Color(0xff289004);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//         title: const Text(
//           'AI Meals',
//         ),
//       ),
//       body: BlocBuilder<AiMealCubit, AiMealState>(
//         builder: (context, state) {
//           if (state is GetAiMealsSuccessState) {
//             breakfastMeals =
//                 state.responseData.recommendations!['breakfast_options'];
//             lunchMeals = state.responseData.recommendations!['lunch_options'];
//             dinnerMeals = state.responseData.recommendations!['dinner_options'];

//             // Combine all three lists
//             List allMeals = [
//               {'mealType': 'Breakfast', 'meals': breakfastMeals},
//               {'mealType': 'Lunch', 'meals': lunchMeals},
//               {'mealType': 'Dinner', 'meals': dinnerMeals}
//             ];

//             return SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(
//                   screenWidth * 0.04,
//                   screenHeight * 0.02,
//                   screenWidth * 0.04,
//                   screenHeight * 0.04,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: allMeals.length,
//                       itemBuilder: (context, index) {
//                         var mealCategory = allMeals[index];
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Meal type header
//                             Container(
//                               margin: EdgeInsets.only(
//                                 top: index == 0 ? 0 : screenHeight * 0.025,
//                                 bottom: screenHeight * 0.015,
//                                 left: screenWidth * 0.02,
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     width: 4,
//                                     height: screenHeight * 0.03,
//                                     decoration: BoxDecoration(
//                                       color: primaryColor,
//                                       borderRadius: BorderRadius.circular(2),
//                                     ),
//                                   ),
//                                   SizedBox(width: screenWidth * 0.02),
//                                   Text(
//                                     mealCategory['mealType'],
//                                     style:
//                                         Theme.of(context).textTheme.labelLarge,
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // Meal items
//                             ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: mealCategory['meals'].length,
//                               itemBuilder: (context, mealIndex) {
//                                 var meal = mealCategory['meals'][mealIndex];
//                                 return Container(
//                                   margin: EdgeInsets.only(
//                                       bottom: screenHeight * 0.015),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(0.05),
//                                         blurRadius: 8,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(screenWidth * 0.04),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         // Meal name
//                                         Text(
//                                           meal['meal'] ?? '',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .labelLarge,
//                                         ),
//                                         SizedBox(height: screenHeight * 0.015),

//                                         // Nutrition info
//                                         Container(
//                                           padding: EdgeInsets.symmetric(
//                                             vertical: screenHeight * 0.01,
//                                             horizontal: screenWidth * 0.02,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: Colors.grey.shade50,
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               // Protein
//                                               Expanded(
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Image.asset(
//                                                       'assets/images/meat.png',
//                                                       width: screenWidth * 0.05,
//                                                     ),
//                                                     SizedBox(
//                                                         width:
//                                                             screenWidth * 0.01),
//                                                     Text(
//                                                       meal['nutrition']
//                                                               ['protein']
//                                                           .toString(),
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .labelMedium,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),

//                                               Container(
//                                                 width: 1,
//                                                 height: screenHeight * 0.03,
//                                                 color: Colors.grey.shade300,
//                                               ),

//                                               // Carbs
//                                               Expanded(
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Image.asset(
//                                                       'assets/images/carb.png',
//                                                       width: screenWidth * 0.05,
//                                                     ),
//                                                     SizedBox(
//                                                         width:
//                                                             screenWidth * 0.01),
//                                                     Text(
//                                                       meal['nutrition']['carbs']
//                                                           .toString(),
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .labelMedium,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),

//                                               Container(
//                                                 width: 1,
//                                                 height: screenHeight * 0.03,
//                                                 color: Colors.grey.shade300,
//                                               ),

//                                               // Fats
//                                               Expanded(
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Image.asset(
//                                                       'assets/images/lipid.png',
//                                                       width: screenWidth * 0.05,
//                                                     ),
//                                                     SizedBox(
//                                                         width:
//                                                             screenWidth * 0.01),
//                                                     Text(
//                                                       meal['nutrition']['fats']
//                                                           .toString(),
//                                                       // style: GoogleFonts
//                                                       //     .montserrat(
//                                                       //   fontSize:
//                                                       //       screenWidth * 0.035,
//                                                       //   fontWeight:
//                                                       //       FontWeight.bold,
//                                                       //   color: Colors.black87,
//                                                       // ),
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .labelMedium,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     ),

//                     // Done Button
//                     Padding(
//                       padding: EdgeInsets.only(
//                         top: screenHeight * 0.02,
//                         bottom: screenHeight * 0.01,
//                       ),
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: screenHeight * 0.06,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const NavigationPage(),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: primaryColor,
//                             foregroundColor: Colors.white,
//                             elevation: 2,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: const Text(
//                             'Done',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return const ShimmerListTile();
//           }
//         },
//       ),
//     );
//   }
// }




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
  
  // Define meal-specific colors
  final Map<String, Color> mealColors = {
    'Breakfast': const Color(0xFFF9A826), // Orange for breakfast
    'Lunch': const Color(0xFF289004),     // Green for lunch
    'Dinner': const Color(0xFF3F51B5),    // Indigo for dinner
  };

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'AI Meals',
        ),
      ),
      body: BlocBuilder<AiMealCubit, AiMealState>(
        builder: (context, state) {
          if (state is GetAiMealsSuccessState) {
            breakfastMeals = state.responseData.recommendations!['breakfast_options'];
            lunchMeals = state.responseData.recommendations!['lunch_options'];
            dinnerMeals = state.responseData.recommendations!['dinner_options'];

            // Combine all three lists
            List allMeals = [
              {'mealType': 'Breakfast', 'meals': breakfastMeals},
              {'mealType': 'Lunch', 'meals': lunchMeals},
              {'mealType': 'Dinner', 'meals': dinnerMeals}
            ];

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.04,
                  screenHeight * 0.02,
                  screenWidth * 0.04,
                  screenHeight * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allMeals.length,
                      itemBuilder: (context, index) {
                        var mealCategory = allMeals[index];
                        // Get the color for this meal type
                        final mealColor = mealColors[mealCategory['mealType']] ?? const Color(0xFF289004);
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Meal type header with colored indicator
                            Container(
                              margin: EdgeInsets.only(
                                top: index == 0 ? 0 : screenHeight * 0.025,
                                bottom: screenHeight * 0.015,
                                left: screenWidth * 0.02,
                              ),
                              child: Row(
                                children: [
                                  // Colored indicator - different for each meal type
                                  Container(
                                    width: 4,
                                    height: screenHeight * 0.03,
                                    decoration: BoxDecoration(
                                      color: mealColor,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  Text(
                                    mealCategory['mealType'],
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: mealColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Meal items
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: mealCategory['meals'].length,
                              itemBuilder: (context, mealIndex) {
                                var meal = mealCategory['meals'][mealIndex];
                                return Container(
                                  margin: EdgeInsets.only(bottom: screenHeight * 0.015),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                    // Add a subtle border with the meal color
                                    border: Border.all(
                                      color: mealColor.withOpacity(0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(screenWidth * 0.04),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Meal name
                                        Text(
                                          meal['meal'] ?? '',
                                          style: Theme.of(context).textTheme.labelLarge,
                                        ),
                                        SizedBox(height: screenHeight * 0.015),

                                        // Nutrition info
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: screenHeight * 0.01,
                                            horizontal: screenWidth * 0.02,
                                          ),
                                          decoration: BoxDecoration(
                                            color: mealColor.withOpacity(0.05),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              // Protein
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/meat.png',
                                                      width: screenWidth * 0.05,
                                                    ),
                                                    SizedBox(width: screenWidth * 0.01),
                                                    Text(
                                                      meal['nutrition']['protein'].toString(),
                                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Container(
                                                width: 1,
                                                height: screenHeight * 0.03,
                                                color: mealColor.withOpacity(0.3),
                                              ),

                                              // Carbs
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/carb.png',
                                                      width: screenWidth * 0.05,
                                                    ),
                                                    SizedBox(width: screenWidth * 0.01),
                                                    Text(
                                                      meal['nutrition']['carbs'].toString(),
                                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Container(
                                                width: 1,
                                                height: screenHeight * 0.03,
                                                color: mealColor.withOpacity(0.3),
                                              ),

                                              // Fats
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/lipid.png',
                                                      width: screenWidth * 0.05,
                                                    ),
                                                    SizedBox(width: screenWidth * 0.01),
                                                    Text(
                                                      meal['nutrition']['fats'].toString(),
                                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),

                    // Done Button
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.02,
                        bottom: screenHeight * 0.01,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NavigationPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF289004),
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Done',
                          ),
                        ),
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
