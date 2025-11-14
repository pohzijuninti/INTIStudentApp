import 'package:flutter/material.dart';
import 'package:inti/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class WiFi extends StatefulWidget {
  const WiFi({Key? key}) : super(key: key);

  @override
  State<WiFi> createState() => _WiFiState();
}

class _WiFiState extends State<WiFi> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if(!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Text('Campus WiFi', style: heading,),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('03 Apr 2023, 2:18 PM'),
                      ),
                      SizedBox(
                        height: 230.0,
                        child: Image.asset("assets/wifi.png", scale: 3.5,),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Network Name: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('User Name: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Default Password: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Newinti-Secure',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text('Student ID',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text('IICP + IC/Passport',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text('(eg: iicp900101071234)\n'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text('Change Password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchURL("IICPChangePassword.newinti.edu.my");
                        },
                          child: Text('https://IICPChangePassword.newinti.edu.my',
                            style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue[700]),)
                      ),
                      Text('\n'),
                      SizedBox(
                        height: 230.0,
                        child: Image.asset("assets/intiwifi.PNG", scale: 3.5,),
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
}
