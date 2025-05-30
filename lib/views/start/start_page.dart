import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/views/aimeal/data/cubit/ai_meal_cubit.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/arm_cubit_cubit.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/back_cubit.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/chest_cubit.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/legs_cubit.dart';
import 'package:flutter_application_1/views/startexe/start_exe_page.dart';
import 'package:flutter_application_1/views/userprofile/user_profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text("Ai Featuers"),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                floating: true,
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * .05),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                  indicator: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  dividerHeight: 0,
                  overlayColor: WidgetStateColor.transparent,
                  tabs: const [
                    Tab(text: "Meals"),
                    Tab(text: "Workouts"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              BlocProvider(
                create: (context) => getIt<AiMealCubit>(),
                child: const UserProfilePage(),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<ArmCubitCubit>()),
                  BlocProvider(create: (context) => getIt<ChestCubit>()),
                  BlocProvider(
                    create: (context) => getIt<BackCubit>(),
                  ),
                  BlocProvider(create: (context) => getIt<LegsCubit>()),
                ],
                child: const StartExePage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
