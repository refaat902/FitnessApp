import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
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
  final Color customColor =  Colors.white;
  final Color primaryGreen = const Color(0xff289004);
  final Color accentColor = const Color(0xff7FB041);

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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    
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

              return mealsList.isEmpty 
                  ? _buildEmptyState(height)
                  : _buildMealsList(width, height, favoriteIds);
            },
          );
        } else {
          return _buildShimmerList(width, height);
        }
      },
    );
  }
  
  Widget _buildEmptyState(double height) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lunch_dining,
            size: height * 0.12,
            color: Colors.grey[400],
          ),
          SizedBox(height: height * 0.025),
          Text(
            "No lunch meals available",
            style: TextStyle(
              fontSize: height * 0.025,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: height * 0.01),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: height * 0.05),
            child: Text(
              "Check back later for delicious lunch options",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: height * 0.018,
                color: Colors.grey[500],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildShimmerList(double width, double height) {
    return ListView.builder(
      padding: EdgeInsets.all(width * 0.04),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: height * 0.015),
          child: const ShimmerListTile(),
        );
      },
    );
  }
  
  Widget _buildMealsList(double width, double height, Set<String> favoriteIds) {
    final horizontalPadding = width * 0.04;
    final verticalPadding = height * 0.02;
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      itemCount: mealsList.length,
      itemBuilder: (context, index) {
        final meal = mealsList[index];
        final mealId = meal.id.toString();
        
        // Determine initial favorite status
        bool isFavorite = favoriteIds.contains(mealId);
        favMealMap[index] = isFavorite;

        _controllers[index] ??= AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 1),
        );

        // Set animation controller value if already favorite
        if (isFavorite && _controllers[index]!.isDismissed) {
          _controllers[index]!.value = 1.0;
        }
        
        return _buildMealCard(meal, mealId, index, width, height);
      },
    );
  }
  
  Widget _buildMealCard(
    MealsResponseModel meal, 
    String mealId, 
    int index, 
    double width, 
    double height
  ) {
    final cardHeight = height * 0.33;
    final cardMargin = height * 0.012;
    final contentPadding = width * 0.035;
    
    return GestureDetector(
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
      child: Container(
        height: cardHeight,
        margin: EdgeInsets.only(bottom: cardMargin),
        decoration: BoxDecoration(
          color: customColor,
          borderRadius: BorderRadius.circular(width * 0.04),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 3),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            // Left side - Image
            Hero(
              tag: 'meal_image_${meal.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.04),
                  bottomLeft: Radius.circular(width * 0.04),
                ),
                child: SizedBox(
                  width: width * 0.35,
                  height: cardHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image or placeholder
                      meal.imageUrl != null 
                          ? Image.network(
                              meal.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildImagePlaceholder(width);
                              },
                            )
                          : _buildImagePlaceholder(width),
                          
                      // Gradient overlay
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: height * 0.05,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                // ignore: deprecated_member_use
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      // Calories badge
                      if (meal.calories != null)
                        Positioned(
                          bottom: height * 0.01,
                          left: width * 0.02,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                              vertical: height * 0.004,
                            ),
                            decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.circular(width * 0.02),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: Colors.white,
                                  size: width * 0.035,
                                ),
                                SizedBox(width: width * 0.01),
                                Text(
                                  "${meal.calories} kcal",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.028,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Right side - Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(contentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and favorite button
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            meal.name ?? 'Unnamed Meal',
                            style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (favMealMap[index] == false) {
                              setState(() {
                                favMealMap[index] = true;
                              });
                              BlocProvider.of<AddToFavMealCubit>(context)
                                  .emitAddToFavMeal(mealId);
                              _controllers[index]!.forward();
                            } else {
                              setState(() {
                                favMealMap[index] = false;
                              });
                              BlocProvider.of<AddToFavMealCubit>(context)
                                  .emitDeleteFavMeal(mealId);
                              _controllers[index]!.reverse();
                            }
                          },
                          child: SizedBox(
                            width: width * 0.09,
                            height: width * 0.09,
                            child: Lottie.asset(
                              'assets/animations/fav.json',
                              controller: _controllers[index],
                              onLoaded: (composition) {
                                _controllers[index]!.duration = composition.duration;
                                if (favMealMap[index] == true) {
                                  _controllers[index]!.value = 1.0;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Description if available
                    if (meal.description != null && meal.description!.isNotEmpty)
                      Flexible(
                        child: Text(
                          meal.description!,
                          style: TextStyle(
                            fontSize: width * 0.032,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    
                    // Spacer
                    const Spacer(),
                    
                    // Nutrition info
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.008,
                        horizontal: width * 0.02,
                      ),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(width * 0.02),
                        border: Border.all(
                          // ignore: deprecated_member_use
                          color: accentColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNutrient(
                            'assets/images/meat.png', 
                            '${meal.protein ?? 0}g', 
                            'Protein',
                            width,
                            height,
                          ),
                          _buildVerticalDivider(height),
                          _buildNutrient(
                            'assets/images/carb.png', 
                            '${meal.carbs ?? 0}g', 
                            'Carbs',
                            width,
                            height,
                          ),
                          _buildVerticalDivider(height),
                          _buildNutrient(
                            'assets/images/lipid.png', 
                            '${meal.fat ?? 0}g', 
                            'Fat',
                            width,
                            height,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildImagePlaceholder(double width) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Icon(
          Icons.restaurant,
          size: width * 0.15,
          color: Colors.grey[500],
        ),
      ),
    );
  }
  
  Widget _buildVerticalDivider(double height) {
    return Container(
      height: height * 0.04,
      width: 1,
      color: Colors.grey[300],
    );
  }
  
  Widget _buildNutrient(
    String iconPath, 
    String value, 
    String label,
    double width,
    double height,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.006),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                iconPath,
                width: width * 0.035,
                height: width * 0.035,
              ),
              SizedBox(width: width * 0.005),
              Text(
                value,
                style: TextStyle(
                  fontSize: width * 0.032,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.002),
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.026,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}