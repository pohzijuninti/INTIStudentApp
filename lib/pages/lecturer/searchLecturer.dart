import 'package:flutter/material.dart';
import 'package:inti/data.dart';
import 'package:inti/pages/Lecturer/lecturerDetails.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class SearchLecturer extends StatefulWidget {
  const SearchLecturer({Key? key}) : super(key: key);

  @override
  State<SearchLecturer> createState() => _SearchLecturerState();
}

class _SearchLecturerState extends State<SearchLecturer> {
  final searchController = TextEditingController();
  List lecturers = [];
  List filterLecturers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addLecturerIntoList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text('Search Lecturer',
              style: title
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
                    onChanged: (query) => searchLecturer(query),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filterLecturers.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          globalSelectedLecturer = filterLecturers[index];
                          Navigator.pop(context);
                          _navigateToLecturerDetails(context);
                        },
                        child: displayLecturer(
                            filterLecturers[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );;
  }

  void searchLecturer(String query) {
    setState(() {
      filterLecturers = lecturers.where((lecturer) => lecturer['name']!.toLowerCase().contains(query.toLowerCase()) ||
          lecturer['extension'].toString().toLowerCase().contains(query.toLowerCase()) ||
          lecturer['contactNo'].toString().toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  Widget displayLecturer(lecturer) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          child: Icon(Icons.person),
        ),
        title: Text(lecturer['name']),
        subtitle: Text(lecturer['contactNo'].toString() + " " + lecturer['extension'].toString()),
      ),
    );
  }
  addLecturerIntoList() {
    lecturers = [];
    for (int i = 0; i < lecturer.length; i++) {
      lecturers.add(lecturer[i]);
    }
    filterLecturers = lecturers;
  }
  void _navigateToLecturerDetails(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LecturerDetails()));
  }
}
