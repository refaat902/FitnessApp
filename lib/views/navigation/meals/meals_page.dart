import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/navigation/meals/breakfast/break_fast_page.dart';
import 'package:flutter_application_1/views/navigation/meals/dinner/dinner_page.dart';
import 'package:flutter_application_1/views/navigation/meals/lunch/lunch_page.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key});

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
                title: const Text("Meals"),
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
                      color: Color(0xff289004),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
          body: const TabBarView(
            children: [
              BreakFastPage(),
              LunchPage(),
              DinnerPage(),
            ],
          ),
        ),
      ),
    );
  }
}
