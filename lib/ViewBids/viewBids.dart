import 'dart:convert';
import 'package:asignease/Popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:asignease/BottomNavBar/BottomNavBar.dart';
import 'package:asignease/Controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
var checker=false;
var checkerNew=false;
var data;
class ViewBids extends StatefulWidget {
  var task;
  var description;
  var bids;
  var id;
  var status;
   ViewBids({this.bids,this.task,this.description,this.id,this.status});

  @override
  State<ViewBids> createState() => _ViewBidsState();
}

class _ViewBidsState extends State<ViewBids> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkerNew=false;
    if(widget.status=="open"&&widget.bids.length>0){
      print("hehe");
      scoreByMl();

    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: () async => false,
      child: Scaffold(
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
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => ScreenDecider()));
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
        body: widget.bids.length>0? SingleChildScrollView(scrollDirection: Axis.vertical,
          child:widget.status=="open" ?checkerNew==true? Column(
            children: [
              SizedBox(height: 25,),
              Center(
                child: Text(
                  "Choose a bid.",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(36, 107, 253, 1),
                    fontFamily: 'Sora',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                child: Text(

                  "Our ML algorithms sort bids for selection. Final choice is yours. Double-check bids, read message. We provide professional touch, empower your decision.",
                  style: TextStyle(

                    fontFamily: 'Urbanist',

                    fontSize: 16,
                  ),
                ),
              ),
              Container(   height: 400,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(itemCount: widget.bids.length, itemBuilder: (context,index){
                  return  Card(
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
                                   "Bid:"+data[index]["bidding_message"].toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: 'Sora',
                                    ),
                                  ),
                                  subtitle: Text(
                                  "Amount:"+data[index]["bid_amount"].toString(),
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
                                      'Approve',
                                      style: TextStyle(
                                        color: Color.fromRGBO(36, 107, 253, 1),
                                      ),
                                    ),
                                    onPressed: () {
                                      // Handle button press
                             print(widget.bids[index]["bidder_id"]["_id"]);

                             approveReq(widget.bids[index]["bidder_id"]["_id"],widget.bids[index]["bidder_id"]["name"]);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                              10), // Add some spacing between the subtitle and ProgressBarPost
       // Add some spacing between the ProgressBarPost and ButtonBar
                        ],
                      ),
                    ),
                  );
                }),
              )
            ],
          ):Center(
            child: CupertinoActivityIndicator(),
          ):widget.status=="completed" ?Padding(
            padding:  EdgeInsets.only(left: 15,top: 15),
            child: Column(
              children: [

                Text("Task marked as completed by the user.",style: TextStyle(
                  fontSize: 70,
                  color: Color.fromRGBO(36, 107, 253, 1),
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                ),),
                Text("For any inquiries, we kindly recommend reaching out directly to the respective bidder. Please be aware that our platform operates on a peer-to-peer connecting model, and while we strive to facilitate a professional environment, we must clarify that we cannot assume responsibility for any incomplete status or malpractices.",
                  style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 17
                  ),
                )
              ],
            ),
          ): Padding(
            padding:  EdgeInsets.only(left: 15,top: 15),
            child: Column(
              children: [

                Text("Task In progress",style: TextStyle(
                  fontSize: 70,
                  color: Color.fromRGBO(36, 107, 253, 1),
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                ),),
                Text("For any inquiries, we kindly recommend reaching out directly to the respective bidder. Please be aware that our platform operates on a peer-to-peer connecting model, and while we strive to facilitate a professional environment, we must clarify that we cannot assume responsibility for any incomplete status or malpractices.",
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 17
                ),
                )
              ],
            ),
          )
        ):SingleChildScrollView(scrollDirection: Axis.vertical,
            child:widget.status=="open" ?Column(
              children: [
                SizedBox(height: 25,),
                Center(
                  child: Text(
                    "No bids received for this task yet.",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(36, 107, 253, 1),
                      fontFamily: 'Sora',
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Text(

                    "Our ML algorithms sort bids for selection. Final choice is yours. Double-check bids, read message. We provide professional touch, empower your decision.",
                    style: TextStyle(

                      fontFamily: 'Urbanist',

                      fontSize: 16,
                    ),
                  ),
                ),

              ],
            ):widget.status=="completed" ?Padding(
              padding:  EdgeInsets.only(left: 15,top: 15),
              child: Column(
                children: [

                  Text("Task marked as completed by the user.",style: TextStyle(
                    fontSize: 70,
                    color: Color.fromRGBO(36, 107, 253, 1),
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("For any inquiries, we kindly recommend reaching out directly to the respective bidder. Please be aware that our platform operates on a peer-to-peer connecting model, and while we strive to facilitate a professional environment, we must clarify that we cannot assume responsibility for any incomplete status or malpractices.",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 17
                    ),
                  )
                ],
              ),
            ): Padding(
              padding:  EdgeInsets.only(left: 15,top: 15),
              child: Column(
                children: [

                  Text("Task In progress",style: TextStyle(
                    fontSize: 70,
                    color: Color.fromRGBO(36, 107, 253, 1),
                    fontFamily: 'Sora',
                    fontWeight: FontWeight.bold,
                  ),),
                  Text("For any inquiries, we kindly recommend reaching out directly to the respective bidder. Please be aware that our platform operates on a peer-to-peer connecting model, and while we strive to facilitate a professional environment, we must clarify that we cannot assume responsibility for any incomplete status or malpractices.",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 17
                    ),
                  )
                ],
              ),
            )
        )
      ),
    );
  }
  approveReq(userid,assignedUser)async{
    Controller globals = new Controller();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var url = Uri.parse(globals.baseUrl + 'tasks/assign');

      var header={
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var body = jsonEncode({
   "task_id":widget.id,
        "bidder_id":userid


      });
      var response = await http.post(url, headers: header, body: body);
      print(response.body);
      print(response.statusCode);
      if(response.statusCode==200){
        setState(() {
          checker=false;
        });
        popup1(context, "Task assigned to ${assignedUser} successfully");
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
  scoreByMl() async {
    setState(() {
      checkerNew=false;
    });
    Controller globals = new Controller();

    var url = Uri.parse(globals.mlUrl);

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    List<Map<String, dynamic>> bidBody = [];

    for (var i = 0; i < widget.bids.length; i++) {
      print(widget.bids[i]["bid_amount"]);
      print(widget.bids[i]["bid_message"]);
      bidBody.add({
        "bid_amount": widget.bids[i]["bid_amount"],
        "bidding_message": widget.bids[i]["bid_message"],
      });
    }

    var body = jsonEncode(bidBody);

    var response = await http.post(url, headers: header, body: body);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        checkerNew = true;
        data=jsonDecode(response.body);
      });
      print("set ayi mone");
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ScreenDecider()));
popup1(context, "Something went wrong");
      print(response.body);
      print(response.statusCode);
    }
  }


}
