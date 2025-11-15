import 'package:flutter/material.dart';
import 'dart:convert'; // json
import 'package:http/http.dart' as http;
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final studentIDController = TextEditingController();
  final ICController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Image.asset('assets/logo.png', scale: 3.5,)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$')
                                  .hasMatch(value)) {
                            return "Enter correct name";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          labelText: 'Name',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        controller: studentIDController,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^P+[0-9]{8}$')
                                  .hasMatch(value)) {
                            return "Enter correct Student ID";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          labelText: 'Student ID',
                          hintText: 'P21012345',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        controller: ICController,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^(\d{12})$')
                                  .hasMatch(value)) {
                            return "Enter correct IC number";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          labelText: 'NRIC / Passport No',
                          hintText: '050101070001'
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*?~]).{8,}$')
                                  .hasMatch(value)) {
                            return "Use at least 8 characters one uppercase letter one lowercase \nletter one number and one special character in your password";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.next,
                        // obscureText: true,
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
                      child: TextFormField(
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty || confirmPasswordController.text != passwordController.text) {
                            return "Passwords do not match";
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          labelText: 'Confirm Password',
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
                                padding: EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!
                                    .validate()) {
                                  showOTPDialog();
                                  // showRegistrationSuccessful();
                                }
                              },
                              child: Text('Register',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Login now',
                            style: TextStyle(
                              color: primaryColor,
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
        ),
      ),
    );
  }
  void verifyOTP(String otp) {
    const correctOTP = "123456"; // Replace with your generated OTP

    if (otp == correctOTP) {
      Navigator.pop(context); // Close OTP dialog

      register();             // Now register the user
      _navigateToLogin(context); // Navigate after successful registration

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid OTP. Please try again."))
      );
    }
  }


  Future showOTPDialog() => showDialog(
    context: context,
    builder: (context) {
      TextEditingController otpController = TextEditingController();

      return AlertDialog(
        title: Text(
          'OTP Verification',
          textAlign: TextAlign.center,
        ),
        content: TextField(
          controller: otpController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Enter OTP",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor
            ),
            onPressed: () {
              String otp = otpController.text.trim();
              verifyOTP(otp);
            },
            child: Text("Verify"),
          ),
        ],
      );
    },
  );

  Future showRegistrationSuccessful() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(
        child: Text('Your registration is \nsuccessful!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SizedBox(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_rounded, size: 100, color: Colors.green,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Congratulations, your account has been successfully created.', textAlign: TextAlign.center,),
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            onPressed: () {
              register();
              _navigateToLogin(context);
            },
            child: Text('Back to Login'),
          ),
        ),
      ],
    ),
  );
  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
  register() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse('http://$globalIPAddress:3000/register'));
    request.bodyFields = {
      'name': nameController.text,
      'studentID': studentIDController.text,
      'ic': ICController.text,
      'password': passwordController.text
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
