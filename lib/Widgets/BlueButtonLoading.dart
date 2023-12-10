import 'package:asignease/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Controller globals = new Controller();

class Blue_button_Loading extends StatefulWidget {

  double? width_here;
  double? height_here;

  Blue_button_Loading({this.width_here, this.height_here});

  @override
  State<Blue_button_Loading> createState() => _Blue_button_LoadingState();
}

class _Blue_button_LoadingState extends State<Blue_button_Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width_here,
      height: widget.height_here,
      padding: EdgeInsets.fromLTRB(24, 13, 24, 13),
      decoration: BoxDecoration(
        color: globals.button_purple_shade,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(36, 107, 253, 0.25),
            offset: Offset(2, -4),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
          child:  CupertinoActivityIndicator(color: Colors.white,)

      ),
    );
  }
}

