import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/views/Login/data/model/login_request_model.dart';
import 'package:flutter_application_1/views/Login/data/model/login_response_model.dart';
import 'package:flutter_application_1/views/Login/data/repository/login_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  LoginCubit(this.loginRepo) : super(LoginInitial());

  void emitLogin(LoginRequesttModel loginData) {
    try {
      loginRepo.login(loginData).then((loginData) {
        emit(LoginSuccessState(loginData: loginData));
      });
    } catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
      print(e);
      print("zzzzzzzzzzzzzzzzzzzzzzzz");
    }
  }
}
