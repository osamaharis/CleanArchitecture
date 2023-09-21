
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/entities/AdminSignInResponse.dart';
import 'package:project_cleanarchiteture/Utils/Extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin class LocalData
{
  Future setUserinfo(String userdata) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_INFO, userdata);
    print(userdata);
  }

  Future getUserinfo(String userdata) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_INFO);
  }


}