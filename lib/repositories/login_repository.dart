import 'package:miracle_ova/utils/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  
  login() {
    var dio = CustomDio().instance;

    dio.post('http://192.168.1.11:3000/login', data: {
      'username': 'user',
      'password': 'password'
    }).then((res) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', res.data['token']);
    }).catchError((error) {
      throw Exception('Username or password not valid.'); 
    });
  }

}