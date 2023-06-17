import 'dart:convert';
import 'package:asignease/BottomNavBar/BottomNavBar.dart';
import 'package:asignease/Home/Home.dart';
import 'package:asignease/auth/SignIn.dart';
import 'package:http/http.dart' as http;
import 'package:asignease/Controller.dart';
import 'package:asignease/Popup.dart';
import 'package:asignease/Widgets/BlueButton.dart';
import 'package:asignease/Widgets/BlueButtonLoading.dart';
import 'package:asignease/auth/Widgets/AuthField.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
var wcLink;
var connected = false;
var address;

String email = 'email';
String name = 'name';
String password = '';
String phone = '';
bool checked = false;
bool checker=false;
Controller globals = new Controller();

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                    "Sign Up!",
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
                          name = value;
                        });
                      },
                      hint: 'Name',
                    )),
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
                          phone = value;
                        });
                      },
                      hint: 'phone number',
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

                SizedBox(
                  height: 25,
                ),
               Row(mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Already have an account?",
                       style: TextStyle(
                           color: globals.text_lightgrey,
                           fontWeight: FontWeight.w800,
                           fontSize: 14,
                           fontFamily: 'Urbanist')),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => Signin2()));
                      },
                      child: Text("Sign In",
                          style: TextStyle(
                              color: globals.text_darkblue,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              fontFamily: 'Urbanist')),
                    ),

                 ],
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
                          await SignUpApi();
                        },
                        child: checker == false
                            ?Blue_button(
                          content: 'Sign Up',
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
                    onTap: () async {
                      connectWallet();
                    },
                    child: Blue_button(
                      isweb3: true,
                      content: 'Sign up with Metamask',
                      width_here: 315,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
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



              ],
            ),
          ),
        ),
      ),
    );
  }



  Future<void> SignUpApi() async {
    var url = Uri.parse(globals.baseUrl + 'auth/register');

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = jsonEncode({
      "email": email,
      "password": password,
      "phone_number": phone,
      "name": name,
    });

    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        // Request successful, handle the response
        var responseData = jsonDecode(response.body);
        var token=responseData['token'];
        // store token using shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setString('email', email);
        prefs.setString('name', name);
        prefs.setString('phone', phone.toString());
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










  Future<void> SignUpApi_web3() async {
    var url = Uri.parse(globals.baseUrl + 'auth/register');

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var body = jsonEncode({
  "web3":true,
      "wallet_address":address
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
print(response.body);
print(response.statusCode);
      if (response.statusCode == 201) {
        // Request successful, handle the response
        var responseData = jsonDecode(response.body);
        var token=responseData['token'];
        // store token using shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setString('name', "Anonymous");
        prefs.setString('address', address);
        // prefs.setString('email', email);
        // prefs.setString('name', name);
        // prefs.setString('phone', phone.toString());
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
            SignUpApi_web3();
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
