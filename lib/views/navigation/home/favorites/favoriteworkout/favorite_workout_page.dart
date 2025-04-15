import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/fav_exercise_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteWorkoutPage extends StatefulWidget {
  const FavoriteWorkoutPage({super.key});

  @override
  State<FavoriteWorkoutPage> createState() => _FavoriteWorkoutPageState();
}

class _FavoriteWorkoutPageState extends State<FavoriteWorkoutPage> {
  List<ExeResponseModel> favExe = [];
  final Color customColor =  Colors.white;
  final Color primaryGreen = const Color(0xff289004);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavExerciseCubit>(context).emitGetFavExercise();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: BlocBuilder<FavExerciseCubit, FavExerciseState>(
        builder: (context, state) {
          if (state is FavExerciseSuccessState) {
            favExe = state.favExerciseList;
            
            if (favExe.isEmpty) {
              return _buildEmptyState(height);
            }
            
            return _buildWorkoutsList(width, height);
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
            Icons.fitness_center,
            size: height * 0.1, // Responsive icon size
            color: Colors.grey[400],
          ),
          SizedBox(height: height * 0.02),
          Text(
            "No favorite workouts yet",
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
  
  Widget _buildWorkoutsList(double width, double height) {
    // Calculate responsive padding and spacing
    final horizontalPadding = width * 0.04;
    final verticalPadding = height * 0.02;
    final cardSpacing = height * 0.015;
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      itemCount: favExe.length,
      itemBuilder: (context, index) {
        final workout = favExe[index];
        return _buildWorkoutCard(workout, width, height, cardSpacing);
      },
    );
  }
  
  Widget _buildWorkoutCard(ExeResponseModel workout, double width, double height, double spacing) {
    // Calculate responsive dimensions
    final cardHeight = height * 0.32; // Card takes up 32% of screen height
    final imageHeight = cardHeight * 0.6; // Image takes 60% of card height
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
          // Image section
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(width * 0.04),
              topRight: Radius.circular(width * 0.04),
            ),
            child: Container(
              width: double.infinity,
              height: imageHeight,
              color: Colors.grey[300],
              child: workout.imageUrl != null
                ? Image.network(
                    workout.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: width * 0.1,
                          color: Colors.grey[500],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Icon(
                      Icons.fitness_center,
                      size: width * 0.15,
                      color: Colors.grey[500],
                    ),
                  ),
            ),
          ),
          
          // Content section
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(contentPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row with difficulty
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Exercise name
                      Expanded(
                        child: Text(
                          workout.name ?? 'Unnamed Exercise',
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: primaryGreen,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      // Difficulty level badge
                      if (workout.difficultyLevel != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.004,
                          ),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(workout.difficultyLevel!),
                            borderRadius: BorderRadius.circular(width * 0.02),
                          ),
                          child: Text(
                            workout.difficultyLevel!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  SizedBox(height: height * 0.01),
                  
                  // Exercise details row
                  Row(
                    children: [
                      // Category
                      if (workout.category != null)
                        _buildDetailChip(
                          Icons.category,
                          workout.category!,
                          width,
                          height,
                        ),
                      
                      SizedBox(width: width * 0.02),
                      
                      // Muscle group
                      if (workout.muscleGroup != null)
                        _buildDetailChip(
                          Icons.accessibility_new,
                          workout.muscleGroup!,
                          width,
                          height,
                        ),
                        
                      SizedBox(width: width * 0.02),
                      
                      // Equipment
                      if (workout.equipment != null)
                        _buildDetailChip(
                          Icons.fitness_center,
                          workout.equipment!,
                          width,
                          height,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailChip(IconData icon, String label, double width, double height) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.004,
      ),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(width * 0.04),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: width * 0.035,
            color: primaryGreen,
          ),
          SizedBox(width: width * 0.01),
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.03,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
  
  Color _getDifficultyColor(String difficulty) {
    final lowerDifficulty = difficulty.toLowerCase();
    if (lowerDifficulty.contains('beginner') || lowerDifficulty.contains('easy')) {
      return Colors.green;
    } else if (lowerDifficulty.contains('intermediate') || lowerDifficulty.contains('medium')) {
      return Colors.orange;
    } else if (lowerDifficulty.contains('advanced') || lowerDifficulty.contains('hard')) {
      return Colors.red;
    } else {
      return primaryGreen;
    }
  }
}