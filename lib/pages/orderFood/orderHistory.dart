import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // json
import 'package:http/http.dart' as http;
import 'package:inti/pages/orderFood/orderDetails.dart';
import 'package:inti/variables.dart';
import 'package:intl/intl.dart';
import 'package:inti/data.dart';
import 'package:inti/theme.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  var orders = [];
  var foodOrder = [];

  // build headers including token when available
  Map<String, String> _buildHeaders({String contentType = 'application/json'}) {
    final headers = <String, String>{'Content-Type': contentType};
    if (globalToken != null && globalToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $globalToken';
    }
    return headers;
  }

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
                  Text('Order History', style: title,),
                ],
              ),
              FutureBuilder(
                  future: getOrder(),
                  builder: (context, snapshot) {
                    return Expanded(
                      child: orders.length == 0 ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.history, size: 60,),
                          Text('No Order History', style: heading,),
                        ],
                      ) : ListView.builder(
                        itemCount: orders.length,
                          itemBuilder: (context, index) {
                          return displayOrderHistory(orders[index]);
                        }
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget displayOrderHistory(order) {
    String? image = "";
    String? name = "";

    var date = DateTime.fromMillisecondsSinceEpoch(order['date'] * 1000);

    bool first = false;
    List foods = [];
    List names = [];

    double? total = 0;

    for (int i = 0; i < foodOrder.length; i++) {
      if(order['orderID'] == foodOrder[i]['orderID']) {
        foods.add(foodOrder[i]);
      }
    }

    for (int i = 0; i < foods.length; i++) {
      for (int j = 0; j < foodData.length; j++) {
        if(foods[i]['foodID'] == foodData[j]['foodID']) {
          names.add(foodData[j]['name']);
          if (!first) {
            image = foodData[j]['image'].toString();
            first = !first;
          }
        }
      }
    }

    for (int i = 0; i < foods.length; i++) {
      for (int j = 0; j < foodData.length; j++) {
        if (foods[i]['foodID'] == foodData[j]['foodID']) {
          total = (total! + double.parse(foodData[j]['price'].toString()) *
              foods[i]['quantity'])!;
        }
      }
    }

    name = names.join(", ");

    return GestureDetector(
      onTap: () {
        _navigateToOrderDetails(context);
        globalOrder = order;
        globalFoods = foods;
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 85,
                  width: 85,
                  child: Image.asset(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order ID #' + order['orderID'].toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(DateFormat('dd MMM yyyy hh:mm a').format(date).toString(), ),
                    ),
                    Text(name),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text('RM ' + total!.toStringAsFixed(2),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getOrder() async {
    var request = http.Request('GET', Uri.parse('http://$globalIPAddress:3000/order'));
    request.headers.addAll(_buildHeaders(contentType: 'application/json'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      // print(text);

      orders = text.reversed.toList();;

      await getFoodOrder();
    }
    else {
    print(response.reasonPhrase);
    }

  }
  getFoodOrder() async {
    var request = http.Request('GET', Uri.parse('http://$globalIPAddress:3000/food/order'));
    request.headers.addAll(_buildHeaders(contentType: 'application/json'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      foodOrder = text;
      // print(text);
    }
    else {
    print(response.reasonPhrase);
    }
  }
  void _navigateToOrderDetails(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const OrderDetails()));
  }
}
