import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  FormFieldValidator<String> validator;
  TextEditingController controller;
  bool pass;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;
  String txt;
  String hint;


  AppText(this.hint,
      this.txt, {
        this.validator,
        this.controller,
        this.pass = false,
        this.keyboardType,
        this.textInputAction,
        this.focusNode,
        this.nextFocus,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: pass,
      cursorColor: Colors.blue,
      keyboardType: keyboardType,
      keyboardAppearance: Brightness.light,
      textInputAction: textInputAction,
      onFieldSubmitted: (String txt) {
        if (nextFocus != null) FocusScope.of(context).requestFocus(focusNode);
      },
      focusNode: focusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelText: txt,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.blue),
        labelStyle: TextStyle(color: Colors.blue),
      ),
      style: TextStyle(
        fontSize: 20,
        color: Colors.blue,
      ),
    );
  }
}
