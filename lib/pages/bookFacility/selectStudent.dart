import 'package:flutter/material.dart';
import 'dart:convert'; // json
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class SelectStudent extends StatefulWidget {
  const SelectStudent({Key? key}) : super(key: key);

  @override
  State<SelectStudent> createState() => _SelectStudentState();
}

class _SelectStudentState extends State<SelectStudent> {
  final nameController = TextEditingController();
  final studentIDController = TextEditingController();
  final searchController = TextEditingController();

  int unixTime = 0;
  DateTime? startDateTime;
  String? startTime;
  String? endTime;

  List students = [];
  List filterStudents = [];
  List selectedStudents = [];

  String bookID = "";

  @override
  void initState() {
    super.initState();
    getStudent();
    // put the date into the date into int unixTime
    unixTime = globalArrivalDate!;
    // convert int unix time into readable date time
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    startDateTime = dateTime;
    startTime = DateFormat.jm().format(dateTime);
    DateTime unformattedEndTime = dateTime.add(Duration(minutes: globalDuration!*60));
    endTime = DateFormat.jm().format(unformattedEndTime);
  }

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text('Select Student',
              style: title
          ),
          backgroundColor: primaryColor,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                nameController.clear();
                studentIDController.clear();
                addFriend();
              },
              icon: Icon(Icons.person_add
              ),
            ),
          ],
        ),
        body: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(2.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4), //shadow color
                        spreadRadius: 0.1, // spread radius
                        blurRadius: 1, // shadow blur radius
                        offset: const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: const Icon(Icons.search, color: Colors.grey,),
                      hintText: 'Search...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white10),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white10),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (query) => searchStudent(query),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filterStudents.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (filterStudents[index]['selected'] == false) {
                              filterStudents[index]['selected'] = true;
                            } else {
                              filterStudents[index]['selected'] = false;
                            }
                          });
                        },
                        child: studentCard(
                            filterStudents[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            selectedStudents = [];
            for(int i = 0; i < filterStudents.length; i++) {
              if (filterStudents[i]['selected'] == true) {
                selectedStudents.add(filterStudents[i]);
              }
            }
            if (selectedStudents.isNotEmpty) {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => buildSheet(),
              );
            }
          },
          label: Text('Next',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }

  Widget studentCard(student) {
    return Card(
      color: student['selected'] != true ? Colors.white : Colors.grey,
      child: ListTile(
        leading: student['image'] == "" ? CircleAvatar(
          radius: 24,
          child: Icon(Icons.person),
        ) : CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(
            student['image'],
          ),
        ),
        title: Text(student['name']),
        subtitle: Text(student['studentID']),
      ),
    );
  }

  Widget makeDismissible({required Widget child}) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () => Navigator.of(context).pop(),
    child: GestureDetector(onTap: () {}, child: child),
  );

  Widget buildSheet() => makeDismissible(
    child: DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.7,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: Colors.black,)
            ),

            Center(
              child: Column(
                children: [
                  Image.asset('assets/confirmation.png', scale: 3.3,),
                  Text('Booking Confirmation',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),


            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('Location',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          5.0),
                                      child: Container(
                                        height: 50.0,
                                        width: 50.0,
                                        color: Colors.black,
                                        child: FittedBox(
                                          child: Image.asset(
                                            globalFacility['image'],
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(globalFacility['name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('Date',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    Text(DateFormat('dd MMM yyyy (EEE)')
                                        .format(startDateTime!),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('Time',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(startTime.toString() + ' - ' +
                                    endTime.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('Student',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: selectedStudents.length,
                                  itemBuilder: (context, index) {
                                    return displaySelectedStudent(selectedStudents[index]);
                                  }
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
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
                          createAppointment();
                          globalSelectedStudents = selectedStudents;
                        },
                        child: Text('CONFIRM BOOKING',
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
  );

  Widget displaySelectedStudent(student) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 8.0),
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
            padding: const EdgeInsets.all(
                8.0),
            child: Text(student['name'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future addFriend() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Add Friend', style: title),
      content: Wrap(
        children: [
          enterStudentName('Name', 'Enter Name', nameController),
          enterStudentID('Student ID', 'Enter Student ID', 9, 9, studentIDController),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            submit(studentIDController.text, nameController.text);
          },
          child: const Text('SUBMIT', style: TextStyle(color: primaryColor)),
        ),
      ],
    ),
  );

  submit(studentID, name) async {
    var request = http.Request('POST', Uri.parse('http://$globalIPAddress:3000/add/students'));
    request.bodyFields = {
      'studentID': studentID,
      'name': name
    };
    request.headers.addAll(_buildHeaders(contentType: 'application/x-www-form-urlencoded'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      getStudent();
    }
    else {
    print(response.reasonPhrase);
    }
  }

  Widget enterStudentName(String title, String hintText, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: heading),

          TextFormField(
            focusNode: FocusNode(),
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
                hintText: hintText
            ),
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Can\'t be empty';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
  Widget enterStudentID(String title, String hintText, int maxNumber, int minNumber, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(title, style: heading),

          TextFormField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 2),
              ),
              hintText: hintText,
              counterText: "",),
            maxLength: maxNumber,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Can\'t be empty';
              }
              if (text.length < minNumber) {
                return 'Too short';
              }
              return null;
            },
          ),

        ],
      ),
    );
  }

  void searchStudent(String query) {
    setState(() {
      filterStudents = students.where((student) => student['name']!.toLowerCase().contains(query.toLowerCase()) ||
          student['studentID'].toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  getStudent() async {
    var request = http.Request('GET', Uri.parse('http://$globalIPAddress:3000/students'));
    request.headers.addAll(_buildHeaders(contentType: 'application/json'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      setState(() {
        students = text;
      });

      filterStudents = students;

      for(int i = 0; i < students.length; i++) {
        selectedStudents.add(filterStudents);
      }

    }
    else {
    print(response.reasonPhrase);
    }
  }

  createAppointment() async {
    var request = http.Request('POST', Uri.parse('http://$globalIPAddress:3000/book/facility'));
    request.bodyFields = {
      'locationID': globalFacility['locationID'].toString(),
      'arrivalDate': globalArrivalDate.toString(),
      'duration': (globalDuration!*60).toString(),
    };
    request.headers.addAll(_buildHeaders(contentType: 'application/x-www-form-urlencoded'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      bookID = text['bookID'].toString();

      for(int i = 0; i < selectedStudents.length; i++) {
        addAppointmentStudents(selectedStudents[i]['studentID'].toString());
      }

      _navigateToConfirmation(context);

      if (globalDuration == 1) {
        blockDate(globalArrivalDate);
      } else {
        blockDate(globalArrivalDate);
        blockDate(globalArrivalDate!+3600);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  blockDate(arrivalDate) async {
    var request = http.Request('PUT', Uri.parse('http://$globalIPAddress:3000/timeslots/$arrivalDate'));
    request.bodyFields = {
      'blockDate': '1'
    };
    request.headers.addAll(_buildHeaders(contentType: 'application/x-www-form-urlencoded'));

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

  addAppointmentStudents(studentID) async {
    var request = http.Request('POST', Uri.parse('http://$globalIPAddress:3000/book/students'));
    request.bodyFields = {
      'bookID': bookID,
      'studentID': studentID
    };
    request.headers.addAll(_buildHeaders(contentType: 'application/x-www-form-urlencoded'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      json.decode(decode);

    }
    else {
    print(response.reasonPhrase);
    }
  }
  void _navigateToConfirmation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/bookingConfirmation', (Route<dynamic> route) => false);
  }
}
