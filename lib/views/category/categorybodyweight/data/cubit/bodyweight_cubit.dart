import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/category/data/repository/category_repo.dart';
import 'package:meta/meta.dart';

part 'bodyweight_state.dart';

class BodyweightCubit extends Cubit<BodyweightState> {
    final CategoryRepo categoryRepo;
  BodyweightCubit(this.categoryRepo) : super(BodyweightInitial());



  void emitExeByType(String categoryType) {
    try {
      categoryRepo.getExeByType(categoryType).then((exeByType) {

        emit(ExeByTypeBodyWeightSuccessState(exeByTypeList: exeByType));
      }).catchError((error) {    
      });
    } catch (e) {
      print("Exception in emitExeByType: $e");
    }
  }
}
