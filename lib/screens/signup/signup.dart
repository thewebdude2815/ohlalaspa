// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/screens/signup/enterPin.dart';
import 'package:http/http.dart' as http;
import 'package:ohlalaspa/widgets/textFieldSpaApp.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController idController = TextEditingController();
  bool isError = false;
  String textData = 'Please sign in to your account';

  bool isLoading = false;

  // Logging User In
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
      http.Response res = await http.post(Uri.parse('$baseURL/user/login'),
          headers: {"Content-type": "application/json"}, body: msg);
      // 400 is code for OK
      if (res.statusCode == 400) {
        stCode = 400;
        // 422 is the status code for invalid id
      } else if (res.statusCode == 422) {
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

// Takes User To Next Page
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
        child: SingleChildScrollView(
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
                  Text(
                    'Welcome Back',
                    style: headingText0.copyWith(color: Colors.black),
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
                  TextFieldSpaApp(
                    idController: idController,
                    hintTxt: 'Enter Your Membership Id',
                    textInputType: TextInputType.number,
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
        ),
      )),
    );
  }
}
