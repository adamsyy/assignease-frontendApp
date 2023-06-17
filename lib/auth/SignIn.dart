import 'dart:convert';
import 'package:asignease/BottomNavBar/BottomNavBar.dart';
import 'package:http/http.dart' as http;
import 'package:asignease/Controller.dart';
import 'package:asignease/Popup.dart';
import 'package:asignease/Widgets/BlueButton.dart';
import 'package:asignease/Widgets/BlueButtonLoading.dart';
import 'package:asignease/auth/SignUp.dart';
import 'package:asignease/auth/Widgets/AuthField.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';


String email = 'email';
String password = '';
bool checked = false;
bool checker=false;
Controller globals = new Controller();

class Signin2 extends StatefulWidget {
  @override
  State<Signin2> createState() => _Signin2State();
}

class _Signin2State extends State<Signin2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = 'email';
    password = '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
     return false;
      },
      child: Scaffold(

        resizeToAvoidBottomInset: false,
        backgroundColor: globals.background_color,
        appBar: AppBar(
          backgroundColor: globals.background_color,
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
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 12),
                  child: Text(
                    "Welcome back!",
                    style: TextStyle(
                        color: globals.text_lightgrey,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        fontFamily: 'Urbanist'),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                    child: Authfield(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      hint: 'Email',
                    )),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Authfield(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      hint: 'Password',
                    )),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 15,
                      right: MediaQuery.of(context).size.width / 15),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: Color.fromRGBO(231, 235, 243, 1),
                        checkColor: globals.text_darkblue,
                        value: checked,
                        onChanged: (bool? value) {
                          setState(() {
                            checked = !checked;
                          });
                        },
                      ),
                      Text(
                        'Remember me',
                        style: TextStyle(
                            color: globals.text_lightgrey,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            fontFamily: 'Urbanist'),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   PageRouteBuilder(
                          //     pageBuilder: (context, animation, secondaryAnimation) => ForgotPassword(),
                          //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          //       const begin = Offset(1.0, 0.0);
                          //       const end = Offset.zero;
                          //       final tween = Tween(begin: begin, end: end);
                          //       final offsetAnimation = animation.drive(tween);
                          //
                          //       return SlideTransition(
                          //         position: offsetAnimation,
                          //         child: child,
                          //       );
                          //     },
                          //   ),
                          // );
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: globals.text_lightgrey,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              fontFamily: 'Urbanist'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                Center(
                    child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            checker = true;
                          });
                          bool isValidEmail = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$')
                              .hasMatch(email);
                          if (!isValidEmail ||
                              email.isEmpty ||
                              email == 'email') {
                            setState(() {
                              checker = false;
                            });
                            popup1(context, "Please enter a valid email");

                            return;
                          } else if (password.isEmpty || password == 'password') {
                            setState(() {
                              checker = false;
                            });
                            popup1(context, "Please enter a valid password");
                            return;
                          }

                          //do requuest here
                          await SignInApi();
                        },
                        child: checker == false
                            ?Blue_button(
                          content: 'Sign In',
                          width_here: 315,
                        )
                            :Blue_button_Loading(
                          width_here: 315,
                        ))),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: GestureDetector(
                    onTap: (){
                      connectWallet();
                    },
                    child: Blue_button(
                      isweb3: true,
                      content: 'Sign in with Metamask',
                      width_here: 315,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                    child: Text(
                      "or",
                      style: TextStyle(
                          color: globals.text_lightgrey,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          fontFamily: 'Urbanist'),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: 14,
                ),
                // Center(
                //   child: GestureDetector(onTap: ()async{
                //     await googleSigninHandler.googleSignhandler();
                //   },
                //     child: Socialauth(
                //       content: 'Google',
                //       iconhere: FontAwesomeIcons.google,
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: 15,
                ),
                SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: globals.text_lightgrey,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          fontFamily: 'Urbanist'),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => SignUp(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              final tween = Tween(begin: begin, end: end);
                              final offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Create account",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(83, 79, 249, 1),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> SignInApi() async {
    var url = Uri.parse(globals.baseUrl + 'auth/login');

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = jsonEncode({
      "email": email,
      "password": password,

    });

    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Request successful, handle the response
        var responseData = jsonDecode(response.body);
        var token=responseData['token'];
        var name=responseData['user']['name'];
        var phone=responseData['user']['phone_number'];
        var _id=responseData['user']['_id'];
        // store token using shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setString('email', email);
        prefs.setString('name', responseData['user']['name'].toString());
        prefs.setString('phone', phone.toString());
        prefs.setString('_id', _id.toString());

        //push to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ScreenDecider()));

        print(responseData);
        setState(() {
          checker = false;
        });

      } else {
        // Request failed, handle the error
        print('Request failed with status: ${response.statusCode}.');
        print(response.body);
        setState(() {
          checker = false;
        });
        //show snackbar
        popup1(context, "Something went wrong");
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error: $e');
      setState(() {
        checker = false;
      });
      popup1(context, "Something went wrong");
    }
  }









  Future<void> SignInApi_Web3() async {
    var url = Uri.parse(globals.baseUrl + 'auth/login');

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = jsonEncode({
      "web3": true,
      "wallet_address": address,

    });

    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Request successful, handle the response
        var responseData = jsonDecode(response.body);
        var token=responseData['token'];

        // store token using shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setString('name', "Anonymous");
        prefs.setString('address', address);


        //push to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ScreenDecider()));

        print(responseData);
        setState(() {
          checker = false;
        });

      } else {
        // Request failed, handle the error
        print('Request failed with status: ${response.statusCode}.');
        print(response.body);
        setState(() {
          checker = false;
        });
        //show snackbar
        popup1(context, "Something went wrong");
      }
    } catch (e) {
      // Exception occurred during the request
      print('Error: $e');
      setState(() {
        checker = false;
      });
      popup1(context, "Something went wrong");
    }
  }
  void connectWallet() async {
    final connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: PeerMeta(
        name: 'WalletConnect',
        description: 'WalletConnect Developer App',
        url: 'https://walletconnect.org',
        icons: [
          'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
        ],
      ),
    );

    connector.on('connect', (session) {
      print("one");
      print(session);

      if (session is SessionStatus && session.accounts.isNotEmpty) {
        final connectedAccount = session.accounts[0];
        print("Connected account address: $connectedAccount");
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("connectedAccount", connectedAccount);
          setState(() {
            connected = true;
            address = connectedAccount;
            SignInApi_Web3();
          });
        });
      }
    });

    connector.on('session_update', (payload) {
      print("two");
      print(payload);
    });

    connector.on('disconnect', (session) {
      print("3");
      print(session);
    });

    if (!connector.connected) {
      final session = await connector.createSession(
        chainId: 4160,
        onDisplayUri: (uri) async {
          wcLink = uri;
          print(uri);
          await launch(wcLink);
          print("Launched");
        },
      );
    }
  }
}
