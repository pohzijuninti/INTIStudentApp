import 'package:flutter/material.dart';
import 'package:inti/data.dart';
import 'package:inti/pages/program/programDetails.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class SearchProgram extends StatefulWidget {
  const SearchProgram({Key? key}) : super(key: key);

  @override
  State<SearchProgram> createState() => _SearchProgramState();
}

class _SearchProgramState extends State<SearchProgram> {
  final searchController = TextEditingController();
  List programs = [];
  List filterPrograms = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addProgramIntoList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text('Search Programme',
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
                    onChanged: (query) => searchProgram(query),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filterPrograms.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          globalSelectedProgram = filterPrograms[index];
                          Navigator.pop(context);
                          _navigateToProgramDetails(context);
                        },
                        child: displayProgram(
                            filterPrograms[index]),
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
  void searchProgram(String query) {
    setState(() {
      filterPrograms = programs.where((program) => program['name']!.toLowerCase().contains(query.toLowerCase()) ||
          program['programmeID'].toString().toLowerCase().contains(query.toLowerCase())).toList();
    });
  }
  addProgramIntoList() {
    programs = [];
    for (int i = 0; i < programmeData['programme']!.length; i++) {
      programs.add(programmeData['programme']![i]);
    }
    filterPrograms = programs;
  }
  Widget displayProgram(program) {
    return Card(
      child: ListTile(
        title: Text(program['name']),
      ),
    );
  }
  void _navigateToProgramDetails(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ProgramDetails()));
  }
}
