import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/Signup/data/models/signup_request_model.dart';
import 'package:flutter_application_1/views/Signup/data/models/signup_response_model.dart';
import 'package:flutter_application_1/views/Signup/data/repository/signup_repo.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignupRepo signupRepo;
  SignUpCubit(this.signupRepo) : super(SignUpInitial());

  void emitCreateNewUSer(SignUpRequestModel signUpRequestModel) {
    try {
      signupRepo.createNewUser(signUpRequestModel).then((signUpRequestModel) {
        emit(CreateNewUSerSuccessState(signUpResponsetModel: signUpRequestModel));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
