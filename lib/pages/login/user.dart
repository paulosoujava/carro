//class User {
//  String login;
//  String nome;
//  String email;
//  String token;
//  List<String> roles;
//
//  User.fromJson(Map<String, dynamic> map)
//      : this.nome = map["nome"],
//        this.email = map["email"],
//        this.login = map["login"],
//        this.token = map["token"],
//        this.roles = map["roles"] != null
//            ? map["roles"].map<String>((role) => role.toString()).toList()
//            : null;
//
//  //this.roles = getRoles(map);
//
//  static List<String> getRoles(Map<String, dynamic> map) {
//    List list = map["roles"];
//    List<String> roles = [];
//    for (String s in list) {
//      roles.add(s);
//    }
//    return roles;
//  }
//
//  @override
//  String toString() {
//    return 'User{login: $login, nome: $nome, email: $email, token: $token roles $roles}';
//  }
//}
import 'dart:convert';

import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/utils/prefs.dart';

class User {
  int id;
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;
  List<String> roles;

  User(
      {this.id,
      this.login,
      this.nome,
      this.email,
      this.urlFoto,
      this.token,
      this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    nome = json['nome'];
    email = json['email'];
    urlFoto = json['urlFoto'];
    token = json['token'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  void save() {
    Map map = toJson();
    Prefs.setString(TipoCarro.KEY_USER, json.encode(map));
  }

  static Future<User> get() async {
    String j = await Prefs.getString(TipoCarro.KEY_USER);
    if (j.isEmpty) return null;
    Map map = json.decode(j);
    User u = User.fromJson(map);
    return u;
  }

  static clear() {
    Prefs.setString(TipoCarro.KEY_USER, "");
  }

  @override
  String toString() {
    return 'User{id: $id, login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles}';
  }
}
