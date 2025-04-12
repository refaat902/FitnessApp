import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/categorybreakfast/data/cubit/meals_cubit.dart';
import 'package:flutter_application_1/views/navigation/meals/breakfast/widgets/bloc_list_break_fast_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreakFastPage extends StatefulWidget {
  final int? index;
  final bool showArrowBack;
  const BreakFastPage({super.key, this.index, required this.showArrowBack});

  @override
  State<BreakFastPage> createState() => _BreakFastPageState();
}

class _BreakFastPageState extends State<BreakFastPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        BlocProvider.of<MealsCubit>(context).emitMealsByType('Breakfast');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocListBreakFastPage(
        index: widget.index,
        showArrowBack: widget.showArrowBack,
      ),
    );
  }
}
