import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/views/category/categorylunch/data/cubit/lunch_cubit.dart';
import 'package:flutter_application_1/views/category/categorylunch/widgets/bloc_list_lunch.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/add_to_fav_meal_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/fav_meal_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryLunchPage extends StatefulWidget {
  final String name;
  const CategoryLunchPage({super.key, required this.name});

  @override
  State<CategoryLunchPage> createState() => _CategoryLunchPageState();
}

class _CategoryLunchPageState extends State<CategoryLunchPage> {
  @override
  void initState() {
    super.initState();
    // Ensure that emitMealsByType is only called when the cubit is alive
    BlocProvider.of<LunchCubit>(context).emitMealsByType(widget.name);
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
  child: const BlocListLunch(
    showArrowBack: true,
    tabIndex: 1,
  ),
)
    );
  }
}
