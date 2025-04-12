import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/categorybreakfast/data/cubit/meals_cubit.dart';
import 'package:flutter_application_1/views/category/categorydinner/data/cubit/dinner_cubit.dart';
import 'package:flutter_application_1/views/navigation/meals/breakfast/widgets/bloc_list_break_fast_page.dart';
import 'package:flutter_application_1/views/navigation/meals/dinner/widgets/bloc_list_dinner_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DinnerPage extends StatefulWidget {
  final int? index;
  final bool showArrowBack;
  const DinnerPage({super.key, this.index, required this.showArrowBack});

  @override
  State<DinnerPage> createState() => _DinnerPageState();
}

class _DinnerPageState extends State<DinnerPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        BlocProvider.of<DinnerCubit>(context).emitMealsByType('Dinner');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocListDinnerPage(
        index: widget.index,
        showArrowBack: widget.showArrowBack,
      ),
    );
  }
}
