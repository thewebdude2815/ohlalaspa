import 'package:flutter/material.dart';

Color mainAppColor = const Color(0xFF7B3AAD);

LinearGradient gradientColor = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF7B3AAD),
      Color(0xFF652D90),
      Color(0xFF652D90),
    ]);
String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

String baseURL = 'https://ohlala.boostupapp.com/api';

// setting value in bottomNavbar.dart
String? userIdFromDB;
