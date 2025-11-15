import 'dart:convert'; // json
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inti/pages/bookFacility/selectStudent.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateTime extends StatefulWidget {
  const SelectDateTime({Key? key}) : super(key: key);

  @override
  State<SelectDateTime> createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  DateTime _selectedDate = DateTime.now();
  String selectedTime = "";
  var timeList = [];
  var appointmentHour = [];
  var slot = [];

  // build headers including token when available
  Map<String, String> _buildHeaders({String contentType = 'application/json'}) {
    final headers = <String, String>{'Content-Type': contentType};
    if (globalToken != null && globalToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $globalToken';
    }
    return headers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                color: primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            globalFacility['name'].toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          globalDuration == 1
                              ? Text(
                                  globalDuration.toString() + ' hour',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  globalDuration.toString() + ' hours',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Select Date',
                  style: title,
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TableCalendar(
                    rowHeight: 35,
                    calendarStyle: CalendarStyle(
                      outsideTextStyle:
                          TextStyle(fontSize: 14, color: Colors.grey),
                      disabledTextStyle:
                          TextStyle(fontSize: 14, color: Colors.grey),
                      weekendTextStyle: TextStyle(
                        fontSize: 14,
                      ),
                      selectedTextStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      defaultTextStyle: TextStyle(
                        fontSize: 14,
                      ),
                      isTodayHighlighted: false,
                      selectedDecoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      rightChevronVisible: true,
                      leftChevronVisible: true,
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    availableGestures: AvailableGestures.all,
                    selectedDayPredicate: (day) =>
                        isSameDay(day, _selectedDate),
                    focusedDay: _selectedDate,
                    firstDay: DateTime.now(),
                    lastDay: DateTime.utc(2100, 1, 1),
                    onDaySelected: _onDaySelected,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Select Time',
                  style: title,
                ),
              ),
              SizedBox(
                height: 170,
                width: 400,
                child: FutureBuilder(
                    future: getTimeSlot(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitFadingCircle(
                            color: Colors.grey,
                            size: 30.0,
                          ),
                        );
                      } else {
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height / 5),
                            ),
                            itemCount: appointmentHour.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    top: 5, bottom: 10, left: 10, right: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        appointmentHour[index]['slotDate'].toString() == selectedTime
                                            ? primaryColor
                                            : Colors.grey,
                                  ),
                                  onPressed: slot[index] || DateTime.now().millisecondsSinceEpoch/1000 > appointmentHour[index]['slotDate']
                                      ? null
                                      : () {
                                          setState(() {
                                            if (selectedTime ==
                                                appointmentHour[index]['slotDate'].toString()) {
                                              selectedTime = "";
                                            } else {
                                              selectedTime = appointmentHour[index]['slotDate'].toString();
                                            }
                                          });
                                        },
                                  child: Text(DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(timeList[index]['slotDate']*1000)), style: body),
                                ),
                              );
                            });
                      }
                    }),
              ),
              SafeArea(
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
                          if (selectedTime != "") {
                            globalArrivalDate = int.parse(selectedTime);
                            _navigateToSelectStudent(context);
                          }
                        },
                        child: Text(
                          'Next',
                          style: heading,
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

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _selectedDate = day;
      selectedTime = "";
    });
  }

  Future<void> filterTimeSlot() async {
    appointmentHour = [];
    DateTime startTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, 7, 45);
    DateTime endTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, 16, 15);

    for (int i = 0; i < timeList.length; i++) {
      int unixTime = timeList[i]['slotDate'];
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);

      if (dateTime.isAfter(startTime) && dateTime.isBefore(endTime)) {
        appointmentHour.add(timeList[i]);
      }
    }

    List temp = [];
    int gap = 0;
    for (int i = appointmentHour.length - 1; i >= 0; i--) {
      if (appointmentHour[i]["blockDate"] == 0) {
        gap += 60;
      } else {
        gap = 0;
      }
      if (gap >= globalDuration! * 60) {
        temp.add(false);
      } else {
        temp.add(true);
      }
    }
    slot = temp.reversed.toList();
  }

  Future<void> getTimeSlot() async {
    String selectedDate = _selectedDate.toString().substring(0,10);

    var request = http.Request(
        'GET', Uri.parse('http://$globalIPAddress:3000/time_slots/$selectedDate'));
    request.headers.addAll(_buildHeaders(contentType: 'application/json'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      timeList = text['slots'];

      filterTimeSlot();

    } else {
      print(response.reasonPhrase);
    }
  }

  void _navigateToSelectStudent(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SelectStudent()));
  }
}
