import 'package:flutter/material.dart';
import 'dart:convert'; // json
import 'package:http/http.dart' as http;
import 'package:inti/variables.dart';
import 'package:intl/intl.dart';
import 'package:inti/data.dart';
import 'package:inti/pages/bookFacility/bookingDetails.dart';
import 'package:inti/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {

  var appointments = [];
  var appointmentStudents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new)
                  ),
                  Text('Booking History', style: title,),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: getAppointment(),
                  builder: (context, snapshot) {
                    return appointments.length == 0 ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month, size: 60,),
                        Text('No Booking History', style: heading,),
                      ],
                    ) : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                      return Container(
                        child: Slidable(
                            endActionPane: ActionPane(
                              extentRatio: 0.3,
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  borderRadius:
                                  BorderRadius.circular(2.0),
                                  autoClose: true,
                                  backgroundColor: primaryColor,
                                  icon: Icons.delete_outline,
                                  label: 'Delete',
                                  onPressed: (context) {
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (context) =>
                                          CupertinoActionSheet(
                                            message: const Text(
                                                'Are you sure you want to delete this appointment?'),
                                            actions: [
                                              CupertinoActionSheetAction(
                                                onPressed: () {
                                                  _onDismissed(
                                                      appointments[index], index);
                                                  Navigator.pop(context);
                                                },
                                                isDestructiveAction: true,
                                                child: const Text(
                                                    'Delete Appointment'),
                                              ),
                                            ],
                                            cancelButton:
                                            CupertinoActionSheetAction(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              isDefaultAction: true,
                                              child: const Text('Cancel',
                                                style: TextStyle(
                                                  color: Colors.blue
                                                ),
                                              ),
                                            ),
                                          ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            child: displayAppointment(appointments[index]),
                        ),
                      );
                        // displayAppointment(appointments[index]);
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

  Widget displayAppointment(appointment) {
    var facility;
    var students = [];
    for (int i = 0; i < globalFacilities.length; i++ ){
      if (appointment['locationID'] == globalFacilities[i]['locationID']) {
        facility = globalFacilities[i];
      }
    }

    for (int i = 0; i < appointmentStudents.length; i++) {
      if (appointment['bookID'] == appointmentStudents[i]['bookID']) {
        students.add(appointmentStudents[i]['studentID']);
      }
    }

    // put the date into the date into int unixTime
    int unixTime = appointment['arrivalDate'];
    // convert int unix time into readable date time
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    DateTime startDateTime = dateTime;
    String startTime = DateFormat.jm().format(dateTime);
    DateTime unformattedEndTime = dateTime.add(Duration(minutes: appointment['duration']));
    String endTime = DateFormat.jm().format(unformattedEndTime);
    return GestureDetector(
      onTap: () {
        globalSelectedAppointment = appointment;
        globalSelectedFacility = facility;
        globalSelectedDate = DateFormat('dd MMM yyyy (EEEE)').format(startDateTime);
        globalSelectedTime = startTime.toString() + ' - ' + endTime.toString();
        globalSelectedStudentID = students;
        _navigateToBookingDetails(context);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          height: 50,
                          width: 80,
                          color: Colors.black,
                          child: FittedBox(
                            child: Image.asset(
                              facility['image'],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        facility['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                          child: Icon(Icons.calendar_month),
                        ),
                        Text(DateFormat('dd MMM yyyy (EEEE)').format(startDateTime),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                          child: Icon(Icons.access_time),
                        ),
                        Text(startTime.toString() + ' - ' +
                            endTime.toString()),
                      ],
                    ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                          child: Icon(Icons.people_alt_outlined),
                        ),
                        Text('Student(s) ' + students.length.toString()),
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

  getAppointmentStudent() async {
    var request = http.Request('GET', Uri.parse('http://$globalIPAddress:3000/appointment/students'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      appointmentStudents = text;

    }
    else {
    print(response.reasonPhrase);
    }

  }

  getAppointment() async {
    var request = http.Request('GET', Uri.parse('http://$globalIPAddress:3000/appointment'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      appointments = text;

      await getAppointmentStudent();

    }
    else {
    print(response.reasonPhrase);
    }
  }

  void _navigateToBookingDetails(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const BookingDetails()));
  }

  Future<void> _onDismissed(appointment, index) async {
    int bookID = appointment['bookID'];

    var request = http.Request(
        'DELETE', Uri.parse('http://$globalIPAddress:3000/book/facility/$bookID'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      setState(() => appointments.removeAt(index));

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
}
