import 'package:asignease/Controller.dart';
import 'package:asignease/Widgets/PopupButton.dart';
import 'package:flutter/material.dart';

Controller globals = new Controller();

dynamic popup1(BuildContext context,var content){
  return      showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 700,
            width: 400,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Color.fromRGBO(36, 107, 253, 1),
                  width: 1,
                ),
              ),

              content: Text(content,style: TextStyle(
                color: globals.text_darkblue,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),),
              actions: [
                Center(
                  child: GestureDetector(onTap:(){
                    Navigator.of(context).pop();

                  }, child: Popup_button(content: 'Ok')),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}