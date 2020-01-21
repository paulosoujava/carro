import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  String errorMsg;

  AppError(this.errorMsg);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMsg,
        style: TextStyle(
          fontSize: 25,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
