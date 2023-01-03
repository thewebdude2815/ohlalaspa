// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/screens/enterPin.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController idController = TextEditingController();
  bool isError = false;
  String textData = 'Please sign in to your account';
  TextStyle simpleTextStle = const TextStyle(fontSize: 16, color: Colors.black);
  TextStyle errorTextStle = const TextStyle(
      fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold);
  bool isLoading = false;
  loginUser(
    String userId,
    pin,
  ) async {
    late int stCode;
    final msg = jsonEncode({
      "ID": userId,
      "pin": pin,
    });

    try {
      http.Response res = await http.post(
          Uri.parse('http://ohlala.boostupapp.com/api/user/login'),
          headers: {"Content-type": "application/json"},
          body: msg);
      // print(res.body);
      var userData = jsonDecode(res.body);
      print(res.statusCode);
      if (res.statusCode == 400) {
        stCode = 400;
        print('User Logged In');
        // 422 is the status code for invalid id
      } else if (res.statusCode == 422) {
        print(res.body);
        stCode = 422;
        setState(() {
          isError = true;
          textData = 'Invalid id';
        });
        print('Some Error');
      }
    } catch (e) {
      print(e);
    }
    return stCode;
  }

  void nextPage(
    String userId,
    pin,
  ) async {
    setState(() {
      isLoading = true;
    });

    int stCode = await loginUser(userId, pin);
    if (stCode == 400) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => EnterPin(userId: userId)),
        ),
      );
    } else {
      print('Error');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 160,
                  width: 160,
                  child: Image.asset(
                    'images/logoPng.png',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  textData,
                  style: isError ? errorTextStle : simpleTextStle,
                ),
                const SizedBox(
                  height: 36,
                ),
                TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    hintText: 'Enter your membership id',
                    filled: true,
                    fillColor: const Color(0xFF707070).withOpacity(0.05),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF707070).withOpacity(0.09)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF707070).withOpacity(0.09)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xfff0f0f0)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffB00020),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                GestureDetector(
                  onTap: () {
                    if (idController.text == '') {
                      setState(() {
                        isError = true;
                        textData = 'ID Can Not Be Empty';
                      });
                    } else {
                      nextPage(idController.text, '');
                    }
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: gradientColor),
                    child: Center(
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Continue',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
