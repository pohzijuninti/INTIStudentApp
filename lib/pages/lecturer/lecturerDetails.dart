import 'package:flutter/material.dart';
import 'package:inti/data.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class LecturerDetails extends StatefulWidget {
  const LecturerDetails({Key? key}) : super(key: key);

  @override
  State<LecturerDetails> createState() => _LecturerDetailsState();
}

class _LecturerDetailsState extends State<LecturerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new)
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(globalSelectedLecturer['name'], style: title,),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50,),
                ),
              ),
              displayFaculty(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Office Extension: ' + globalSelectedLecturer['extension'].toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Contact No: ' + globalSelectedLecturer['contactNo'].toString()),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Email: asvhini.subramaniam@newinti.edu.my'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget displayFaculty() {
    String facultyName = "";
    for (int i = 0; i < faculty.length; i ++) {
      if (globalSelectedLecturer['facultyID'] == faculty[i]['facultyID']) {
        facultyName = faculty[i]['name'].toString();
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(facultyName, style: heading,),
    );
  }
}
