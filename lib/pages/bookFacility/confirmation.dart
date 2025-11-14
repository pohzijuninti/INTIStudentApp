import 'package:flutter/material.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';
import 'package:intl/intl.dart';

class Confirmation extends StatefulWidget {
  const Confirmation({Key? key}) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  DateTime startDateTime = DateTime.now();
  int unixTime = 0;
  String startTime = "";
  String endTime = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    unixTime = globalArrivalDate;
    // convert int unix time into readable date time
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    startDateTime = dateTime;
    startTime = DateFormat.jm().format(dateTime);
    DateTime unformattedEndTime =
    dateTime.add(Duration(minutes: globalDuration*60));
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
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.check_circle,
                        color: Colors.green,
                        size: 150.0,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Booking Confirmed for',
                          style: title,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          color: Colors.black,
                          child: FittedBox(
                            child: Image.asset(
                              globalFacility['image'],
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(globalFacility['name'],
                          style: title
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
                        Text(DateFormat('dd MMM yyyy (EEEEE)').format(startDateTime!),
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
                        Text(startTime.toString().toLowerCase() + ' to ' +
                            endTime.toString().toLowerCase(),
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

                    ListView.builder(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: globalSelectedStudents.length,
                      itemBuilder: (context, index) {
                        return displayStudents(globalSelectedStudents[index]);
                      }
                    ),

                  ],
                ),
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
                          _navigateToFacility(context);
                        },
                        child: Text('DONE',
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
  displayStudents(student) {
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
  void _navigateToFacility(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/facility', (Route<dynamic> route) => false);
  }
}
