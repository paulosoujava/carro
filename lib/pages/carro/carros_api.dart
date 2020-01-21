import 'dart:convert';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/login/user.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
  static final String KEY_TAB = "tabIdx";
  static final String KEY_USER = "userKey";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    String s = tipo.toString().replaceAll("TipoCarro", "");
    //try {
    User u = await User.get();
    Map<String, String> headers = {
      "Content-Type":"application/json",
      "Authorization":"Bearer ${u.token}"
    };
      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$s';
      var response = await http.get(url, headers: headers);
      List list = json.decode(response.body);
      return list.map<Carro>((map) => Carro.fromJson(map)).toList();
      /*
      final carros = List<Carro>();
      for (Map map in list) {
        Carro c = Carro.fromJson(map);
        carros.add(c);
      }
      return carros;

    } catch (e) {
      print(e);
      throw e;
    }
     */

  }
}
