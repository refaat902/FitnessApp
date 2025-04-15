import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/data/model/meals_response_model.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/fav_meal_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteMeals extends StatefulWidget {
  const FavoriteMeals({super.key});

  @override
  State<FavoriteMeals> createState() => _FavoriteMealsState();
}

class _FavoriteMealsState extends State<FavoriteMeals> {
  List<MealsResponseModel> favMeals = [];
  final Color customColor =  Colors.white;
  final Color primaryGreen = const Color(0xff289004);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavMealCubit>(context).emitGetFavMeal();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: BlocBuilder<FavMealCubit, FavMealState>(
        builder: (context, state) {
          if (state is FavMealSuccessState) {
            favMeals = state.favMealList;
            
            if (favMeals.isEmpty) {
              return _buildEmptyState(height);
            }
            
            return _buildMealsList(width, height);
          } else {
            return const ShimmerListTile();
          }
        },
      ),
    );
  }
  
  Widget _buildEmptyState(double height) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.restaurant,
            size: height * 0.1, // Responsive icon size
            color: Colors.grey[400],
          ),
          SizedBox(height: height * 0.02),
          Text(
            "No favorite meals yet",
            style: TextStyle(
              fontSize: height * 0.025, // Responsive text size
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMealsList(double width, double height) {
    // Calculate responsive padding and spacing
    final horizontalPadding = width * 0.04;
    final verticalPadding = height * 0.02;
    final cardSpacing = height * 0.015;
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      itemCount: favMeals.length,
      itemBuilder: (context, index) {
        final meal = favMeals[index];
        return _buildMealCard(meal, width, height, cardSpacing);
      },
    );
  }
  
  Widget _buildMealCard(MealsResponseModel meal, double width, double height, double spacing) {
    // Calculate responsive dimensions
    final cardHeight = height * 0.35; // Card takes up 35% of screen height
    final imageHeight = cardHeight * 0.45; // Image takes 45% of card height
    final contentPadding = width * 0.04;
    
    return Container(
      margin: EdgeInsets.only(bottom: spacing),
      height: cardHeight,
      decoration: BoxDecoration(
        color: customColor, // Using your preferred color
        borderRadius: BorderRadius.circular(width * 0.04),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with gradient overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.04),
                  topRight: Radius.circular(width * 0.04),
                ),
                child: Image.network(
                  meal.imageUrl ?? 'https://via.placeholder.com/400x200?text=No+Image',
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: imageHeight,
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image_not_supported,
                        size: width * 0.1,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: imageHeight * 0.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        // ignore: deprecated_member_use
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: height * 0.01,
                left: width * 0.04,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02, 
                    vertical: height * 0.005
                  ),
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(width * 0.04),
                  ),
                  child: Text(
                    meal.mealType ?? "Meal",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Content section
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(contentPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    meal.name ?? 'Unnamed Meal',
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  
                  // Description
                  if (meal.description != null && meal.description!.isNotEmpty)
                    Expanded(
                      child: Text(
                        meal.description!,
                        style: TextStyle(
                          fontSize: width * 0.035,
                          color: Colors.grey[800],
                          // height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  
                  
                  // Nutrition info
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.01, 
                      horizontal: width * 0.02
                    ),
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(width * 0.02),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNutritionStat("Calories", "${meal.calories ?? 0}", width, height),
                        _divider(height),
                        _buildNutritionStat("Protein", "${meal.protein ?? 0}g", width, height),
                        _divider(height),
                        _buildNutritionStat("Carbs", "${meal.carbs ?? 0}g", width, height),
                        _divider(height),
                        _buildNutritionStat("Fat", "${meal.fat ?? 0}g", width, height),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNutritionStat(String label, String value, double width, double height) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: width * 0.035,
            fontWeight: FontWeight.bold,
            color: primaryGreen,
          ),
        ),
        SizedBox(height: height * 0.004),
        Text(
          label,
          style: TextStyle(
            fontSize: width * 0.03,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
  
  Widget _divider(double height) {
    return Container(
      height: height * 0.03,
      width: 1,
      color: Colors.grey[400],
    );
  }
}