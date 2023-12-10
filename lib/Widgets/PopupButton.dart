import 'package:asignease/Controller.dart';
import 'package:flutter/material.dart';


Controller globals = new Controller();

class Popup_button extends StatelessWidget {
  String content;
  Popup_button({required this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      padding: EdgeInsets.fromLTRB(24, 13, 24, 13),
      decoration: BoxDecoration(
        color: globals.button_purple_shade.withOpacity(0.9),
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
          content,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Urbanist'
          ),
        ),
      ),
    );
  }
}
