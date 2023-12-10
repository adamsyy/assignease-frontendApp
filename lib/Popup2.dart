import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asignease/Controller.dart';
import 'package:asignease/Widgets/PopupButton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Controller globals = new Controller();

dynamic popup2(BuildContext context,var content,var id){
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
                Row(
                  children: [
                    Center(
                      child: GestureDetector(onTap:(){
                        approveReq(id,context);

                      }, child: Popup_button(content: 'Confirm')),
                    ),
                    SizedBox(width: 15,),
                    Center(
                      child: GestureDetector(onTap:(){
                        Navigator.of(context).pop();

                      }, child: Popup_button(content: 'Decline')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

}
approveReq(id,context)async{
  Controller globals = new Controller();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  var url = Uri.parse(globals.baseUrl + 'tasks/complete');

  var header={
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  var body = jsonEncode({
    "task_id":id



  });
  var response = await http.post(url, headers: header, body: body);
  print(response.body);
  print(response.statusCode);
  if(response.statusCode==200){
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task marked as completed')));
  }
  else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unable to mark as done.')));
    print(response.body);
    print(response.statusCode);
  }



}