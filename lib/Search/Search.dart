import 'dart:convert';

import 'package:asignease/Home/Widgets/AllPostContainer.dart';
import 'package:asignease/Search/UserProfile.dart';
import 'package:asignease/Widgets/ProfileCardDark.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var checked = false;
var data;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  fetchPops() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var url = Uri.parse(globals.baseUrl + 'tasks');
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
      var responseData = jsonDecode(response.body);

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
    checked = false;
    fetchPops();
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
                'EssayChains',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Text(
                "Popular Profiles in EssayChains",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Center(
              child: GestureDetector(onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage(
                      name:'Arjun Singh',
                      description: 'Flutter Developer',
                      totalWorks:23,
                      totalDaysWorked: 133,
                      totalRevenueEarned:"₹77,143",
                      pictureUrl:"https://pbs.twimg.com/profile_images/1245775575014428675/6XQss11b_400x400.jpg"
                  )),
                );
              },
                child: Profile_card_dark(
                  height_here: 71.0,
                  width_here: 1.04,
                  mainTitle: 'Arjun Singh',
                  subTitle: 'Flutter Developer',
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            GestureDetector(onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfilePage(
                    name:'Bhargav Shah',
                    description: 'Physics Teacher',
                    totalWorks:43,
                    totalDaysWorked: 13,
                    totalRevenueEarned:"₹32,543",
                    pictureUrl:"https://media.licdn.com/dms/image/C5603AQFNMqO2LqIElA/profile-displayphoto-shrink_800_800/0/1623781577599?e=2147483647&v=beta&t=IELo7ZDojwHqWeJZtzhQyX3JYKQPe14NaFc9EgatyjA"
                )),
              );
            },
              child: Center(
                child: Profile_card_dark(
                  height_here: 71.0,
                  width_here: 1.04,
                  mainTitle: 'Bhargav Shah',
                  subTitle: 'Physics Teacher',
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            GestureDetector(onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfilePage(
                    name:'Manjul Bhargava',
                    description: 'UI/UX Designer',
                    totalWorks:143,
                    totalDaysWorked: 113,
                    totalRevenueEarned:"₹2,543",
                    pictureUrl:"https://upload.wikimedia.org/wikipedia/commons/d/d1/Manjul_Bhargava_FieldsMedal.jpg"
                )),
              );
            },
              child: Center(
                child: Profile_card_dark(
                  height_here: 71.0,
                  width_here: 1.04,
                  mainTitle: 'Manjul Bhargava',
                  subTitle: 'UI/UX Designer',
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            Center(
              child: GestureDetector(onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage(
                      name:'Harish Goud',
                      description: 'Software Engineer',
                      totalWorks:53,
                      totalDaysWorked: 13,
                      totalRevenueEarned:"₹9,543",
                      pictureUrl:"https://media.licdn.com/dms/image/D5603AQFCLrZJ4q3y9A/profile-displayphoto-shrink_800_800/0/1648717861198?e=2147483647&v=beta&t=-d8AWO29VgXQ5F_GqLfZXVhnbIGZvX0c4Sukd20oEQY"
                  )),
                );
              },
                child: Profile_card_dark(
                  height_here: 71.0,
                  width_here: 1.04,
                  mainTitle: 'Harish Goud',
                  subTitle: 'Software Engineer',
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            !checked
                ? Column(
                  children: [
                    SizedBox(height: 150,),
                    Center(
                        child: CupertinoActivityIndicator(),
                      ),
                  ],
                )
                : Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: MyContainer(
                            author: data[index]["user_id"]["name"],
                            task: data[index]['title'],
                            description: data[index]['description'],
                            id: data[index]['_id'],
                            bids: data[index]['bids'].length,
                            budget: data[index]['budget'],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
