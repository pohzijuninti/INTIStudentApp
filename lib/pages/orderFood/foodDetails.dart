import 'package:flutter/material.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class FoodDetails extends StatefulWidget {
  const FoodDetails({Key? key}) : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {

  TextEditingController quantityController = TextEditingController();

  int quantity = 1;

  @override
  void initState() {
    super.initState();
    quantityController.text = quantity.toString();
    quantity = 1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                          globalSelectedFood['name'],
                          style: title,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        height: 250,
                        width: 400,
                        child: Image.asset(globalSelectedFood['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          height: 40,
                          width: 120,
                          child: Center(
                            child: Text("RM " + globalSelectedFood['price'].toStringAsFixed(2),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Fragrant rice cooked in coconut milk and pandan leaf, served with ikan bilis and eggs.',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 35.0,
                      width: 150,
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
                                  quantity--;
                                  quantityController.text = quantity.toString();
                                }
                              });
                            },
                            child: const Icon(Icons.remove),
                          ),

                          SizedBox(
                            width: 30.0,
                            child: TextField(
                              inputFormatters: [
                                // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                              keyboardType: TextInputType.number,
                              maxLines: null,
                              maxLength: 2,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(bottom: 12.0),
                                counterText: "",
                              ),
                              controller: quantityController,
                              onChanged: (value) {
                                if (value!=0) {
                                  setState(() {
                                    quantity = int.parse(value);
                                  });
                                }
                              },
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                                quantityController.text = quantity.toString();
                              });
                            },
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: SizedBox.shrink()
                  ),

                  SafeArea(
                    child: Row(
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
                              addItemToCart();
                              _navigateToMenu(context);
                              print(globalCart);
                            },
                            child: Text('Add To Cart',
                              style: heading,
                            ),
                          ),
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
  addItemToCart() {
    bool added = false;
    if (globalCart.isNotEmpty) {
      for (int i = 0; i < globalCart.length; i++) {
        if (globalCart[i]["foodID"] == globalSelectedFood['foodID']) {
          globalCart[i]["quantity"] += quantity;
          added = true;
        }
      }
      if (added == false) {
        globalCart.add({"foodID": globalSelectedFood['foodID'], "quantity": quantity,});
      }
    } else {
      globalCart.add({"foodID": globalSelectedFood['foodID'], "quantity": quantity,});
    }

  }
  void _navigateToMenu(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/menu', (Route<dynamic> route) => false);
  }
}
