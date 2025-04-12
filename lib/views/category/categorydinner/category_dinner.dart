import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/views/category/categorybreakfast/data/cubit/meals_cubit.dart';
import 'package:flutter_application_1/views/category/categorybreakfast/widgets/bloc_list_breakfast.dart';
import 'package:flutter_application_1/views/category/categorydinner/data/cubit/dinner_cubit.dart';
import 'package:flutter_application_1/views/category/categorydinner/widgets/bloc_list_dinner.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/add_to_fav_meal_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/fav_meal_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDinnerPage extends StatefulWidget {
  final String name;
  const CategoryDinnerPage({super.key, required this.name});

  @override
  State<CategoryDinnerPage> createState() => _CategoryDinnerPageState();
}

class _CategoryDinnerPageState extends State<CategoryDinnerPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        BlocProvider.of<DinnerCubit>(context).emitMealsByType(widget.name);
      }
    });
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
      create: (context) => getIt<AddToFavMealCubit>(),
    ),
    BlocProvider(
      create: (context) => getIt<FavMealCubit>(),
    ),
    // Add other cubits or blocs if necessary
  ],
  child: const BlocListDinner(
    showArrowBack: true,
  ),
)

    );
  }
}
