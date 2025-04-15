import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/aiexe/ai_exe_page.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
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
    BlocProvider.of<ChestCubit>(context).emitExeByMuscleGroupChest('Chest');
    BlocProvider.of<BackCubit>(context).emitExeByMuscleGroupBack('Back');
    BlocProvider.of<LegsCubit>(context).emitExeByMuscleGroupLegs('Legs');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height * .02),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.sizeOf(context).width * .02,
                      bottom: MediaQuery.sizeOf(context).height * .01),
                  child: Row(
                    children: [
                      Text("Chest",
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
                BlocBuilder<ChestCubit, ChestState>(
                  builder: (context, state) {
                    if (state is GetExeByMuscleGroupChestSuccessState) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * .3,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.exeByMuscleGroupChestList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width * .05),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CustomPageRoute(
                                          page: AiExePage(
                                            image: state
                                                .exeByMuscleGroupChestList[index]
                                                .imageUrl
                                                .toString(),
                                            name: state
                                                .exeByMuscleGroupChestList[index]
                                                .name
                                                .toString(),
                                            youtubeUrl: state
                                                .exeByMuscleGroupChestList[index]
                                                .videoUrl
                                                .toString(),
                                            aiModel: state.exeByMuscleGroupChestList[index].aiModelReference ?? '',
                                            instructionSteps:  state
                                                .exeByMuscleGroupChestList[index]
                                                .instructionSteps
                                                .toString(),
                                          ),
                                          transitionType:
                                              TransitionType.slide));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: 
                                    
                                    Image.network(
                                      state.exeByMuscleGroupChestList[index]
                                          .imageUrl
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const ShimmerListTile();
                    } // or a loading widget / error
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.sizeOf(context).width * .02,
                      bottom: MediaQuery.sizeOf(context).height * .01,
                      top: MediaQuery.sizeOf(context).height * .01),
                  child: Row(
                    children: [
                      Text("Back",
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
                BlocBuilder<BackCubit, BackState>(
                  builder: (context, state) {
                    if (state is GetExeByMuscleGroupBackSuccessState) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * .3,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.exeByMuscleGroupBackList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width * .05),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CustomPageRoute(
                                          page: AiExePage(
                                            image: state
                                                .exeByMuscleGroupBackList[index]
                                                .imageUrl
                                                .toString(),
                                            name: state
                                                .exeByMuscleGroupBackList[index]
                                                .name
                                                .toString(),
                                            youtubeUrl: state
                                                .exeByMuscleGroupBackList[index]
                                                .videoUrl
                                                .toString(),
                                            aiModel: state.exeByMuscleGroupBackList[index].aiModelReference ?? '',
                                            instructionSteps:  state
                                                .exeByMuscleGroupBackList[index]
                                                .instructionSteps
                                                .toString(),
                                          ),
                                          transitionType:
                                              TransitionType.slide));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: 
                                    
                                    Image.network(
                                      state.exeByMuscleGroupBackList[index]
                                          .imageUrl
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const ShimmerListTile();
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.sizeOf(context).width * .02,
                      bottom: MediaQuery.sizeOf(context).height * .01,
                      top: MediaQuery.sizeOf(context).height * .01),
                  child: Row(
                    children: [
                      Text("Legs",
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
                BlocBuilder<LegsCubit, LegsState>(
                  builder: (context, state) {
                    if (state is GetExeByMuscleGroupLegsSuccessState) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * .3,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.exeByMuscleGroupLegsList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width * .05),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CustomPageRoute(
                                          page: AiExePage(
                                            image: state
                                                .exeByMuscleGroupLegsList[index]
                                                .imageUrl
                                                .toString(),
                                            name: state
                                                .exeByMuscleGroupLegsList[index]
                                                .name
                                                .toString(),
                                            youtubeUrl: state
                                                .exeByMuscleGroupLegsList[index]
                                                .videoUrl
                                                .toString(),
                                            aiModel: state.exeByMuscleGroupLegsList[index].aiModelReference ?? '',
                                            instructionSteps:  state
                                                .exeByMuscleGroupLegsList[index]
                                                .instructionSteps
                                                .toString(),
                                          ),
                                          transitionType:
                                              TransitionType.slide));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: 
                                    
                                    Image.network(
                                      state.exeByMuscleGroupLegsList[index]
                                          .imageUrl
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const ShimmerListTile();
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
