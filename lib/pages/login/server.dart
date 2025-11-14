import 'package:flutter/material.dart';
import 'package:inti/pages/login/login.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class Server extends StatefulWidget {
  const Server({Key? key}) : super(key: key);

  @override
  State<Server> createState() => _ServerState();
}

class _ServerState extends State<Server> {
  TextEditingController IPAddressController = TextEditingController();

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
              Center(child: Image.asset('assets/logo.png', scale: 2.5,)),
              TextField(
                controller: IPAddressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  labelText: 'Server IP Address',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
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
                          globalIPAddress = IPAddressController.text;
                          if(globalIPAddress != "") {
                            _navigateToLogin(context);
                          }
                        },
                        child: Text('Enter',
                          style: TextStyle(
                            color: backgroundColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _navigateToLogin(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
  }
}
