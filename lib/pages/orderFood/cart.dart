import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:convert'; // json
import 'package:http/http.dart' as http;
import 'package:inti/data.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int orderID = 0;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            _navigateToMenu(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cart',
                          style: title,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: globalCart.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        extentRatio: 0.3,
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            borderRadius:
                            BorderRadius.circular(2.0),
                            autoClose: true,
                            backgroundColor: primaryColor,
                            icon: Icons.delete_outline,
                            label: 'Delete',
                            onPressed: (context) {
                              setState(() => globalCart.removeAt(index));
                              if (globalCart.length == 0) {
                                _navigateToMenu(context);
                              }
                            },
                          ),
                        ],
                      ),
                      child: displayFoodInCart(globalCart[index], index),
                    );
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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => CupertinoAlertDialog(
                                  title: const Text('Confirmation'),
                                  content: const Text('Are you sure you want make the order?'),
                                  actions: [
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        makeOrder();
                                      },
                                      isDefaultAction: true,
                                      child: const Text('Yes', style: TextStyle(color: Colors.blue),),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text('Place Order',
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
    );
  }
  Widget displayTotal() {

    double? total = 0;

    for (int i = 0; i < globalCart.length; i++) {
      for (int j = 0; j < foodData.length; j++) {
        if (globalCart[i]['foodID'] == foodData[j]['foodID']) {
          total = (total! + double.parse(foodData[j]['price'].toString()) * globalCart[i]['quantity'])!;
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

  displayFoodInCart(food, index) {
    String? image = "";
    String? name = "";
    double? price = 0.0;
    double total = 0;
    final quantityController = TextEditingController();

    quantityController.text = food["quantity"].toString();

    for (int i = 0; i < foodData.length; i++) {
      if (food["foodID"] == foodData[i]["foodID"]) {
        image = foodData[i]["image"].toString();
        name = foodData[i]["name"].toString();
        price = double.parse(foodData[i]["price"].toString());
      }
    }
    total = (price! * food["quantity"])!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(image!, fit: BoxFit.cover,),
              ),
            ),
            Expanded(
              flex: 3,
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
                    Text("RM " + price!.toStringAsFixed(2), style: TextStyle(fontSize: 12),),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 35.0,
                width: 65,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.1),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if(int.parse(quantityController.text) > 1) {
                            food["quantity"]--;
                            quantityController.text = food["quantity"].toString();
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => CupertinoAlertDialog(
                                content: const Text('Do you want to remove this item?'),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      setState(() => globalCart.removeAt(index));
                                      Navigator.pop(context);
                                      if (globalCart.length == 0) {
                                        _navigateToMenu(context);
                                      }
                                      // _navigateToLogin(context);
                                    },
                                    isDefaultAction: true,
                                    child: const Text('Yes', style: TextStyle(color: Colors.blue),),
                                  ),
                                ],
                              ),
                            );
                          }


                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: const Icon(Icons.remove, size: 12,),
                      ),
                    ),

                    SizedBox(
                      width: 20.0,
                      child: Text(quantityController.text, textAlign: TextAlign.center,),),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          food["quantity"]++;
                          quantityController.text = food["quantity"].toString();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: const Icon(Icons.add, size: 12,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
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
  makeOrder() async {
    int date = 0;
    date = (DateTime.now().millisecondsSinceEpoch / 1000).toInt();
    var request = http.Request('POST', Uri.parse('http://$globalIPAddress:3000/add/order'));
    request.bodyFields = {
      'date': date.toString(),
    };
    request.headers.addAll(_buildHeaders(contentType: 'application/x-www-form-urlencoded'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      orderID = text["orderID"];
      // print(text["orderID"]);
      for (int i = 0; i < globalCart.length; i++) {
        addFoodOrder(orderID, globalCart[i]);
      }
      globalOrderID = orderID;
      globalCart = [];
      _navigateToOrderConfirm(context);
    }
    else {
    print(response.reasonPhrase);
    }
  }
  addFoodOrder(orderID, food) async {
    var request = http.Request('POST', Uri.parse('http://$globalIPAddress:3000/order/food'));
    request.bodyFields = {
      'orderID': orderID.toString(),
      'foodID': food["foodID"].toString(),
      'quantity': food["quantity"].toString()
    };
    request.headers.addAll(_buildHeaders(contentType: 'application/x-www-form-urlencoded'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var decode = await response.stream.bytesToString();

      var text = json.decode(decode);

      // print(text);
    }
    else {
    print(response.reasonPhrase);
    }
  }
  void _navigateToMenu(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/menu', (Route<dynamic> route) => false);
  }
  void _navigateToOrderConfirm(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/orderConfirm', (Route<dynamic> route) => false);
  }
}
