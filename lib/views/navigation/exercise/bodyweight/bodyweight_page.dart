import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/categorybodyweight/data/cubit/bodyweight_cubit.dart';
import 'package:flutter_application_1/views/navigation/exercise/bodyweight/widgets/bloc_list_body_weight_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyweightPage extends StatefulWidget {
  final int? index;
  final bool showArrowBack;
  const BodyweightPage({super.key, this.index, required this.showArrowBack});

  @override
  State<BodyweightPage> createState() => _BodyweightPageState();
}

class _BodyweightPageState extends State<BodyweightPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        BlocProvider.of<BodyweightCubit>(context).emitExeByType('Body Weight');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocListBodyWeightPage(
        showArrowBack: widget.showArrowBack,
        index: widget.index,
      ),
    );
  }
}
