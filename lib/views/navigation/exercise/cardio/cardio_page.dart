import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/categorycardio/data/cubit/cardio_cubit.dart';
import 'package:flutter_application_1/views/navigation/exercise/cardio/widgets/bloc_list_cardio_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardioPage extends StatefulWidget {
  final int? index;
  final bool showArrowBack;
  const CardioPage({super.key, this.index, required this.showArrowBack});

  @override
  State<CardioPage> createState() => _CardioPageState();
}

class _CardioPageState extends State<CardioPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        BlocProvider.of<CardioCubit>(context).emitExeByType('Cardio');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocListCardioPage(
        showArrowBack: widget.showArrowBack,
        index: widget.index,
      ),
    );
  }
}
