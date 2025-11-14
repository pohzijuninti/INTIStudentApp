import 'package:flutter/material.dart';
import 'package:inti/data.dart';
import 'package:inti/pages/orderFood/cart.dart';
import 'package:inti/pages/orderFood/foodDetails.dart';
import 'package:inti/pages/orderFood/orderHistory.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  var foodList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil('/mainPage', (Route<dynamic> route) => false);
                          },
                          icon: Icon(Icons.arrow_back_ios_new)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cafeteria',
                          style: title,
                        ),
                      ),
                    ],
                  ),

                  IconButton(
                      onPressed: () {
                        _navigateToOrderHistory(context);
                      },
                      icon: Icon(Icons.history)
                  ),
                ],
              ),


              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: foodCategory.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(foodCategory[index]['name'].toString(),
                            style: heading,
                          ),
                        ),

                        SizedBox(
                          height: 150,
                          child: FutureBuilder(
                              future: addFoodIntoList(foodCategory[index]),
                              builder: (context, snapshot) {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: foodList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return displayFood(foodList[index]);
                                    }
                                );
                              }
                          ),
                        ),
                      ],
                    );
                  }
                ),
              ),
              globalCart.length != 0 ? SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: EdgeInsets.symmetric(vertical: globalCart.length != 0 ? 10: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                        ),
                        onPressed: () {
                          // Navigator.pop(context);
                          _navigateToCart(context);
                          print(globalCart);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.shopping_cart),
                            Text('View Cart', style: heading,),
                            globalCart.length != 0 ? Container(
                              color: Colors.red[900],
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(globalCart.length.toString(),
                                    style: heading),
                              ),
                            ) : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ) : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
  displayFood(food) {
    return GestureDetector(
      onTap: () {
        globalSelectedFood = food;
        _navigateToFoodDetails(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 8.0),
        child: SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            children:[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 85,
                    width: 85,
                    child: Image.asset(
                      food['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(child: Text(food['name'], textAlign: TextAlign.center,)),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 50,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  height: 18,
                  width: 80,
                  child: Center(
                    child: Text("RM " + food['price'].toStringAsFixed(2),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
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
    );
  }
  void _navigateToFoodDetails(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const FoodDetails()));
  }

  void _navigateToCart(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Cart()));
  }

  void _navigateToOrderHistory(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const OrderHistory()));
  }

  addFoodIntoList(foodCategory) {
    foodList = [];
    for (int i = 0; i < foodData.length; i++) {
      if (foodData[i]['foodCategoryID'] == foodCategory['foodCategoryID'])
      foodList.add(foodData[i]);
    }
  }
}
