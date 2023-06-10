import 'package:asignease/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Controller globals = new Controller();

class Blue_button extends StatefulWidget {
  String content;
  double? width_here;
  double? height_here;

  Blue_button({required this.content, this.width_here, this.height_here});

  @override
  State<Blue_button> createState() => _Blue_buttonState();
}

class _Blue_buttonState extends State<Blue_button> {
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
        child: Text(
          widget.content,
          style: TextStyle(
            color:Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

