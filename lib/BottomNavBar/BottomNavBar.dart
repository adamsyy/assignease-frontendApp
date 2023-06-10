import 'package:asignease/Home/Home.dart';
import 'package:asignease/OnesIApplied/IApplied.dart';
import 'package:asignease/Profile/Profile.dart';
import 'package:asignease/Search/Search.dart';
import 'package:flutter/material.dart';


class ScreenDecider extends StatefulWidget {
  const ScreenDecider({Key? key}) : super(key: key);

  @override
  State<ScreenDecider> createState() => _ScreenDeciderState();
}

class _ScreenDeciderState extends State<ScreenDecider> {
  int _selectedIndex = 0;
  _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  dynamic _widgetOptions() {
    if (_selectedIndex == 0) {
      return Home();
    } else if (_selectedIndex == 1) {
      return Search();
    } else if (_selectedIndex == 2) {
      return IApplied(

      );
    } else if (_selectedIndex == 3) {
      return Profile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "pictures/home.png",
                    height: 25,
                    width: 20,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'pictures/search.png',
                    height: 25,
                    width: 20,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'pictures/list.png',
                    height: 25,
                    width: 20,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "pictures/profile.png",
                    height: 25,
                    width: 20,
                  ),
                  label: '',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              onTap: _onTap,
              iconSize: 20,
            ),
          ),
        ),
      ),
      body: _widgetOptions(),
    );
  }
}
