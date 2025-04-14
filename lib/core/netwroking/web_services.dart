import 'package:dio/dio.dart';
import 'package:flutter_application_1/views/Login/data/model/login_request_model.dart';
import 'package:flutter_application_1/views/Login/data/model/login_response_model.dart';
import 'package:flutter_application_1/views/Signup/data/models/signup_request_model.dart';
import 'package:flutter_application_1/views/Signup/data/models/signup_response_model.dart';
import 'package:flutter_application_1/views/aimeal/data/model/ai_meal_request_model.dart';
import 'package:flutter_application_1/views/aimeal/data/model/ai_meal_response_model.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/category/data/model/meals_response_model.dart';
import 'package:flutter_application_1/views/navigation/profile/data/model/profile_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'web_services.g.dart';

@RestApi(baseUrl: "https://fitness-app-api-580642313220.us-central1.run.app/")
abstract class WebServices {
  factory WebServices(Dio dio, {String baseUrl}) = _WebServices;

  // @GET('api/Exercise')
  // Future<List<ExerciseModel>> getAllExercise();


  @GET('api/Favorites/exercises')
  Future<List<ExeResponseModel>> getFavoritesExercise(@Header('Authorization') String? token);

  @GET('/api/User/profile')
  Future<ProfileModel> getProfile(@Header('Authorization') String? token);

  @GET('api/Favorites/meals')
  Future<List<MealsResponseModel>> getFavoritesMeal(@Header('Authorization') String? token);

  @POST('/api/Auth/register')
  Future<SignUpResponsetModel> createNewUser(@Body() SignUpRequestModel signUpRequestModel);


  @POST('/api/Auth/login')
  Future<LoginResponsetModel> login(@Body() LoginRequesttModel loginData);

  @POST('https://fitapp-497248763586.us-central1.run.app/api/predict')
  Future<AiMealResponsetModel> getAiMeals(@Body() AiMealRequestModel requestData);

  @GET('/api/Meal/byMealType/{mealType}')
  Future<List<MealsResponseModel>> getMeals(@Path() String mealType,@Header('Authorization') String? token);

  @GET('/api/Exercise/muscleGroup/{group}')
  Future<List<ExeResponseModel>> getExeByMusleGroup(@Path() String group,@Header('Authorization') String? token);

  @GET('/api/Exercise/category/{category}')
  Future<List<ExeResponseModel>> getExe(@Path() String category,@Header('Authorization') String? token);

  @POST('/api/Favorites/meals/{id}')
  Future<void> addToFavMeal(@Path() String id,@Header('Authorization') String? token);

  @DELETE('/api/Favorites/meals/{id}')
  Future<void> deleteFavMeal(@Path() String id,@Header('Authorization') String? token);

  @POST('/api/Favorites/exercises/{id}')
  Future<void> addToFavExe(@Path() String id,@Header('Authorization') String? token);

  @DELETE('/api/Favorites/exercises/{id}')
  Future<void> deleteFavExe(@Path() String id,@Header('Authorization') String? token);
}
