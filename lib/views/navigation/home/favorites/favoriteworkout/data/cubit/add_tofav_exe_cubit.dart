import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/navigation/home/favorites/favoriteworkout/data/repository/add_fav_exe_repo.dart';
import 'package:meta/meta.dart';

part 'add_tofav_exe_state.dart';

class AddTofavExeCubit extends Cubit<AddTofavExeState> {
          final AddFavExeRepo addFavExeRepo;
  AddTofavExeCubit(this.addFavExeRepo) : super(AddTofavExeInitial());






  void emitAddToFavExe(String id) {
    try {
      addFavExeRepo.addToFavExe(id).then((addToFavMeal) {
        emit(AddToFavExeSuccessState());
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }

    void emitDeleteFavExe(String id) {
    try {
      addFavExeRepo.deleteFavExe(id).then((addToFavMeal) {
        emit(DeleteFavExeSuccessState());
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
