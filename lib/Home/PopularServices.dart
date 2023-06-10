import 'dart:convert';

import 'package:asignease/Controller.dart';
import 'package:asignease/Search/Appdevpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
var checked = false;
var data;
Controller globals = new Controller();
class PopularServices extends StatefulWidget {
  const PopularServices({Key? key}) : super(key: key);

  @override
  State<PopularServices> createState() => _PopularServicesState();
}

class _PopularServicesState extends State<PopularServices> {
  fetchPops() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var url = Uri.parse(globals.baseUrl + 'categories');
    //add Bearar token in header
    var header={
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url,headers: header);
    if (response.statusCode == 200) {
      setState(() {
        checked = true;
      });
      var responseData = jsonDecode(response.body);

   setState(() {
      data=responseData;
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
    fetchPops();
  }
  @override
  Widget build(BuildContext context) {
    return   checked==false?Center(child: CupertinoActivityIndicator(

    ),):
    Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "Popular Services",
                style: TextStyle(
                  color: Color.fromRGBO(36, 107, 253, 1),
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppDevelopmentPage(

                            title: data[index]['name'],
                            description: data[index]['description'],
                            image: data[index]['image'],
                            id: data[index]['_id'].toString(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Image.asset("pictures/${index + 1}.png"),
                        SizedBox(width: 10),
                        Text(
                          data[index]['name'],
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )






        ],
      ),
    );
  }


}
