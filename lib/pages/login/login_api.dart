import 'dart:convert';

import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/login/api_response.dart';
import 'package:carros/pages/login/user.dart';
import 'package:carros/utils/prefs.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<User>> login(String login, String pass) async {
    var url = 'https://carros-springboot.herokuapp.com/api/v2/login';
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};
      Map params = {'username': login, 'password': pass};
      String s = json.encode(params);
      var response = await http.post(url, body: s, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200)
        {
          User s = User.fromJson(json.decode(response.body));
          s.save();
          return ApiResponse.ok(s);
        }


      return ApiResponse.error(json.decode(response.body)["error"]);
    } catch (err) {
      return ApiResponse.error(("A não, deu pau no servidor..."));
    }
  }
}
