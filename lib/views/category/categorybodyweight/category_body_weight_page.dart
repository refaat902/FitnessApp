import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/views/category/categorybodyweight/data/cubit/bodyweight_cubit.dart';
import 'package:flutter_application_1/views/category/categorybodyweight/widgets/bloc_list_body_weight.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/add_tofav_exe_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/fav_exercise_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBodyWeightPage extends StatefulWidget {
  final String name;
  const CategoryBodyWeightPage({super.key, required this.name});

  @override
  State<CategoryBodyWeightPage> createState() => _CategoryBodyWeightPageState();
}

class _CategoryBodyWeightPageState extends State<CategoryBodyWeightPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BodyweightCubit>(context).emitExeByType(widget.name);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(widget.name),
      ),
      body: MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => getIt<AddTofavExeCubit>(),
    ),
    BlocProvider(
      create: (context) => getIt<FavExerciseCubit>(),
    ),
  ],
  child: const BlocListBodyWeight(
    showArrowBack: true,
  ),
)
    );
  }
}
