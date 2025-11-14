import 'package:flutter/material.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class HostelDetails extends StatefulWidget {
  const HostelDetails({Key? key}) : super(key: key);

  @override
  State<HostelDetails> createState() => _HostelDetailsState();
}

class _HostelDetailsState extends State<HostelDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
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
                      selectedHostel!,
                      style: title,
                    ),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  height: 150,
                  width: 250,
                  child: Image.asset(
                    selectedHostelImage!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text('\nRoom for Rent in Elite Height\n', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('- Rental by rooms (Mix unit)\n⭐⭐⭐WIFI AVAILABLE⭐⭐⭐\n- Rental by rooms (Mix unit)\n- Renovated\n- Time WiFi 500mbps\n- Only allow non-smoker'),
              Text(''),
              Text('Master room (private bathroom):\nFurniture provided (bed, table and chair, wardrobe)\nPrice included WiFi, water bill and electric bill. (water heater, induction cooker, water filter, refrigerator and washing machine)\nDeposit: 2.5 months'),
              Text(''),
              Text('- 5bedroom 4bathroom\n- Nice environment and facilities\n- Easy access to factory industrial zone\n- Near PISA, Elit Avenue, Promenade, Sunshine, One Precinct, Fiz, Restaurants, Airport, Inti Penang\n- Seven Eleven, 北投鱿鱼, Makbul, Kim Poh Roasted Chicken Rice, I Mum Mum Restaurant located downstairs'),
              Text(''),
              Text('Facilities:\n- 24hrs Security System\n- Gym\n- Swimming Pool\n- Playground\n- BBQ\n- Outdoor badminton\n- Car park available\n'),
              Card(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.phone, color: Colors.green,),
                    ),
                    Text('Contact Number: 016-666 0807 (Mr Poh)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
