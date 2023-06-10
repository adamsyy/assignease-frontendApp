import 'dart:convert';

import 'package:asignease/Controller.dart';
import 'package:asignease/Widgets/ProgressBar.dart';
import 'package:asignease/auth/SignIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
var checker = false;
var checker2 = false;
var checker3 = false;
var data1;
var data2;
var data3;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  fetchPops() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? id = prefs.getString('_id');
    var url = Uri.parse(Controller().baseUrl + 'tasks/$id');
    //add Bearar token in header
    var header={
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url,headers: header);
    if (response.statusCode == 200) {
      setState(() {
        checker = true;
      });
      var responseData = jsonDecode(response.body);

      setState(() {
        data1=responseData;
      });


      print(responseData);

    } else {
      print(response.body);
    }

  }
  fetchPops2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? id = prefs.getString('_id');
    var url = Uri.parse(Controller().baseUrl + 'tasks/assigned');
    //add Bearar token in header
    var header={
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url,headers: header);
    if (response.statusCode == 200) {
      setState(() {
        checker2= true;
      });
      var responseData = jsonDecode(response.body);

      setState(() {
        data2=responseData;
      });


      print(responseData);

    } else {
      print(response.body);
    }

  }
  fetchPops3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var url = Uri.parse(Controller().baseUrl + 'tasks/bidded');
    //add Bearar token in header
    var header={
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url,headers: header);
    if (response.statusCode == 200) {
      setState(() {
        checker3= true;
      });
      var responseData = jsonDecode(response.body);

      setState(() {
        data3=responseData;
      });


      print(responseData);

    } else {
      print(response.body);
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checker=false;
    checker2=false;
    checker3=false;
    fetchPops();
    fetchPops2();
    fetchPops3();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Profile',
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
      body: SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "Welcome back, User!",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Sora',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
            child: Text(
              "Here you can see your profile information.",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Sora',
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
          //DISPLAY NAME ETC AS CARDS
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Container(
                color: Color(0xFFF5F5F5),
                child: ListTile(
                  title: Text(
                    'Display Name',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    'John Doe',
                    style: TextStyle(fontSize: 14, fontFamily: 'Urbanist'),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Container(
                color: Color(0xFFF5F5F5),
                child: ListTile(
                  title: Text(
                    'Display Name',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    'John Doe',
                    style: TextStyle(fontSize: 14, fontFamily: 'Urbanist'),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Text(
              "All Your Uploaded Tasks",
              style: TextStyle(
                color: Color.fromRGBO(36, 107, 253, 1),
                fontFamily: 'Sora',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
 checker==false?Center(child: CupertinoActivityIndicator()): Container(
   height: 150,
   width: MediaQuery.of(context).size.width,
   child: ListView.builder(itemCount: data1.length,
         itemBuilder: (context, index) {
           return       Padding(
             padding: const EdgeInsets.all(10.0),
             child: Card(
               child: Container(
                 color: Color(0xFFF5F5F5),
                 child: Column(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Expanded(
                           child: ListTile(
                             title: Text(
                               data1[index]['title'],
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 16,
                                 fontFamily: 'Sora',
                               ),
                             ),
                             subtitle: Text(
                            "Status:"+findStatus(data1[index]['status']),
                               style: TextStyle(
                                 fontSize: 14,
                                 fontFamily: 'Urbanist',
                               ),
                             ),
                           ),
                         ),
                         ButtonBar(
                           children: [
                             TextButton(
                               child: Text(
                                 'Enquire',
                                 style: TextStyle(
                                   color: Color.fromRGBO(36, 107, 253, 1),
                                 ),
                               ),
                               onPressed: () {
                                 // Handle button press
                               },
                             ),
                           ],
                         ),
                       ],
                     ),
                     SizedBox(
                         height:
                         10), // Add some spacing between the subtitle and ProgressBarPost
                     ProgressBarPost(
                       width_here: 0.0,
                     ),
                     SizedBox(
                         height:
                         10), // Add some spacing between the ProgressBarPost and ButtonBar
                   ],
                 ),
               ),
             ),
           );
         }),
 ),
          SizedBox(height: 25,),
          Padding(
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Text(
              "Tasks you have been assigned to",
              style: TextStyle(
                color: Color.fromRGBO(36, 107, 253, 1),
                fontFamily: 'Sora',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          checker2==false?Center(child: CupertinoActivityIndicator()): Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(itemCount: data2.length,
                itemBuilder: (context, index) {
                  return       Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Container(
                        color: Color(0xFFF5F5F5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      data2[index]['title'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'Sora',
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Status:"+findStatus(data2[index]['status']),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Urbanist',
                                      ),
                                    ),
                                  ),
                                ),
                                ButtonBar(
                                  children: [
                                    TextButton(
                                      child: Text(
                                        'Enquire',
                                        style: TextStyle(
                                          color: Color.fromRGBO(36, 107, 253, 1),
                                        ),
                                      ),
                                      onPressed: () {
                                        // Handle button press
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                10), // Add some spacing between the subtitle and ProgressBarPost
                            ProgressBarPost(
                              width_here: 0.0,
                            ),
                            SizedBox(
                                height:
                                10), // Add some spacing between the ProgressBarPost and ButtonBar
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
SizedBox(height: 25,),
          Padding(
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Text(
              "Tasks you have bidded",
              style: TextStyle(
                color: Color.fromRGBO(36, 107, 253, 1),
                fontFamily: 'Sora',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          checker3==false?Center(child: CupertinoActivityIndicator()): Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(itemCount: data3.length,
                itemBuilder: (context, index) {
                  return       Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Container(
                        color: Color(0xFFF5F5F5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      data3[index]['title'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'Sora',
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Status:"+findStatus(data3[index]['status']),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Urbanist',
                                      ),
                                    ),
                                  ),
                                ),
                                ButtonBar(
                                  children: [
                                    TextButton(
                                      child: Text(
                                        'Enquire',
                                        style: TextStyle(
                                          color: Color.fromRGBO(36, 107, 253, 1),
                                        ),
                                      ),
                                      onPressed: () {
                                        // Handle button press
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                10), // Add some spacing between the subtitle and ProgressBarPost
                            ProgressBarPost(
                              width_here: 0.0,
                            ),
                            SizedBox(
                                height:
                                10), // Add some spacing between the ProgressBarPost and ButtonBar
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Center(
              child: GestureDetector(
            onTap: () {
              SharedPreferences.getInstance().then((value) {
                value.remove('email');
                value.remove('password');
                value.remove('name');
                value.remove('phone');
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signin2()),
              );
            },
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.85),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text("Logout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          )),
          SizedBox(height: 20),
        ]),
      ),
      backgroundColor: Color(0xFFF5F5F5),
    );
  }
  dynamic findStatus(String status){
if(status=="open") {
  return "Yet to be assigned";

}else{
  return "Assigned";
}
  }
}
