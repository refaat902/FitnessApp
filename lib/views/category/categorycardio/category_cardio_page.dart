import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/views/category/categorycardio/data/cubit/cardio_cubit.dart';
import 'package:flutter_application_1/views/category/categorycardio/widgets/bloc_list_cardio.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/add_tofav_exe_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/fav_exercise_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCardioPage extends StatefulWidget {
  final String name;
  const CategoryCardioPage({super.key, required this.name});

  @override
  State<CategoryCardioPage> createState() => _CategoryCardioPageState();
}

class _CategoryCardioPageState extends State<CategoryCardioPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CardioCubit>(context).emitExeByType(widget.name);
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
  child: const BlocListCardio(
    showArrowBack: true,
  ),
)
    );
  }
}
