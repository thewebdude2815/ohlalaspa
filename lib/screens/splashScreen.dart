// ignore_for_file: unnecessary_null_in_if_null_operators, avoid_print, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ohlalaspa/screens/bottomNavBar.dart';
import 'signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

var completeUserData;

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  String? userId = '';
  getuserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userId') != null) {
      setState(() {
        userId = prefs.getString('userId');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getuserId();

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) {
              if (userId == '') {
                return const Signup();
              } else {
                return const MainBottomNavBar();
              }
            }),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
      ),
    );
  }
}
