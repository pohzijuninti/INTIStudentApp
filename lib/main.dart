import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inti/pages/bookFacility/confirmation.dart';
import 'package:inti/pages/login/login.dart';
import 'package:inti/pages/mainPage/mainPage.dart';
import 'package:inti/pages/login/server.dart';
import 'package:inti/pages/bookFacility/selectFacility.dart';
import 'package:inti/pages/orderFood/orderConfirm.dart';
import 'package:inti/pages/orderFood/menu.dart';
import 'package:inti/theme.dart';

void main() => runApp(const INTI());

class INTI extends StatelessWidget {
  const INTI({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      theme: ThemeData(
        focusColor: primaryColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
          )
        ),
        primarySwatch: primaryBlack,
      ),
      debugShowCheckedModeBanner: false,
      home: Server(),
      routes: {
        '/login': (context) => const Login(),
        '/mainPage': (context) => const MainPage(),
        '/facility': (context) => const Facility(),
        '/bookingConfirmation': (context) => const Confirmation(),
        '/menu': (context) => const Menu(),
        '/orderConfirm': (context) => const OrderConfirm(),
      },
    );
  }
}

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;
