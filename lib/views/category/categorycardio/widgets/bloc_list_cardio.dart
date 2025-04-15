import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/category/categorycardio/data/cubit/cardio_cubit.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
import 'package:flutter_application_1/views/navigation/exercise/exercise_page.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/add_tofav_exe_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/fav_exercise_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class BlocListCardio extends StatefulWidget {
  final bool showArrowBack;
  const BlocListCardio({super.key, required this.showArrowBack});

  @override
  State<BlocListCardio> createState() => _BlocListCardioState();
}

class _BlocListCardioState extends State<BlocListCardio>
    with TickerProviderStateMixin {
  final Map<int, bool> favExeMap = {};
  final Map<int, AnimationController> _controllers = {};
  final Color customColor =  Colors.white;
  final Color primaryGreen = const Color(0xff289004);
  final Color accentColor = const Color(0xff7FB041);

  List<ExeResponseModel> exeList = [];

  @override
  void initState() {
    super.initState();
    // Fetch favorites initially
    BlocProvider.of<FavExerciseCubit>(context).emitGetFavExercise();
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
    
    return BlocBuilder<CardioCubit, CardioState>(
      builder: (context, exeState) {
        if (exeState is ExeByTypeCardioSuccessState) {
          exeList = exeState.exeByTypeList;

          return BlocBuilder<FavExerciseCubit, FavExerciseState>(
            builder: (context, favState) {
              Set<String> favoriteIds = {};
              if (favState is FavExerciseSuccessState) {
                favoriteIds = favState.favExerciseList
                    .map((exe) => exe.id.toString())
                    .toSet();
              }

              return exeList.isEmpty 
                  ? _buildEmptyState(height)
                  : _buildExerciseList(width, height, favoriteIds);
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
            Icons.directions_run,
            size: height * 0.12,
            color: Colors.grey[400],
          ),
          SizedBox(height: height * 0.025),
          Text(
            "No cardio exercises available",
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
              "Check back later for cardio workout options",
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
  
  Widget _buildExerciseList(double width, double height, Set<String> favoriteIds) {
    final horizontalPadding = width * 0.04;
    final verticalPadding = height * 0.02;
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      itemCount: exeList.length,
      itemBuilder: (context, index) {
        final exercise = exeList[index];
        final exeId = exercise.id.toString();
        
        // Determine initial favorite status
        bool isFavorite = favoriteIds.contains(exeId);
        favExeMap[index] = isFavorite;

        _controllers[index] ??= AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 1),
        );

        // Set animation controller value if already favorite
        if (isFavorite && _controllers[index]!.isDismissed) {
          _controllers[index]!.value = 1.0;
        }
        
        return _buildExerciseCard(exercise, exeId, index, width, height);
      },
    );
  }
  
  Widget _buildExerciseCard(
    ExeResponseModel exercise, 
    String exeId, 
    int index, 
    double width, 
    double height
  ) {
    final cardHeight = height * 0.35;
    final cardMargin = height * 0.012;
    final contentPadding = width * 0.035;
    
    // Get difficulty color
    Color difficultyColor = _getDifficultyColor(exercise.difficultyLevel ?? '');
    
    return GestureDetector(
      onTap: widget.showArrowBack
          ? () {
              Navigator.push(
                context,
                CustomPageRoute(
                  page: BlocProvider(
                    create: (context) => getIt<CardioCubit>(),
                    child: ExercisePage(
                      showArrowBack: widget.showArrowBack,
                      index: index,
                      tabIndex: 1,
                    ),
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
              tag: 'exercise_image_${exercise.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width * 0.04),
                  bottomLeft: Radius.circular(width * 0.04),
                ),
                child: Container(
                  width: width * 0.35,
                  height: cardHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image or placeholder
                      exercise.imageUrl != null 
                          ? Image.network(
                              exercise.imageUrl!,
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
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      // Difficulty level badge
                      if (exercise.difficultyLevel != null)
                        Positioned(
                          bottom: height * 0.01,
                          left: width * 0.02,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                              vertical: height * 0.004,
                            ),
                            decoration: BoxDecoration(
                              color: difficultyColor,
                              borderRadius: BorderRadius.circular(width * 0.02),
                            ),
                            child: Text(
                              exercise.difficultyLevel!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.028,
                                fontWeight: FontWeight.bold,
                              ),
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
                            exercise.name ?? 'Unnamed Exercise',
                            style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.bold,
                              color: primaryGreen,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (favExeMap[index] == false) {
                              setState(() {
                                favExeMap[index] = true;
                              });
                              BlocProvider.of<AddTofavExeCubit>(context)
                                  .emitAddToFavExe(exeId);
                              _controllers[index]!.forward();
                            } else {
                              setState(() {
                                favExeMap[index] = false;
                              });
                              BlocProvider.of<AddTofavExeCubit>(context)
                                  .emitDeleteFavExe(exeId);
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
                                if (favExeMap[index] == true) {
                                  _controllers[index]!.value = 1.0;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Description if available
                    if (exercise.description != null && exercise.description!.isNotEmpty)
                      Flexible(
                        child: Text(
                          exercise.description!,
                          style: TextStyle(
                            fontSize: width * 0.032,
                            color: Colors.grey[700],
                          ),
                          // maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
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
          Icons.fitness_center,
          size: width * 0.15,
          color: Colors.grey[500],
        ),
      ),
    );
  }
  Color _getDifficultyColor(String difficulty) {
    final lowerDifficulty = difficulty.toLowerCase();
    if (lowerDifficulty.contains('beginner') || lowerDifficulty.contains('easy')) {
      return Colors.green[600]!;
    } else if (lowerDifficulty.contains('intermediate') || lowerDifficulty.contains('medium')) {
      return Colors.orange[600]!;
    } else if (lowerDifficulty.contains('advanced') || lowerDifficulty.contains('hard')) {
      return Colors.red[600]!;
    } else {
      return primaryGreen;
    }
  }
}