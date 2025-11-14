import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inti/pages/bookFacility/bookingHistory.dart';
import 'package:intl/intl.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';
import 'dart:convert'; // json
import 'package:http/http.dart' as http;

class BookingDetails extends StatefulWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  int unixTime = 0;
  DateTime? startDateTime;
  String startTime = "";
  String endTime = "";
  var students;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // put the date into the date into int unixTime
    unixTime = globalArrivalDate!;
    // convert int unix time into readable date time
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    startDateTime = dateTime;
    startTime = DateFormat.jm().format(dateTime);
    DateTime unformattedEndTime = dateTime.add(Duration(minutes: globalDuration!*60));
    endTime = DateFormat.jm().format(unformattedEndTime);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Text('Booking Details', style: title,),

              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          height: 100,
                          child: FittedBox(
                            child: Image.asset(
                              globalSelectedFacility['image'],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(globalSelectedFacility['name'],
                            style: title,
                        ),
                      ),
                    ),

                    Divider(
                      color: Colors.grey[300],
                      thickness: 2.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.calendar_month),
                        ),
                        Text(globalSelectedDate,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.access_time_outlined),
                        ),
                        Text(globalSelectedTime,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Text('Student (s)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: getStudent(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: globalSelectedStudentID.length,
                            itemBuilder: (context, index) {
                              return displayStudent(globalSelectedStudentID[index]);
                            }
                        );
                      }
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoActionSheet(
                                  message: Text(
                                      'Are you sure you want to delete this appointment?'),
                                  actions: [
                                    CupertinoActionSheetAction(
                                      onPressed: () {
                                        _onDismissed(globalSelectedAppointment);
                                        int count = 0;
                                        Navigator.of(context)
                                            .popUntil((_) => count++ >= 3);
                                        _navigateToBookingHistory(context);
                                      },
                                      isDestructiveAction: true,
                                      child: Text('Delete Appointment'),
                                    ),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    isDefaultAction: true,
                                    child: Text('Cancel', style: TextStyle(color: Colors.blue),),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Delete Appointment',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
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
                              Navigator.pop(context);
                            },
                            child: Text('Back',
                              style: heading,
                            ),
                          ),
                        ),
                      ],
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
  blockDate(arrivalDate) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('PUT', Uri.parse('http://$globalIPAddress:3000/timeslots/$arrivalDate'));
    request.bodyFields = {
      'blockDate': '0'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);
    }
    else {
      print(response.reasonPhrase);
    }
  }
  Future<void> _onDismissed(appointment) async {
    int bookID = appointment['bookID'];

    var request = http.Request(
        'DELETE', Uri.parse('http://$globalIPAddress:3000/book/facility/$bookID'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      if (appointment['duration'] == 60) {
        blockDate(appointment['arrivalDate']);
      } else {
        blockDate(appointment['arrivalDate']);
        blockDate(appointment['arrivalDate']+3600);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }
  getStudent() async {
    var request = http.Request('GET', Uri.parse('http://$globalIPAddress:3000/students'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      students = text;

    }
    else {
      print(response.reasonPhrase);
    }
  }

  displayStudent(studentID) {
    if (students == null) {
      return Container(); // Return an empty container or handle the null case accordingly
    }

    var student;
    for (int i = 0; i < students.length; i ++) {
      if (studentID == students[i]['studentID']) {
        student = students[i];
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          student['image'] == "" ? CircleAvatar(
            radius: 24,
            child: Icon(Icons.person),
          ) : CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(
              student['image'],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(student['name'],
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _navigateToBookingHistory(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const BookingHistory()));
  }
}
