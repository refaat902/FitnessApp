import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/views/category/categorybreakfast/data/cubit/meals_cubit.dart';
import 'package:flutter_application_1/views/navigation/meals/breakfast/break_fast_page.dart';
import 'package:flutter_application_1/views/navigation/meals/dinner/dinner_page.dart';
import 'package:flutter_application_1/views/navigation/meals/lunch/lunch_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealsPage extends StatelessWidget {
  final bool showArrowBack;
  final int? index;
  const MealsPage({super.key, required this.showArrowBack, this.index});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                title: const Text("Meals"),
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
                    Tab(text: "Breakfast"),
                    Tab(text: "Lunch"),
                    Tab(text: "Dinner"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              BlocProvider(
                create: (context) => getIt<MealsCubit>(),
                child:  BreakFastPage(
                  index: index,
                  showArrowBack: false,
                ),
              ),
              const LunchPage(),
              const DinnerPage(),
            ],
          ),
        ),
      ),
    );
  }
}
