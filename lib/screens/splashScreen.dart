// ignore_for_file: unnecessary_null_in_if_null_operators, avoid_print, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ohlalaspa/screens/signup.dart';

var completeUserData;

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) {
            return const Signup();
            // return const MainBottomNavBarScreen();
          }),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 160,
                width: 160,
                child: Image.asset(
                  'images/logoPng.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
