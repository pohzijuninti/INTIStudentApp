import 'package:flutter/material.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {

  // late int selectedLevel;
  // String image = "";
  // String level = "Level 2";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (selectedLevel == null) {
      selectedLevel = 2;
      image = "assets/level2.jpg";
      level = "Level 2";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                level!,
                style: title,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InteractiveViewer(
                      boundaryMargin: EdgeInsets.all(double.infinity),
                      child: Image.asset(
                        image!,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      addButton('L7', 7, "assets/level5.jpg", "Level 7"),
                      addButton('L6', 6, "assets/level5.jpg", "Level 6"),
                      addButton('L5', 5, "assets/level5.jpg", "Level 5"),
                      addButton('L4', 4, "assets/level5.jpg", "Level 4"),
                      addButton('L3', 3, "assets/level5.jpg", "Level 3"),
                      addButton('L2', 2, "assets/level2.jpg", "Level 2"),
                      addButton('L1', 1, "assets/level2.jpg", "Level 1"),
                      addButton('LG', 0, "assets/level2.jpg", "Level G"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget addButton(String L, int index, String picture, String lvl) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedLevel == index ? Colors.grey[600] : primaryColor,
      ),
      onPressed: () {
        setState(() {
          selectedLevel = index;
          image = picture;
          level = lvl;
        });
      },
      child: Text(L),
    );
  }
}

