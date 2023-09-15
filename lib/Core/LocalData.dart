
import 'package:project_cleanarchiteture/Utils/Extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin class LocalData
{
  Future setUserinfo(String userdata) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_INFO, userdata);
  }

  Future<String> getUserinfo(String user_info) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_INFO) ?? "";
  }


}