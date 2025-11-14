import 'package:flutter/material.dart';

const primaryColor = Color(0xFFDA0011);
const backgroundColor = Color(0xFFF9F9F9);
const String google_api_key = "API KEY";

TextStyle get title{
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: backgroundColor
  );
}

TextStyle get heading{
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
}

TextStyle get subHeading{
  return const TextStyle(
    fontSize: 14,
  );
}

TextStyle get subHeadingBold{
  return const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get body{
  return const TextStyle(
    fontSize: 12,
  );
}

TextStyle get bodyBold{
  return const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get greyBody{
  return const TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );
}