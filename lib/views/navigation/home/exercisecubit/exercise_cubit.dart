import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/controllers/dio_helper.dart';
import 'package:flutter_application_1/views/navigation/home/models/products_model_home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit() : super(ExerciseInitial());
  static List<ProductModelHomePage> exercise = [];

  static ExerciseCubit get(context) => BlocProvider.of(context);

  Future<void> getExercises() async {
    emit(ExerciseWaitingState());
    try {
      var res =
          await DioHelper.dio.get('https://api.escuelajs.co/api/v1/products');

      if (res.statusCode == 200) {
        // final response = res.data;
        for (var element in res.data) {
          exercise.add(ProductModelHomePage.fromJson(element));
        }
        emit(ExerciseSuccessState());
      } else {
        emit(ExerciseErrorState());
      }
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzz");
      emit(ExerciseErrorState());
    }
  }
}
