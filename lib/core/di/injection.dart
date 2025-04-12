import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/netwroking/web_services.dart';
import 'package:flutter_application_1/views/Login/data/cubit/login_cubit.dart';
import 'package:flutter_application_1/views/Login/data/repository/login_repo.dart';
import 'package:flutter_application_1/views/Signup/data/cubit/sign_up_cubit.dart';
import 'package:flutter_application_1/views/Signup/data/repository/signup_repo.dart';
import 'package:flutter_application_1/views/category/categorydinner/data/cubit/dinner_cubit.dart';
import 'package:flutter_application_1/views/category/categorylunch/data/cubit/lunch_cubit.dart';
import 'package:flutter_application_1/views/category/categorybreakfast/data/cubit/meals_cubit.dart';
import 'package:flutter_application_1/views/category/data/repository/category_repo.dart';
import 'package:flutter_application_1/views/navigation/exercise/data/fullExerciseCubit/full_exercise_cubit.dart';
import 'package:flutter_application_1/views/navigation/exercise/data/repository/get_all_categories_repo.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/add_to_fav_meal_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/fav_meal_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/repository/add_fav_meal_repo.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/repository/get_fav_meals_repo.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/fav_exercise_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/repository/get_fav_exercise_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerFactory<FullExerciseCubit>(()=> FullExerciseCubit(getIt()));
  getIt.registerFactory<GetAllCategoriesRepo>(()=> GetAllCategoriesRepo(getIt()));
  getIt.registerFactory<FavExerciseCubit>(()=> FavExerciseCubit(getIt()));
  getIt.registerFactory<GetFavExerciseRepo>(()=> GetFavExerciseRepo(getIt()));
  getIt.registerFactory<FavMealCubit>(()=> FavMealCubit(getIt()));
  getIt.registerFactory<GetFavMealsRepo>(()=> GetFavMealsRepo(getIt()));

  getIt.registerFactory<SignUpCubit>(()=> SignUpCubit(getIt()));
  getIt.registerFactory<SignupRepo>(()=> SignupRepo(getIt()));

  getIt.registerFactory<LoginCubit>(()=> LoginCubit(getIt()));
  getIt.registerFactory<LoginRepo>(()=> LoginRepo(getIt()));

  getIt.registerFactory<MealsCubit>(()=> MealsCubit(getIt()));
  getIt.registerFactory<LunchCubit>(()=> LunchCubit(getIt()));
  getIt.registerFactory<DinnerCubit>(()=> DinnerCubit(getIt()));
  getIt.registerFactory<CategoryRepo>(()=> CategoryRepo(getIt()));

  getIt.registerFactory<AddToFavMealCubit>(()=> AddToFavMealCubit(getIt()));
  getIt.registerFactory<AddFavMealRepo>(()=> AddFavMealRepo(getIt()));

  getIt.registerFactory<WebServices>(()=> WebServices(Dio()));
}