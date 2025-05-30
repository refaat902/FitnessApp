import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/aiexe/ai_exe_page.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/arm_cubit_cubit.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/back_cubit.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/chest_cubit.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/legs_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class StartExePage extends StatefulWidget {
  const StartExePage({super.key});

  @override
  State<StartExePage> createState() => _StartExePageState();
}

class _StartExePageState extends State<StartExePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ArmCubitCubit>(context).emitExeByMuscleGroupLegs('Arms');
    BlocProvider.of<ChestCubit>(context).emitExeByMuscleGroupChest('Chest');
    BlocProvider.of<BackCubit>(context).emitExeByMuscleGroupBack('Back');
    BlocProvider.of<LegsCubit>(context).emitExeByMuscleGroupLegs('Legs');

  }
  
  // Function to get difficulty color
  Color getDifficultyColor(String? difficulty) {
    switch (difficulty?.toLowerCase()) {
      case "beginner":
        return Colors.green;
      case "intermediate":
        return Colors.orange;
      case "advanced":
        return Colors.red;
      case "expert":
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }
  
  // Get appropriate icon for difficulty level
  IconData getDifficultyIcon(String? difficulty) {
    switch (difficulty?.toLowerCase()) {
      case "beginner":
        return Icons.sentiment_satisfied_alt;
      case "intermediate":
        return Icons.fitness_center;
      case "advanced":
        return Icons.whatshot;
      case "expert":
        return Icons.local_fire_department;
      default:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            children: [
                            // Chest Section
              _buildSectionHeader(
                context: context,
                title: "Arm",
                icon: Icons.fitness_center,
                screenWidth: screenWidth,
              ),
              BlocBuilder<ArmCubitCubit, ArmCubitState>(
                builder: (context, state) {
                  if (state is GetExeByMuscleGroupArmSuccessState) {
                    return _buildExerciseList(
                      context: context,
                      exercisesList: state.exeByMuscleGroupArmsList,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      muscleColor: const Color(0xFFF97B22), // Orange for chest
                      navigateToExercise: (index) {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            page: AiExePage(
                              image: state.exeByMuscleGroupArmsList[index].imageUrl.toString(),
                              name: state.exeByMuscleGroupArmsList[index].name.toString(),
                              youtubeUrl: state.exeByMuscleGroupArmsList[index].videoUrl.toString(),
                              aiModel: state.exeByMuscleGroupArmsList[index].aiModelReference ?? '',
                              instructionSteps: state.exeByMuscleGroupArmsList[index].instructionSteps.toString(),
                            ),
                            transitionType: TransitionType.slide,
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      height: screenHeight * 0.3,
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: const ShimmerListTile(),
                    );
                  }
                },
              ),

              SizedBox(height: screenHeight * 0.02),
              // Chest Section
              _buildSectionHeader(
                context: context,
                title: "Chest",
                icon: Icons.fitness_center,
                screenWidth: screenWidth,
              ),
              BlocBuilder<ChestCubit, ChestState>(
                builder: (context, state) {
                  if (state is GetExeByMuscleGroupChestSuccessState) {
                    return _buildExerciseList(
                      context: context,
                      exercisesList: state.exeByMuscleGroupChestList,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      muscleColor: const Color(0xFFF97B22), // Orange for chest
                      navigateToExercise: (index) {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            page: AiExePage(
                              image: state.exeByMuscleGroupChestList[index].imageUrl.toString(),
                              name: state.exeByMuscleGroupChestList[index].name.toString(),
                              youtubeUrl: state.exeByMuscleGroupChestList[index].videoUrl.toString(),
                              aiModel: state.exeByMuscleGroupChestList[index].aiModelReference ?? '',
                              instructionSteps: state.exeByMuscleGroupChestList[index].instructionSteps.toString(),
                            ),
                            transitionType: TransitionType.slide,
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      height: screenHeight * 0.3,
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: const ShimmerListTile(),
                    );
                  }
                },
              ),

              SizedBox(height: screenHeight * 0.02),

              // Back Section
              _buildSectionHeader(
                context: context,
                title: "Back",
                icon: Icons.arrow_upward,
                screenWidth: screenWidth,
              ),
              BlocBuilder<BackCubit, BackState>(
                builder: (context, state) {
                  if (state is GetExeByMuscleGroupBackSuccessState) {
                    return _buildExerciseList(
                      context: context,
                      exercisesList: state.exeByMuscleGroupBackList,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      muscleColor: const Color(0xFF3E6D9C), // Blue for back
                      navigateToExercise: (index) {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            page: AiExePage(
                              image: state.exeByMuscleGroupBackList[index].imageUrl.toString(),
                              name: state.exeByMuscleGroupBackList[index].name.toString(),
                              youtubeUrl: state.exeByMuscleGroupBackList[index].videoUrl.toString(),
                              aiModel: state.exeByMuscleGroupBackList[index].aiModelReference ?? '',
                              instructionSteps: state.exeByMuscleGroupBackList[index].instructionSteps.toString(),
                            ),
                            transitionType: TransitionType.slide,
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      height: screenHeight * 0.3,
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: const ShimmerListTile(),
                    );
                  }
                },
              ),

              SizedBox(height: screenHeight * 0.02),

              // Legs Section
              _buildSectionHeader(
                context: context,
                title: "Legs",
                icon: Icons.accessibility_new,
                screenWidth: screenWidth,
              ),
              BlocBuilder<LegsCubit, LegsState>(
                builder: (context, state) {
                  if (state is GetExeByMuscleGroupLegsSuccessState) {
                    return _buildExerciseList(
                      context: context,
                      exercisesList: state.exeByMuscleGroupLegsList,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      muscleColor: const Color(0xFF7AA874), // Green for legs
                      navigateToExercise: (index) {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            page: AiExePage(
                              image: state.exeByMuscleGroupLegsList[index].imageUrl.toString(),
                              name: state.exeByMuscleGroupLegsList[index].name.toString(),
                              youtubeUrl: state.exeByMuscleGroupLegsList[index].videoUrl.toString(),
                              aiModel: state.exeByMuscleGroupLegsList[index].aiModelReference ?? '',
                              instructionSteps: state.exeByMuscleGroupLegsList[index].instructionSteps.toString(),
                            ),
                            transitionType: TransitionType.slide,
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      height: screenHeight * 0.3,
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: const ShimmerListTile(),
                    );
                  }
                },
              ),

              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  // Section Header Widget
  Widget _buildSectionHeader({
    required BuildContext context,
    required String title,
    required IconData icon,
    required double screenWidth,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenWidth * 0.02,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.02),
            decoration: BoxDecoration(
              color: const Color(0xff289004).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: screenWidth * 0.06,
              color: const Color(0xff289004),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }

  // Exercise List Widget
  Widget _buildExerciseList({
    required BuildContext context,
    required List exercisesList,
    required double screenHeight,
    required double screenWidth,
    required Color muscleColor,
    required Function(int) navigateToExercise,
  }) {
    return SizedBox(
      height: screenHeight * 0.3,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: exercisesList.length,
        itemBuilder: (context, index) {
          // Get difficulty level for this exercise from the API data
          final String? difficultyLevel = exercisesList[index].difficultyLevel;
          final difficultyColor = getDifficultyColor(difficultyLevel);
          
          return GestureDetector(
            onTap: () => navigateToExercise(index),
            child: Container(
              margin: EdgeInsets.only(
                left: index == 0 ? screenWidth * 0.05 : screenWidth * 0.03,
                right: index == exercisesList.length - 1 ? screenWidth * 0.05 : 0,
              ),
              width: screenWidth * 0.55,
              child: Stack(
                children: [
                  // Exercise Image with gradient overlay
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Image
                            Positioned.fill(
                              child: Image.network(
                                exercisesList[index].imageUrl.toString(),
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                (loadingProgress.expectedTotalBytes ?? 1)
                                            : null,
                                        color: muscleColor,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: Icon(Icons.error, color: Colors.red),
                                    ),
                                  );
                                },
                              ),
                            ),
                            
                            // Gradient overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                    stops: const [0.6, 1.0],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Exercise name
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.015,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exercisesList[index].name.toString(),
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Row(
                            children: [
                              Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: screenWidth * 0.04,
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Text(
                                "Watch Video",
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.white, 
                                  fontSize: 11
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Difficulty level indicator from API
                  if (difficultyLevel != null && difficultyLevel.isNotEmpty)
                  Positioned(
                    top: screenHeight * 0.015,
                    left: screenWidth * 0.03,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.005,
                      ),
                      decoration: BoxDecoration(
                        color: difficultyColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            getDifficultyIcon(difficultyLevel),
                            color: Colors.white,
                            size: screenWidth * 0.035,
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Text(
                            difficultyLevel.capitalize(),
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                              fontSize: 10,
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
          );
        },
      ),
    );
  }
}

// Extension to capitalize the first letter of a string
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}