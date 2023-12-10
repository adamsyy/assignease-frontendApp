import 'package:asignease/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Controller globals = new Controller();

class Blue_button extends StatefulWidget {
  var isweb3;
  String content;
  double? width_here;
  double? height_here;

  Blue_button({required this.content, this.width_here, this.height_here,this.isweb3});

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
        color: widget.content!="Sign in with Metamask"&&widget.content!="Sign up with Metamask"? globals.button_purple_shade:globals.text_lightgrey,
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

