import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/views/category/categorybodyweight/data/cubit/bodyweight_cubit.dart';
import 'package:flutter_application_1/views/category/categorycardio/data/cubit/cardio_cubit.dart';
import 'package:flutter_application_1/views/category/categorystrength/data/cubit/strength_cubit.dart';
import 'package:flutter_application_1/views/navigation/exercise/bodyweight/bodyweight_page.dart';
import 'package:flutter_application_1/views/navigation/exercise/cardio/cardio_page.dart';
import 'package:flutter_application_1/views/navigation/exercise/strength/strength_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisePage extends StatelessWidget {
  final bool showArrowBack;
  final int? index;
  final int? tabIndex;
  const ExercisePage(
      {super.key, required this.showArrowBack, this.index, this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: tabIndex ?? 0,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                leading: showArrowBack
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () => Navigator.pop(context),
                      )
                    : null,
                title: const Text("Exercises"),
                floating: true,
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * .05,
                  ),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white),
                  indicator: const BoxDecoration(
                    color: Color(0xff289004),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  dividerHeight: 0,
                  overlayColor: WidgetStateColor.transparent,
                  tabs: const [
                    Tab(text: "Strength"),
                    Tab(text: "Cardio"),
                    Tab(text: "Body"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              BlocProvider(
                create: (context) => getIt<StrengthCubit>(),
                child: StrengthPage(
                  index: index,
                  showArrowBack: false,
                ),
              ),
              BlocProvider(
                create: (context) => getIt<CardioCubit>(),
                child: CardioPage(
                  index: index,
                  showArrowBack: false,
                ),
              ),
              BlocProvider(
                create: (context) => getIt<BodyweightCubit>(),
                child: BodyweightPage(
                  index: index,
                  showArrowBack: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
