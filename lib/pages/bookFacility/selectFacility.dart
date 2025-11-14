import 'package:flutter/material.dart';
import 'dart:convert'; // json
import 'package:http/http.dart' as http;
import 'package:inti/pages/bookFacility/bookingHistory.dart';
import 'package:inti/pages/bookFacility/selectDateTime.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class Facility extends StatefulWidget {
  const Facility({Key? key}) : super(key: key);

  @override
  State<Facility> createState() => _FacilityState();
}

class _FacilityState extends State<Facility> {

  var selectedFacility;
  int selectedHour = -1;
  var facilities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil('/mainPage', (Route<dynamic> route) => false);
                        },
                        icon: Icon(Icons.arrow_back_ios_new)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Facilities',
                          style: title,
                        ),
                      ),
                    ],
                  ),

                  IconButton(
                      onPressed: () {
                        _navigateToBookingHistory(context);
                      },
                      icon: Icon(Icons.history)
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: getFacility(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: facilities.length,
                      itemBuilder: (context, index) {
                        return displayFacility(facilities[index]);
                      }
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayFacility(facility) {
    return GestureDetector(
      onTap: () {
        selectedFacility = facility;
        selectDuration(context);
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: [
            Image.asset(
              facility['image'],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 30,
                width: 383,
                color: Colors.black54,
                child: Center(
                  child: Text(facility['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> selectDuration(BuildContext context) {
    return showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (BuildContext context, setState) =>
                    makeDismissible(
                      child: DraggableScrollableSheet(
                            initialChildSize: 0.65,
                            minChildSize: 0.65,
                            builder: (_, controller) => Container(
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Stack(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20.0),
                                              child: Image.asset('assets/duration.png',
                                                fit: BoxFit.fill,),
                                            ),
                                          ),
                                        ],
                                      ),

                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            selectedHour = -1;
                                          },
                                          icon: Icon(Icons.close, color: Colors.white,)
                                      ),
                                    ],
                                  ),

                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Select Duration',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                height: 120,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: selectedHour == 1 ? Colors.grey : Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    setState((){
                                                      if (selectedHour == 1) {
                                                        selectedHour = -1;
                                                      } else {
                                                        selectedHour = 1;
                                                      }
                                                    });
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("1",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 48,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text("hour",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 150,
                                                height: 120,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: selectedHour == 2 ? Colors.grey : Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    setState((){
                                                      if (selectedHour == 2) {
                                                        selectedHour = -1;
                                                      } else {
                                                        selectedHour = 2;
                                                      }
                                                    });
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text("2",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 48,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text("hours",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SafeArea(
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: primaryColor,
                                                padding: EdgeInsets.symmetric(vertical: 15),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(11.0),
                                                ),
                                              ),
                                              onPressed: () {
                                                globalFacility = selectedFacility;
                                                globalDuration = selectedHour;
                                                if (selectedHour != -1) {
                                                  _navigateToSelectDateTime(context);
                                                }
                                              },
                                              child: Text('Next',
                                                style: heading,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                    ),
                  ),
                );
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      Navigator.of(context).pop();
      selectedHour = -1;
    },
    child: GestureDetector(onTap: () {}, child: child),
  );

  getFacility() async {
    var request = http.Request('GET', Uri.parse('http://$globalIPAddress:3000/facility'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      facilities = text;
    }
    else {
    print(response.reasonPhrase);
    }
  }

  void _navigateToSelectDateTime(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SelectDateTime()));
  }
  void _navigateToBookingHistory(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const BookingHistory()));
  }
}
