import 'package:flutter/material.dart';
import 'package:inti/theme.dart';
import 'package:inti/variables.dart';

class OrderConfirm extends StatefulWidget {
  const OrderConfirm({Key? key}) : super(key: key);

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Order Successful', style: title,),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.check_circle,
                  color: Colors.green,
                  size: 100,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Thank you!', style: heading,),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Your Order ID is ', style: subHeading,),
                    Text('#' + globalOrderID.toString(), style: subHeadingBold,)
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Please make the payment at the counter', style: subHeading,),
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
                          _navigateToMenu(context);
                        },
                        child: Text(
                          'Back to Menu',
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
    );
  }
  void _navigateToMenu(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/menu', (Route<dynamic> route) => false);
  }
}
