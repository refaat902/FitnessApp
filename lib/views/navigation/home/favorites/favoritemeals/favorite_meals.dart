import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/data/model/meals_response_model.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/fav_meal_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteMeals extends StatefulWidget {
  const FavoriteMeals({super.key});

  @override
  State<FavoriteMeals> createState() => _FavoriteMealsState();
}

class _FavoriteMealsState extends State<FavoriteMeals> {
  List<MealsResponseModel> favMeals = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavMealCubit>(context).emitGetFavMeal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavMealCubit, FavMealState>(
      builder: (context, state) {
        if (state is FavMealSuccessState) {
          favMeals = state.favMealList;
          return ListView.builder(
            itemCount: favMeals.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.black,
                child: ListTile(
                  title: Text(
                    favMeals[index].name.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 18,color: Colors.white),
                  ),
                  subtitle: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*.02,vertical: MediaQuery.sizeOf(context).height*.02),
                    child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.2), // Optional: Adds subtle shadow
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // Changes position of shadow
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              state.favMealList[index].imageUrl ?? 'assets/images/loading.png',
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  ),
                ),
              );
            },
          );
        } else {
          return const ShimmerListTile();
        }
      },
    )
    );
  }
}
