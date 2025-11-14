import 'package:flutter/material.dart';
import 'package:inti/theme.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Timetable',
                      style: title,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: InteractiveViewer(
                  boundaryMargin: EdgeInsets.all(double.infinity),
                  child: Image.asset(
                    "assets/timetable.JPG",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
