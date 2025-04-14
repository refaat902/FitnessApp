import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/navigation/profile/data/model/profile_model.dart';
import 'package:flutter_application_1/views/navigation/profile/data/repository/profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  void emitGetProfile() {
    try {
      profileRepo.getProfile().then((profileModel) {
        emit(GetProfileSuccessState(
            profileModel: profileModel));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
