import 'package:flutter/material.dart';
import 'package:inti/data.dart';
import 'package:inti/pages/Lecturer/lecturerDetails.dart';
import 'package:inti/pages/Lecturer/searchLecturer.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class Lecturer extends StatefulWidget {
  const Lecturer({Key? key}) : super(key: key);

  @override
  State<Lecturer> createState() => _LecturerState();
}

class _LecturerState extends State<Lecturer> {
  @override

  var selectedFaculty = -1;
  List lecturers = [];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Lecturer',
            style: title
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _navigateToSearchLecturer(context);
            },
            icon: Icon(Icons.search),
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
          padding: EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Faculty",
                  style: heading,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 20),
                child: SizedBox(
                  height: 20,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: faculty.length,
                    itemBuilder: (context, index) {
                      return displayFaculty(faculty[index]);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Lecturer",
                  style: heading,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text('Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('Extension',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('Contact No',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: addLecturerIntoList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: lecturers.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          globalSelectedLecturer = lecturers[index];
                          _navigateToLecturerDetails(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Text(lecturers[index]['name'].toString())
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(lecturers[index]['extension'].toString())
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text(lecturers[index]['contactNo'].toString())
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget displayFaculty(faculty) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedFaculty == faculty["facultyID"]) {
            selectedFaculty = -1;
          } else {
            selectedFaculty = faculty["facultyID"];
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Container(
          padding: EdgeInsets.only(bottom: 1),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selectedFaculty != faculty["facultyID"]? Colors.transparent : Colors.black,
                width: 1.0,
              ),
            ),
          ),
          child: Text(faculty["name"],
            style: TextStyle(
              fontSize: 14,
              fontWeight: selectedFaculty != faculty["facultyID"]? null : FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  addLecturerIntoList() {
    lecturers = [];
    if (selectedFaculty == -1) {
      for (int i = 0; i < lecturer.length; i++) {
        lecturers.add(lecturer[i]);
      }
    } else {
      for (int i = 0; i < lecturer.length; i++) {
        if (selectedFaculty == lecturer[i]['facultyID']) {
          lecturers.add(lecturer[i]);
        }
      }
    }
  }
  void _navigateToSearchLecturer(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SearchLecturer()));
  }
  void _navigateToLecturerDetails(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LecturerDetails()));
  }
}
