import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String txt;
  var fnc;
  bool showProgress;

  AppButton(this.txt, this.fnc, {this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.lightBlue)),
        color: Colors.blue,
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ))
            : Text(
                txt,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
        onPressed: fnc,
      ),
    );
  }
}
