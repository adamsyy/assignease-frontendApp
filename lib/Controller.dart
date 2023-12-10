import 'dart:ui';

import 'package:get/get.dart';

class Controller extends GetxController {
  //colours
  Color background_color = Color(0xFFF5F5F5);
  Color button_purple_shade = Color.fromRGBO(36, 107, 253, 1);
  Color text_darkblue = Color.fromRGBO(38, 53, 75, 1);
  Color text_lightgrey = Color.fromRGBO(159, 168, 188, 1);
  Color progressbar_purple = Color.fromRGBO(83, 79, 249, 1);
  
  //user details
  var email;
  var access_token;
  var refresh_token;

  //endpoints
  var baseUrl = "https://assignease-backend.onrender.com/";
  var mlUrl = "https://217c-14-139-184-222.ngrok-free.app/predict";

//manage loading states
}
