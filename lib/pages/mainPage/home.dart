import 'package:flutter/material.dart';
import 'package:inti/pages/bookFacility/selectFacility.dart';
import 'package:inti/pages/news/microsft.dart';
import 'package:inti/pages/news/ptptn.dart';
import 'package:inti/pages/news/wifi.dart';
import 'package:inti/pages/orderFood/menu.dart';
import 'package:inti/pages/shuttleBus/shuttleBus.dart';
import 'package:inti/pages/timetable.dart';
import 'package:inti/pages/viewHostel/hostel.dart';
import 'package:inti/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
      backgroundColor: primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('iCampus by INTI',
          style: title,
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Services',
                  style: heading,
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 81,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: primaryColor
                              ),
                              onPressed: () {
                                _navigateToTimetable(context);
                              },
                              child: Icon(Icons.schedule,
                                color: backgroundColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Timetable',
                              style: body,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 81,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: primaryColor
                              ),
                              onPressed: () {
                                _navigateToShuttleBus(context);
                              },
                              child: Icon(Icons.bus_alert_outlined,
                                color: backgroundColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Shuttle',
                              style: body,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 81,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: primaryColor
                              ),
                              onPressed: () {
                                _navigateToFacility(context);
                              },
                              child: Icon(Icons.apartment,
                                color: backgroundColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Facilities',
                              style: body,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 81,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: primaryColor
                              ),
                              onPressed: () {
                                _navigateToCafeteria(context);
                              },
                              child: Icon(Icons.local_cafe,
                                color: backgroundColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Cafeteria',
                              style: body,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 81,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: primaryColor
                              ),
                              onPressed: () {
                                _launchURL("iicpenrol.newinti.edu.my");
                              },
                              child: Icon(Icons.attach_money,
                                color: backgroundColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Finance',
                              style: body,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 81,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: primaryColor
                              ),
                              onPressed: () {
                                _navigateToHostel(context);
                              },
                              child: Icon(Icons.house,
                                color: backgroundColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Hostel',
                              style: body,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.newspaper_outlined),
                    ),
                    Text('News',
                      style: heading,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _navigateToMicrosoft(context);
                },
                child: addNews("assets/office.png", 'Mon, 22 May 2023', 'Office 365 for Students',
                    'INTI is providing Microsoft Office to', 'every student for FREE!'
                ),
              ),
              GestureDetector(
                onTap: () {
                  _navigateToWiFi(context);
                },
                child: addNews("assets/wifi.png", 'Mon, 03 Apr 2023', 'Campus WiFi',
                    'INTI is providing Wi-Fi to', 'every student for FREE!'
                ),
              ),
              GestureDetector(
                onTap: () {
                  _navigateToPTPTN(context);
                },
                child: addNews("assets/ptptn.png", 'Mon, 01 Apr 2023', 'PTPTN Application',
                    'Information and instruction for', 'how to apply PTPTN'
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget addNews(image, date, title, details1, details2) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Image.asset(
              image,
              height: 100,
              width: 100,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: greyBody,),
              Text(title,
                style: heading,
              ),
              Text(details1, style: subHeading,),
              Text(details2 , style: subHeading,),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateToMicrosoft(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Microsoft()));
  }

  void _navigateToWiFi(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const WiFi()));
  }

  void _navigateToPTPTN(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const PTPTN()));
  }

  void _navigateToTimetable(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Timetable()));
  }

  void _navigateToShuttleBus(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ShuttleBus()));
  }

  void _navigateToFacility(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Facility()));
  }
  void _navigateToCafeteria(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Menu()));
  }
  void _navigateToHostel(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Hostel()));
  }
}