import 'dart:convert';

import 'package:asignease/Home/Widgets/AllPostContainer.dart';
import 'package:asignease/Widgets/BlueButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var checked = false;
var data;

class AppDevelopmentPage extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final String id;

  AppDevelopmentPage({
    required this.title,
    required this.description,
    required this.image,
    required this.id,

  });

  @override
  State<AppDevelopmentPage> createState() => _AppDevelopmentPageState();
}

class _AppDevelopmentPageState extends State<AppDevelopmentPage> {
  fetchPops2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var url = Uri.parse(globals.baseUrl + 'categories/${widget.id}');
    //add Bearar token in header
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      setState(() {
        checked = true;
      });
      var responseData = jsonDecode(response.body)['tasks'];

      setState(() {
        data = responseData;
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
    checked=false;
    fetchPops2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    color: Color(0xFFF5F5F5),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(36, 107, 253, 1),
                              fontFamily: 'Sora',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            widget.description,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: 'Sora',
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 50),
                        checked==false?Center(
                          child: CupertinoActivityIndicator()):  Container(
                            height: MediaQuery.of(context).size.height / 1.5,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(

                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Center(
                                      child: MyContainer(
                                        task: data[index]["title"],
                                        description: data[index]["description"],
                                        id: data[index]["_id"],
                                    bids: data[index]["bids"].length,
                                        budget: data[index]["budget"],

                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height /
                                            50),
                                  ],
                                );
                              }),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
