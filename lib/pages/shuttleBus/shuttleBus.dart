import 'package:flutter/material.dart';
import 'package:inti/pages/shuttleBus/shuttleBusDetails.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';
// import 'package:inti/pages/shuttleBus/map.dart';

class ShuttleBus extends StatefulWidget {
  const ShuttleBus({Key? key}) : super(key: key);

  @override
  State<ShuttleBus> createState() => _ShuttleBusState();
}

const busStops = [
  {
    "busStopID": 9001,
    "name": "Hostel",
    "image": "assets/hostel.png",
  },
  {
    "busStopID": 9003,
    "name": "Sungai Ara",
    "image": "assets/sungaiara.png",
  },
  {
    "busStopID": 9004,
    "name": "Green Lane",
    "image": "assets/greenlane.jpeg",
  },
];

class _ShuttleBusState extends State<ShuttleBus> {
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
                      'Shuttle Bus',
                      style: title,
                    ),
                  ),
                ],
              ),
              displayBusStop(busStops[0]),
              displayBusStop(busStops[1]),
              displayBusStop(busStops[2]),
            ],
          ),
        ),
      ),
    );
  }
  Widget displayBusStop(busStop) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                _navigateToShuttleBusDetails(context);
                selectedRoute = busStop['name'];
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            busStop['image'],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        height: 30,
                        width: 383,
                        color: Colors.black54,
                        child: Center(
                          child: Text(busStop['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _navigateToShuttleBusDetails(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const ShuttleBusDetails()));
  }
}
