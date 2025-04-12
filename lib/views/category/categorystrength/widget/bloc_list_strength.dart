import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/category/categorystrength/data/cubit/strength_cubit.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
import 'package:flutter_application_1/views/navigation/exercise/exercise_page.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/add_tofav_exe_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/fav_exercise_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class BlocListStrength extends StatefulWidget {
  final bool showArrowBack;
  const BlocListStrength({super.key, required this.showArrowBack});

  @override
  State<BlocListStrength> createState() => _BlocListStrengthState();
}

class _BlocListStrengthState extends State<BlocListStrength>
    with TickerProviderStateMixin {
  final Map<int, bool> favExeMap = {};
  final Map<int, AnimationController> _controllers = {};

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
    return BlocBuilder<StrengthCubit, StrengthState>(
      builder: (context, mealState) {
        if (mealState is ExeByTypeStrengthSuccessState) {
          exeList = mealState.exeByTypeList;

          return BlocBuilder<FavExerciseCubit, FavExerciseState>(
            builder: (context, favState) {
              Set<String> favoriteIds = {};
              if (favState is FavExerciseSuccessState) {
                favoriteIds = favState.favExerciseList
                    .map((exe) => exe.id.toString())
                    .toSet();
              }

              return ListView.builder(
                itemCount: exeList.length,
                itemBuilder: (context, index) {
                  final exe = exeList[index];
                  final exeId = exe.id.toString();

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

                  return Card(
                    color: const Color(0xffFCFCFC),
                    elevation: 0,
                    child: ListTile(
                      onTap: widget.showArrowBack
                          ? () {
                              Navigator.push(
                                context,
                                CustomPageRoute(
                                  page: BlocProvider(
                                    create: (context) => getIt<StrengthCubit>(),
                                    child: ExercisePage(
                                      showArrowBack: widget.showArrowBack,
                                      index: index,
                                    ),
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
                              exe.name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontSize: 18),
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
                                BlocProvider.of<AddTofavExeCubit>(context)
                                    .emitDeleteFavExe(exeId);
                                _controllers[index]!.reverse();
                              }
                            },
                            child: Lottie.asset(
                              'assets/animations/fav.json',
                              controller: _controllers[index],
                              onLoaded: (composition) {
                                _controllers[index]!.duration =
                                    composition.duration;
                                if (favExeMap[index] == true) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/level.png',
                                  width: MediaQuery.sizeOf(context).width * .05,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .01,
                                ),
                                Text(
                                  exe.difficultyLevel.toString(),
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
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/kettlebell.png',
                                  width: MediaQuery.sizeOf(context).width * .05,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .01,
                                ),
                                Text(
                                  exe.equipment.toString(),
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
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/folder.png',
                                  width: MediaQuery.sizeOf(context).width * .05,
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * .01,
                                ),
                                Text(
                                  exe.muscleGroup.toString(),
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
