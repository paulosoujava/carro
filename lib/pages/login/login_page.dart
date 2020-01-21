import 'dart:async';

import 'package:carros/pages/login/api_response.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/user.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_alert.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _tLogin = TextEditingController();

  var _tSenha = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    Future<User> future = User.get();
    future.then((User u) {
      if (u != null) {
        push(context, HomePage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "digite o login",
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(
              height: 20,
            ),
            AppText(
              "Senha",
              "digite a senha",
              pass: true,
              controller: _tSenha,
              validator: _validatePass,
              keyboardType: TextInputType.number,
              focusNode: _focusSenha,
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<bool>(
              stream: _bloc.stream,
              initialData: false,
              builder: (context, snapshot) {
                return AppButton("Acessar", _onClick, showProgress: snapshot.data );
              }
            ),
          ],
        ),
      ),
    );
  }


  _onClick() async {
    if (_formKey.currentState.validate()) {
      ApiResponse response = await _bloc.login(_tLogin.text, _tSenha.text);
      if (response.ok) {
        push(context, HomePage(), replace: true);
      } else {
        alert(context, "Opss", response.errorMessage);
      }
    }
  }

  String _validatePass(String value) {
    if (value.isEmpty) {
      return "digite a senha";
    } else if (value.length < 2) {
      return "senha inválida";
    } else {
      return null;
    }
  }

  String _validateLogin(String value) {
    if (value.isEmpty) {
      return "digite o login";
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
