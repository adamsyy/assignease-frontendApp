import 'dart:convert';

import 'package:asignease/Controller.dart';
import 'package:asignease/Popup2.dart';
import 'package:asignease/ViewBids/viewBids.dart';
import 'package:asignease/Widgets/ProgressBar.dart';
import 'package:asignease/auth/SignIn.dart';
import 'package:asignease/auth/SignUp.dart';
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
String? name=" ";
String? address=" ";
String? email=" ";


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void checkLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

       email= prefs.getString("email")!;
       address=prefs.getString("address")!;

       name=prefs.getString("name")!;

    });
  }
  fetchPops() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    var url = Uri.parse(Controller().baseUrl + 'tasks/user');
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
    checkLogin();
    fetchPops();
    fetchPops2();
    fetchPops3();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Color(0xFFF5F5F5),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.info_outline_sharp,
              color: Colors.black,
            ),
            onPressed: () {

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
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Card(
            //     child: Container(
            //       color: Color(0xFFF5F5F5),
            //       child: ListTile(
            //         title: Text(
            //           'Display Name',
            //           style: TextStyle(
            //             fontFamily: 'Sora',
            //             fontWeight: FontWeight.bold,
            //             fontSize: 16,
            //           ),
            //         ),
            //         subtitle: Text(
            //     name.toString(),
            //           style: TextStyle(fontSize: 14, fontFamily: 'Urbanist'),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Container(
                  color: Color(0xFFF5F5F5),
                  child: ListTile(
                    title: Text(
                      'Identity',
                      style: TextStyle(
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle:email!=" "?Text(
                   email.toString(),
                      style: TextStyle(fontSize: 14, fontFamily: 'Urbanist'),
                    ):Text(
                      address.toString(),
                      style: TextStyle(fontSize: 14, fontFamily: 'Urbanist'),
                    )
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
checker==false||checker2==false?Column(
  children: [
    SizedBox(height: 250,),
        Center(child: CupertinoActivityIndicator(radius: 15,),),
  ],
)  :Column(mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    checker==false?Center(child: CupertinoActivityIndicator()): data1.length>0? Container(
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
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context) => ViewBids(
                                    task: data1[index]['title'],
                                    description: data1[index]['description'],
                                    id: data1[index]['_id'],
                                    bids: data1[index]['bids'],
                                    status:data1[index]['status'],

                                  )));
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
    ):Container(
      child:  Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text("You havent uploaded any tasks yet",
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Urbanist',
          ),),
      ),
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
    checker2==false?Center(child: CupertinoActivityIndicator()): data2.length>0? Container(
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
                                  'Change status',
                                  style: TextStyle(
                                    color: Color.fromRGBO(36, 107, 253, 1),
                                  ),
                                ),
                                onPressed: () {
                                  // Handle button press
                                  //SHOW A
                                  popup2(context,"You are about to Mark this project as done.",data2[index]["_id"]);
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
    ):Container(
      child:  Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text("You havent been assigned anything yet",
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Urbanist',
          ),),
      ),
    ),
    SizedBox(height: 25,),

    SizedBox(height: 20,),
    Center(
        child: GestureDetector(
          onTap: () async{
            SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.clear();

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
  ],
)
          ]),
        ),
        backgroundColor: Color(0xFFF5F5F5),
      ),
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


