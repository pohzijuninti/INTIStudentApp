import 'package:flutter/material.dart';
import 'dart:convert'; // json
import 'package:http/http.dart' as http;
import 'package:inti/pages/login/register.dart';
import 'package:inti/pages/mainPage/mainPage.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final studentIDController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Image.asset('assets/logo.png', scale: 3.5,)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: TextFormField(
                        controller: studentIDController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          labelText: 'Student ID',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {

                                login();
                              },
                              child: Text('Login',
                                style: TextStyle(
                                  color: backgroundColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: BorderSide(
                                  color: primaryColor,
                                ),
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                _navigateToRegister(context);
                              },
                              child: Text('Register',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: primaryColor
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text('Login as '),
                    //       GestureDetector(
                    //         onTap: () {
                    //           _navigateToMainPage(context);
                    //         },
                    //         child: Text('Guest',
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             color: primaryColor,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
      ),
    );
  }
  void _navigateToMainPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MainPage()));
  }
  void _navigateToRegister(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Register()));
  }
  login() async {
    String message = "";
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request(
        'POST', Uri.parse('http://$globalIPAddress:3000/login'));
    request.bodyFields = {
      'studentID': studentIDController.text,
      'password': passwordController.text
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var decode = await response.stream.bytesToString();
      var text = json.decode(decode);

      // save account object and token into global variables
      account = text['account'] ?? text;
      globalToken = text['token'];

      _navigateToMainPage(context);
    }
    else {
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      message = text["locked"].toString();
      if(text["locked"] == null) {
        message = text["error"] + " " + text["remainingAttempts"].toString() + " attempt(s) left.";
      } else {
        message = "Your account is locked. Please wait " + text["unlockInSecond"] + "seconds.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              height: 20,
              decoration: BoxDecoration(
                // color: Colors.yellow,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(message),
            ),
            behavior: SnackBarBehavior.floating,
          )
      );
      // print(response.reasonPhrase);
    }
  }
}
