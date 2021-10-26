import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future save_data(String number) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("number", number);
  }

  Future read_data(String code) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var return_no = _preferences.getString(code);
    return return_no;
  }
}
