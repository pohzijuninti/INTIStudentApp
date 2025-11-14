import 'package:flutter/material.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class ShuttleBusDetails extends StatefulWidget {
  const ShuttleBusDetails({Key? key}) : super(key: key);

  @override
  State<ShuttleBusDetails> createState() => _ShuttleBusDetailsState();
}

class _ShuttleBusDetailsState extends State<ShuttleBusDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                      selectedRoute!,
                      style: title,
                    ),
                  ),
                ],
              ),
              Container(
                width: 400,
                color: Colors.red,
                child: Image.asset(
                  "assets/routeA.png",
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Image.asset(
                      "assets/googleMap.png",
                      fit: BoxFit.fill,
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
}

