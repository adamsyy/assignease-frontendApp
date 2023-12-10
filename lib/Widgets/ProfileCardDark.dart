import 'package:asignease/Controller.dart';
import 'package:asignease/Search/UserProfile.dart';
import 'package:flutter/material.dart';

Controller globals = new Controller();

class Profile_card_dark extends StatelessWidget {
  var height_here;
  var width_here;
  String mainTitle;
  String subTitle;

  Profile_card_dark({
    required this.height_here,
    required this.width_here,
    required this.mainTitle,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height_here,
      width: MediaQuery.of(context).size.width / width_here,
      margin: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: globals.button_purple_shade.withOpacity(0.83),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              width: 40,
              height: 50,
              child: ClipOval(
                child: Image.asset(
                  'pictures/dp.png',
                  scale: 2.5,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    fontFamily: 'Urbanist',
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: 'Urbanist',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 60,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    'View',
                    style: TextStyle(
                      color: globals.button_purple_shade.withOpacity(0.83),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
