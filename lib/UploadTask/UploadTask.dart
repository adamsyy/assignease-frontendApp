import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:asignease/Controller.dart';
import 'package:asignease/Popup.dart';
import 'package:asignease/Widgets/BlueButton.dart';
import 'package:asignease/Widgets/BlueButtonLoading.dart';
import 'package:asignease/auth/SignUp.dart';
import 'package:asignease/auth/Widgets/AuthField.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


var title;
var description;
var budget;
var category;

bool checker=false;
Controller globals = new Controller();

class UploadTask extends StatefulWidget {
  @override
  State<UploadTask> createState() => _UploadTaskState();
}

class _UploadTaskState extends State<UploadTask> {
  List<String> categories = [
    'Web development',
    'App development',
    'Tutoring',
    'Assignment',
    'Graphic Design',
    'Other'
  ];

  String? selectedCategory;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
checker=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globals.background_color,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.network(
                "https://gingersauce.co/wp-content/uploads/2020/09/image14.png",
                width: 60,
              ),
              // Add some spacing between the logo and text
              Text(
                'Assignease',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Urbanist',
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 12),
                child: Text(
                  "Post your task!",
                  style: TextStyle(
                      color: globals.text_lightgrey,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      fontFamily: 'Urbanist'),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                  child: Authfield(
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                    hint: 'Title',
                  )),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: Authfield(
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                    hint: 'description',
                  )),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: Authfield(
                    onChanged: (value) {
                      setState(() {
                        budget = value;
                      });
                    },
                    hint: 'budget',
                  )),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: DropdownButton<String>(
                  hint: Text(
                    'Select Category',
                    style: TextStyle(
                      color: globals.text_lightgrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items: categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          value,
                          style: TextStyle(
                            color: globals.text_darkblue,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 25,
              ),

              SizedBox(
                height: 25,
              ),
              Center(
                  child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          checker = true;
                        });
                        postTask();


                        //do requuest here
                      },
                      child: checker == false
                          ?Blue_button(
                        content: 'Post',
                        width_here: 315,
                      )
                          :Blue_button_Loading(
                        width_here: 315,
                      ))),
              SizedBox(
                height: 15,
              ),

              SizedBox(
                height: 14,
              ),
              // Center(
              //   child: GestureDetector(onTap: ()async{
              //     await googleSigninHandler.googleSignhandler();
              //   },
              //     child: Socialauth(
              //       content: 'Google',
              //       iconhere: FontAwesomeIcons.google,
              //     ),
              //   ),
              // ),
              SizedBox(
                width: 15,
              ),

            ],
          ),
        ),
      ),
    );
  }

  postTask()async {
    if (title == null || description == null || budget == null ||
        selectedCategory == null) {
      popup1(context, "Please fill all the fields");
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var url = Uri.parse(globals.baseUrl + 'tasks');

      var header={
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var category_id;
if(selectedCategory=='Web development'){
  category_id="64848bd93968f36bc53da20a";
}
else if(selectedCategory=='App development'){
  category_id="64848d393968f36bc53da20c";
}
else if(selectedCategory=='Tutoring'){
  category_id="648480e1c36d80c9d99866e2";
}
else if(selectedCategory=='Assignment'){
  category_id="64848dec3968f36bc53da20d";
}
else if(selectedCategory=='Graphic Design'){
  category_id="64848e203968f36bc53da20e";
}
else if(selectedCategory=='Other'){
  category_id=6;
}
      var body = jsonEncode({
        "title": title,
        "description": description,
        "budget": budget,
"category_id":category_id,


      });
      var response = await http.post(url, headers: header, body: body);
      if(response.statusCode==201){
        setState(() {
          checker=false;
        });
        popup1(context, "Task posted successfully");
      }
      else{
        setState(() {
          checker=false;
        });
        popup1(context, "Something went wrong");
        print(response.body);
        print(response.statusCode);
      }

    }
  }
}
