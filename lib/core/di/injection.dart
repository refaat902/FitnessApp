import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/netwroking/web_services.dart';
import 'package:flutter_application_1/views/Login/data/cubit/login_cubit.dart';
import 'package:flutter_application_1/views/Login/data/repository/login_repo.dart';
import 'package:flutter_application_1/views/Signup/data/cubit/sign_up_cubit.dart';
import 'package:flutter_application_1/views/Signup/data/repository/signup_repo.dart';
import 'package:flutter_application_1/views/aimeal/data/cubit/ai_meal_cubit.dart';
import 'package:flutter_application_1/views/aimeal/data/repository/ai_meal_repo.dart';
import 'package:flutter_application_1/views/category/categorybodyweight/data/cubit/bodyweight_cubit.dart';
import 'package:flutter_application_1/views/category/categorycardio/data/cubit/cardio_cubit.dart';
import 'package:flutter_application_1/views/category/categorydinner/data/cubit/dinner_cubit.dart';
import 'package:flutter_application_1/views/category/categorylunch/data/cubit/lunch_cubit.dart';
import 'package:flutter_application_1/views/category/categorybreakfast/data/cubit/meals_cubit.dart';
import 'package:flutter_application_1/views/category/categorystrength/data/cubit/strength_cubit.dart';
import 'package:flutter_application_1/views/category/data/repository/category_repo.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/add_to_fav_meal_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/cubit/fav_meal_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/repository/add_fav_meal_repo.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoritemeals/data/repository/get_fav_meals_repo.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/add_tofav_exe_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/cubit/fav_exercise_cubit.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/repository/add_fav_exe_repo.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/repository/get_fav_exercise_repo.dart';
import 'package:flutter_application_1/views/navigation/profile/data/cubit/profile_cubit.dart';
import 'package:flutter_application_1/views/navigation/profile/data/repository/profile_repo.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/back_cubit.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/chest_cubit.dart';
import 'package:flutter_application_1/views/startexe/data/cubit/legs_cubit.dart';
import 'package:flutter_application_1/views/startexe/data/repository/get_exe_by_muscle_group_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  // getIt.registerFactory<FullExerciseCubit>(()=> FullExerciseCubit(getIt()));
  // getIt.registerFactory<GetAllCategoriesRepo>(()=> GetAllCategoriesRepo(getIt()));
  getIt.registerFactory<FavExerciseCubit>(()=> FavExerciseCubit(getIt()));
  getIt.registerFactory<GetFavExerciseRepo>(()=> GetFavExerciseRepo(getIt()));
  getIt.registerFactory<FavMealCubit>(()=> FavMealCubit(getIt()));
  getIt.registerFactory<GetFavMealsRepo>(()=> GetFavMealsRepo(getIt()));

  getIt.registerFactory<SignUpCubit>(()=> SignUpCubit(getIt()));
  getIt.registerFactory<SignupRepo>(()=> SignupRepo(getIt()));

  getIt.registerFactory<LoginCubit>(()=> LoginCubit(getIt()));
  getIt.registerFactory<LoginRepo>(()=> LoginRepo(getIt()));

  getIt.registerFactory<ProfileCubit>(()=> ProfileCubit(getIt()));
  getIt.registerFactory<ProfileRepo>(()=> ProfileRepo(getIt()));

  getIt.registerFactory<MealsCubit>(()=> MealsCubit(getIt()));
  getIt.registerFactory<LunchCubit>(()=> LunchCubit(getIt()));
  getIt.registerFactory<DinnerCubit>(()=> DinnerCubit(getIt()));
  getIt.registerFactory<StrengthCubit>(()=> StrengthCubit(getIt()));
  getIt.registerFactory<CardioCubit>(()=> CardioCubit(getIt()));
   getIt.registerFactory<BodyweightCubit>(()=> BodyweightCubit(getIt()));
  getIt.registerFactory<CategoryRepo>(()=> CategoryRepo(getIt()));

  getIt.registerFactory<AddToFavMealCubit>(()=> AddToFavMealCubit(getIt()));
  getIt.registerFactory<AddFavMealRepo>(()=> AddFavMealRepo(getIt()));

  getIt.registerFactory<AddTofavExeCubit>(()=> AddTofavExeCubit(getIt()));
  getIt.registerFactory<AddFavExeRepo>(()=> AddFavExeRepo(getIt()));

  getIt.registerFactory<AiMealCubit>(()=> AiMealCubit(getIt()));
  getIt.registerFactory<AiMealRepo>(()=> AiMealRepo(getIt()));

  getIt.registerFactory<ChestCubit>(()=> ChestCubit(getIt()));
  getIt.registerFactory<BackCubit>(()=> BackCubit(getIt()));
  getIt.registerFactory<LegsCubit>(()=> LegsCubit(getIt()));
  getIt.registerFactory<GetExeByMuscleGroupRepo>(()=> GetExeByMuscleGroupRepo(getIt()));

  getIt.registerFactory<WebServices>(()=> WebServices(Dio()));
}