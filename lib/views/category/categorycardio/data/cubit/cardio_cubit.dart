import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/category/data/repository/category_repo.dart';
import 'package:meta/meta.dart';

part 'cardio_state.dart';

class CardioCubit extends Cubit<CardioState> {
      final CategoryRepo categoryRepo;
  CardioCubit(this.categoryRepo) : super(CardioInitial());




  void emitExeByType(String categoryType) {
    try {
      categoryRepo.getExeByType(categoryType).then((exeByType) {

        emit(ExeByTypeCardioSuccessState(exeByTypeList: exeByType));
      }).catchError((error) {    
      });
    } catch (e) {
      print("Exception in emitExeByType: $e");
    }
  }
}
