import 'package:flutter/material.dart';
import 'package:inti/data.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Order Details', style: title,)),

                ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
                      child: displayOrderRecord(),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Food', style: heading,),
                ),


                Expanded(
                  child: ListView.builder(
                    itemCount: globalFoods.length,
                    itemBuilder: (BuildContext context, int index) {
                      return displayFoods(index, globalFoods[index]);
                    },
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      displayTotal(),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Back',
                                style: heading,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget displayTotal() {

    double? total = 0;

    for (int i = 0; i < globalFoods.length; i++) {
      for (int j = 0; j < foodData.length; j++) {
        if (globalFoods[i]['foodID'] == foodData[j]['foodID']) {
          total = (total! + double.parse(foodData[j]['price'].toString()) * globalFoods[i]['quantity'])!;
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('TOTAL', style: heading,),
          Text('RM ' + total!.toStringAsFixed(2), style: heading,),
        ],
      ),
    );
  }

  Widget displayOrderRecord() {
    var date = DateTime.fromMillisecondsSinceEpoch(globalOrder['date'] * 1000);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order ID', style: heading,),
                Text('Date', style: heading,),
                Text('Time', style: heading,),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(': ', style: heading,),
                Text(': ', style: heading,),
                Text(': ', style: heading,),
              ],
            ),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('#' + globalOrder['orderID'].toString(), style: heading,),
            Text(DateFormat('dd MMM yyyy').format(date).toString(), style: heading,),
            Text(DateFormat('hh:mm a').format(date).toString(), style: heading,),
          ],
        ),
      ],
    );
  }

  Widget displayFoods(index, food) {
    String? image = "";
    String? name = "";
    double? price = 0.0;
    double total = 0;

    for (int i = 0; i < foodData.length; i++) {
      if (food["foodID"] == foodData[i]["foodID"]) {
        image = foodData[i]["image"].toString();
        name = foodData[i]["name"].toString();
        price = double.parse(foodData[i]["price"].toString());
      }
    }
    total = (price! * food["quantity"])!;
    index++;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(index.toString() + ".", style: bodyBold,),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(image!, fit: BoxFit.cover,),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("RM " + price!.toStringAsFixed(2)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0,),
                    child: Text(food["quantity"].toString()),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("RM " + total!.toStringAsFixed(2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
