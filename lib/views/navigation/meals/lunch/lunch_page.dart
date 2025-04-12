import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/categorylunch/data/cubit/lunch_cubit.dart';
import 'package:flutter_application_1/views/navigation/meals/lunch/widgets/bloc_list_lunch_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LunchPage extends StatefulWidget {
  final int? index;
  final bool showArrowBack;
  const LunchPage({super.key, this.index, required this.showArrowBack});

  @override
  State<LunchPage> createState() => _LunchPageState();
}

class _LunchPageState extends State<LunchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        BlocProvider.of<LunchCubit>(context).emitMealsByType('Lunch');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocListLunchPage(
        index: widget.index,
        showArrowBack: widget.showArrowBack,
      ),
    );
  }
}
