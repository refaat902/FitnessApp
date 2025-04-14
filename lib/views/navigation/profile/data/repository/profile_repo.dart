import 'package:flutter_application_1/core/helpers/shared_pref_helper.dart';
import 'package:flutter_application_1/core/netwroking/web_services.dart';
import 'package:flutter_application_1/views/navigation/profile/data/model/profile_model.dart';

class ProfileRepo {
      final WebServices webServices;
  ProfileRepo(this.webServices);

  Future<ProfileModel> getProfile() async {
    final token = await SharedPrefService.getToken();
    return await webServices.getProfile('Bearer $token');
  }
}