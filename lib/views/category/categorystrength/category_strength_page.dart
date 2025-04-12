import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/views/category/categorystrength/data/cubit/strength_cubit.dart';
import 'package:flutter_application_1/views/category/categorystrength/widget/bloc_list_strength.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/add_tofav_exe_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/fav_exercise_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryStrengthPage extends StatefulWidget {
  final String name;
  const CategoryStrengthPage({super.key, required this.name});

  @override
  State<CategoryStrengthPage> createState() => _CategoryStrengthPageState();
}

class _CategoryStrengthPageState extends State<CategoryStrengthPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StrengthCubit>(context).emitExeByType(widget.name);
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
  child: const BlocListStrength(
    showArrowBack: true,
  ),
)
    );
  }
}
