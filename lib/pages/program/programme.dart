import 'package:flutter/material.dart';
import 'package:inti/data.dart';
import 'package:inti/pages/program/programDetails.dart';
import 'package:inti/pages/program/searchProgram.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class Programme extends StatefulWidget {
  const Programme({Key? key}) : super(key: key);

  @override
  State<Programme> createState() => _ProgrammeState();
}

class _ProgrammeState extends State<Programme> {
  int selectedCampus = -1;
  int selectedArea = -1;
  List areaOfStudy = [];
  List programme = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Programme',
            style: title
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _navigateToSearchProgram(context);
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
                child: Text("Campus",
                  style: heading,
                ),
              ),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: programmeData['campus']!.length,
                  itemBuilder: (context, index) {
                    return addCampus(
                        programmeData['campus']![index]);
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Area of Study",
                        style: heading,
                      ),
                    ),

                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.filter_list_outlined
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 20),
                child: SizedBox(
                  height: 20.0,
                  child: FutureBuilder(
                    future: addAreaOfStudyIntoList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: areaOfStudy.length,
                        itemBuilder: (context, index) {
                          return addAreaOfStudy(areaOfStudy[index]);
                        },
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Programme",
                  style: heading,
                ),
              ),
              FutureBuilder(
                future: addProgrammeIntoList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: programme.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            globalSelectedProgram = programme[index];
                            _navigateToProgramDetails(context);
                          },
                          child: Text(programme[index]['name'],
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addCampus(campus) {
    return SizedBox(
      width: 130,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedArea = -1;
            if (selectedCampus == campus["campusID"]) {
              selectedCampus = -1;
            } else {
              selectedCampus = campus["campusID"];
            }
          });
        },
        child: Card(
          color: selectedCampus != campus["campusID"]? Colors.white : Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset(
                  campus["image"],
                  height: 100,
                  width: 100,
                ),
                Expanded(
                  child: Text(campus["name"],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: selectedCampus != campus["campusID"]? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addAreaOfStudy(area) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedArea == area["areaID"]) {
            selectedArea = -1;
          } else {
            selectedArea = area["areaID"];
          }
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: 25.0),
        child: Container(
          padding: EdgeInsets.only(bottom: 1),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selectedArea != area["areaID"]? Colors.transparent : Colors.black,
                width: 1.0,
              ),
            ),
          ),
          child: Text(area["name"],
            style: TextStyle(
              fontSize: 14,
              fontWeight: selectedArea != area["areaID"]? null : FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  addAreaOfStudyIntoList() {
    areaOfStudy = [];
    if (selectedCampus == -1) {
      for (int i = 0; i < programmeData['areaOfStudy']!.length; i++) {
          areaOfStudy.add(programmeData['areaOfStudy']![i]);
      }
    } else {
      for (int i = 0; i < programmeData['areaOfStudy']!.length; i++) {
        if (selectedCampus == programmeData['areaOfStudy']![i]['campusID']) {
          areaOfStudy.add(programmeData['areaOfStudy']![i]);
        }
      }
    }
  }

  addProgrammeIntoList() {
    programme = [];
    if (selectedCampus == -1 && selectedArea == -1) {
      for (int i = 0; i < programmeData['programme']!.length; i++) {
        programme.add(programmeData['programme']![i]);
      }
    } else if (selectedCampus != -1 && selectedArea == -1){
      for (int i = 0; i < programmeData['programme']!.length; i++) {
        if (selectedCampus == programmeData['programme']![i]['campusID']) {
          programme.add(programmeData['programme']![i]);
        }
      }
    } else if (selectedCampus == -1 && selectedArea != -1) {
      for (int i = 0; i < programmeData['programme']!.length; i++) {
        if (selectedArea == programmeData['programme']![i]['areaID']) {
          programme.add(programmeData['programme']![i]);
        }
      }
    } else {
      for (int i = 0; i < programmeData['programme']!.length; i++) {
        if (selectedArea == programmeData['programme']![i]['areaID'] &&
            selectedCampus == programmeData['programme']![i]['campusID']) {
          programme.add(programmeData['programme']![i]);
        }
      }
    }
  }
  void _navigateToSearchProgram(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SearchProgram()));
  }
  void _navigateToProgramDetails(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ProgramDetails()));
  }
}