import 'package:asignease/Search/TaskInfo.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatefulWidget {
  final String task;
  final String description;
  var id;
var bids;
var budget;
  MyContainer({required this.task, required this.description, this.id,this.bids,this.budget});

  @override
  _MyContainerState createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double containerHeight = screenHeight / 5;

    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: containerHeight,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.length >= 40 ? widget.task.substring(0, 40)+".." : widget.task,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(36, 107, 253, 1),
                    fontFamily: 'Sora',
                  ),
                ),

                SizedBox(height: 10.0),
                widget.description.length > 40 && !isExpanded
                    ? Text(
                  widget.description.substring(0, 35) + '...',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                    fontFamily: 'Urbanist',
                  ),
                )
                    : Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                    fontFamily: 'Urbanist',
                  ),
                ),

                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "By Krishnaprasad MG",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: 'Sora',
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    ElevatedButton(  style: ElevatedButton.styleFrom(primary:  Color.fromRGBO(36, 107, 253, 1),),

                        onPressed: () {
                        //change  color of buttoon

                        // Add your button action here

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskInfo(
                                id: widget.id,
                                isPopularTask: false,
                                title: widget.task,
                                description: widget.description,
                                image: "https://fiverr-res.cloudinary.com/t_gig_cards_web,q_auto,f_auto/gigs/172660276/original/ed89b0a03f078ef59937a7a0ef9c79d4cd5b560d.jpg", // Replace with the actual image URL
                                postedBy: "John Doe", // Replace with the actual posted by user
                                budget:widget.budget.toString(),// Replace with the actual budget
                                numBidders: widget.bids, // Replace with the actual number of bidders
                              ),
                            ),
                          );
                      },
                      child: Text(
                        "View",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Sora',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
