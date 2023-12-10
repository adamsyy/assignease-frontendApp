import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:asignease/Controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var amount_user;
var message_user;
class TaskInfo extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final String postedBy;
   var budget;
  final int numBidders;
  final bool isPopularTask;
   var id;

  TaskInfo({
    required this.title,
    required this.description,
    required this.image,
    required this.postedBy,
    required this.budget,
    required this.numBidders,
    required this.isPopularTask,
     this.id,
  });

  @override
  _TaskInfoState createState() => _TaskInfoState();
}

class _TaskInfoState extends State<TaskInfo> {
  bool isPopupShown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPopupShown = !isPopupShown;
        });
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Color(0xFFF5F5F5),
            appBar: AppBar(            backgroundColor: Color(0xFFF5F5F5),
              title: Text('Task Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w900,
                  )),
            ),
            body: SingleChildScrollView(scrollDirection: Axis.vertical,
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
                    height: 650,
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
                            child: SingleChildScrollView(scrollDirection: Axis.vertical,
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
                                  Row(
                                    children: [
                                      Text(
                                        'Posted By:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        ' ${widget.postedBy}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        'Budget:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '₹${widget.budget}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.people),
                                      SizedBox(width: 5),
                                      Row(
                                        children: [
                                          Text(
                                            'Number of Bidders:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Text(
                                            ' ${widget.numBidders}',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w900,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Description:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(36, 107, 253, 1),
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    widget.description,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontFamily: 'Sora',
                                    ),
                                  ),
                                  SizedBox(height: 20),
                               !widget.isPopularTask?   GestureDetector(
                                 onTap: () {
                                   setState(() {
                                     isPopupShown = true;
                                   });
                                 },
                                 child: Container(
                                   width: double.infinity,
                                   padding: EdgeInsets.symmetric(vertical: 12),
                                   alignment: Alignment.center,
                                   decoration: BoxDecoration(
                                     color: Color.fromRGBO(36, 107, 253, 1),
                                     borderRadius: BorderRadius.circular(10),
                                   ),
                                   child: Text(
                                     'Bid Now',
                                     style: TextStyle(
                                       fontSize: 18,
                                       fontWeight: FontWeight.bold,
                                       color: Colors.white,
                                     ),
                                   ),
                                 ),
                               ):Container(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isPopupShown)
            // Blur background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          if (isPopupShown)
            // Popup
            Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 300,
                  height: 300,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:  Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(
                        20), // Rounded border with radius 20
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // Adds a shadow effect
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bid your amount',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sora',
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        onChanged: (value) {
                          amount_user = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Amount in rs',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (value) {
                          message_user = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Your message',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Urbanist',
                          ),

                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(36, 107, 253, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Rounded button with radius 10
                            ),
                          ),
                          onPressed: () async{
                            // TODO: Handle button click
                            var url = Uri.parse(Controller().baseUrl + 'tasks/bid');
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            String? token = prefs.getString('token');
                            var headers = {
                              'Content-Type': 'application/json',
                              'Accept': 'application/json',
                              'Authorization': 'Bearer $token',
                            };

                            var body = jsonEncode({
                           "bid_amount":amount_user,
                              "task_id":widget.id,
"bid_message":message_user
                            });
                            var response = await http.post(url, headers: headers, body: body);
                            if(response.statusCode==200){
                              var data = jsonDecode(response.body);
                              print(data);
                              setState(() {
                                isPopupShown = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bid placed successfully')));
                            }
                            else{
                              setState(() {
                                isPopupShown = false;
                              });
                              print(response.body);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong')));
                            }

                          },
                          child: Text(
                            'Bid now',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Sora',

                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
