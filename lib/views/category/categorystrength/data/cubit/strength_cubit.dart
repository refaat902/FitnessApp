import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/category/data/model/exe_response_model.dart';
import 'package:flutter_application_1/views/category/data/repository/category_repo.dart';
import 'package:meta/meta.dart';

part 'strength_state.dart';

class StrengthCubit extends Cubit<StrengthState> {
          final CategoryRepo categoryRepo;
  StrengthCubit(this.categoryRepo) : super(StrengthInitial());








  void emitExeByType(String mealType) {
    try {
      categoryRepo.getExeByType(mealType).then((exeByType) {
        emit(ExeByTypeStrengthSuccessState(exeByTypeList: exeByType));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
