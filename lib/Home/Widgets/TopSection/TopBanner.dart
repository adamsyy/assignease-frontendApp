import 'package:flutter/material.dart';

class TopBanner extends StatelessWidget {
  final String task;
  final String description;
  final String image;

  TopBanner({required this.task, required this.description,required this.image});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double containerHeight = screenHeight /3;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.network(
                  image,
                  height: 100,
                  width: 150,
                ),
              ),
              Text(
                task,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(36, 107, 253, 1),
                  fontFamily: 'Sora',
                ),
              ),
              SizedBox(height: 0.0), // Add some space between the task and description
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                      fontFamily: 'Urbanist',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }
}
