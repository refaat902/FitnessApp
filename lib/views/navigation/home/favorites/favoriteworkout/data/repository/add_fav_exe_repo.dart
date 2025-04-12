import 'package:flutter_application_1/core/helpers/shared_pref_helper.dart';
import 'package:flutter_application_1/core/netwroking/web_services.dart';

class AddFavExeRepo {
        final WebServices webServices;
  AddFavExeRepo(this.webServices);

  Future<void> addToFavExe(String id) async {
    return await webServices.addToFavExe(id,'Bearer ${await SharedPrefService.getToken()}');
  }

    Future<void> deleteFavExe(String id) async {
    return await webServices.deleteFavExe(id,'Bearer ${await SharedPrefService.getToken()}');
  }
}