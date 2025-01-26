import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/controllers/dio_helper.dart';
import 'package:flutter_application_1/views/navigation/home/models/products_model_home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  MealsCubit() : super(MealsInitial());

  static List<ProductModelHomePage> meals = [];

  static MealsCubit get(context) => BlocProvider.of(context);

  Future<void> getMeals() async {
    emit(MealsWaitingState());
    try {
      var res =
          await DioHelper.dio.get('https://api.escuelajs.co/api/v1/products');

      if (res.statusCode == 200) {
        // final response = res.data;
        for (var element in res.data) {
          meals.add(ProductModelHomePage.fromJson(element));
        }
        emit(MealsSuccessState());
      } else {
        emit(MealsErrorState());
      }
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzz");
      emit(MealsErrorState());
    }
  }
}
