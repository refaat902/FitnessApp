import 'package:flutter_application_1/core/netwroking/web_services.dart';
import 'package:flutter_application_1/views/navigation/exercise/data/models/exercise_model.dart';

class GetAllCategoriesRepo {
  final WebServices webServices;
  GetAllCategoriesRepo(this.webServices);

  Future<List<ExerciseModel>> getAllExercise() async {
    return await webServices.getAllExercise();
  }
}
