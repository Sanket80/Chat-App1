import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  static init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  static late final SharedPreferences _prefs;

  Future<void> loginUser(String userName) async{
    try {
      _prefs.setString("username", userName);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isLoggedIn() async{
    String? username = await _prefs.getString("username");
    if(username == null){
      return false;
    }
    return true;
  }

  void logoutUser(){
    _prefs.clear();
  }

  String? getUserName(){
    return _prefs.getString("username") ?? "Default User";
  }
}