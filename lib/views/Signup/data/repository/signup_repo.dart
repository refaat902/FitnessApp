import 'package:flutter_application_1/core/netwroking/web_services.dart';
import 'package:flutter_application_1/views/Signup/data/models/signup_request_model.dart';
import 'package:flutter_application_1/views/Signup/data/models/signup_response_model.dart';

class SignupRepo {
    final WebServices webServices;
  SignupRepo(this.webServices);

  Future<SignUpResponsetModel> createNewUser(SignUpRequestModel signUpRequest) async {
    return await webServices.createNewUser(signUpRequest);
  }
}