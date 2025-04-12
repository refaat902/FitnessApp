import 'package:flutter_application_1/core/netwroking/web_services.dart';
import 'package:flutter_application_1/views/Login/data/model/login_request_model.dart';
import 'package:flutter_application_1/views/Login/data/model/login_response_model.dart';

class LoginRepo {
      final WebServices webServices;
  LoginRepo(this.webServices);

  Future<LoginResponsetModel> login(LoginRequesttModel loginData) async {
    return await webServices.login(loginData);
  }
}