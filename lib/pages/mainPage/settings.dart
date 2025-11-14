import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // json
import 'package:http/http.dart' as http;
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var students = [];
  String studentImage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              FutureBuilder(
                future: getStudent(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return displayStudentCard(account);
                  },
              ),
              Expanded(child: SizedBox.shrink()),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: primaryColor,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text('Confirmation'),
                      content: const Text('Are you sure you want exit?'),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                          ),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            _navigateToLogin(context);
                          },
                          isDefaultAction: true,
                          child: const Text('Yes', style: TextStyle(color: Colors.blue),),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.logout),
                label: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getStudent() async {
    var request = http.Request('GET', Uri.parse('http://$globalIPAddress:3000/students'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      students = text;

      for (int i = 0; i < students.length; i++) {
        if (students[i]['studentID'] == account['studentID']) {
          setState(() {
            studentImage = students[i]['image'];
          });
          break;
        }
      }
    }
    else {
    print(response.reasonPhrase);
    }
  }

  Widget displayStudentCard(account) {
    return GestureDetector(
      onTap: () {
        showQR();
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Image.asset(
                "assets/inti_international_university_college.png",
                scale: 2.6,
                fit: BoxFit.cover,
              ),
              Row(
                children: [
                  studentImage.isEmpty?
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 30.0),
                    child: Icon(Icons.person, size: 50,),
                  ) :
                  Image.asset(
                    studentImage,
                    height: 100,
                    width: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account['name'],
                          style: heading,
                        ),
                        Text(
                          account['studentID'],
                          style: subHeading,
                        ),
                        Text(
                          'INTI International College Penang',
                          style: subHeading,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.asset(
                            "assets/barcode.png",
                            height: 20,
                            width: 180,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future showQR() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(
          child: Text(account['name'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
      ),
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/qrcode.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(account['studentID']),
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text('Close'),
          ),
        ),
      ],
    ),
  );
  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }
}
