import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/categorystrength/data/cubit/strength_cubit.dart';
import 'package:flutter_application_1/views/navigation/exercise/strength/widgets/bloc_list_strength_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StrengthPage extends StatefulWidget {
  final int? index;
  final bool showArrowBack;
  const StrengthPage({super.key, this.index, required this.showArrowBack});

  @override
  State<StrengthPage> createState() => _LunchPageState();
}

class _LunchPageState extends State<StrengthPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        BlocProvider.of<StrengthCubit>(context).emitExeByType('Strength');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocListStrengthPage(
        index: widget.index,
        showArrowBack: widget.showArrowBack,
      ),
    );
  }
}
