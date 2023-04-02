// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously, unnecessary_string_interpolations

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/screens/bottomNavBar.dart';
import 'package:ohlalaspa/screens/signup/forgotPin.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterPin extends StatefulWidget {
  String userId;
  EnterPin({
    super.key,
    required this.userId,
  });

  @override
  State<EnterPin> createState() => _EnterPinState();
}

class _EnterPinState extends State<EnterPin> {
  bool hasError = false;
  String currentText = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool isError = false;
  String dataText = 'Please enter your pin code';

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

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
      http.Response res = await http.post(Uri.parse('$baseURL/user/login'),
          headers: {"Content-type": "application/json"}, body: msg);
      if (res.statusCode == 200) {
        stCode = 200;

        // 422 is the status code for invalid id
      } else if (res.statusCode == 400) {
        stCode = 400;
        setState(() {
          isError = true;
          dataText = 'Invalid pin';
        });
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
    if (_formKey.currentState!.validate()) {
      int stCode = await loginUser(userId, pin);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (stCode == 200) {
        prefs.setString('userId', userId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const MainBottomNavBar()),
          ),
        );
      } else {
        print('Error');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
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
                dataText,
                style: isError ? errorTextStle : simpleTextStle,
              ),
              const SizedBox(
                height: 36,
              ),
              Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: true,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 64,
                          fieldWidth: 56,
                          selectedColor: const Color(0xfff0f0f0),
                          selectedFillColor:
                              const Color(0xFF707070).withOpacity(0.03),
                          inactiveFillColor:
                              const Color(0xFF707070).withOpacity(0.03),
                          inactiveColor: const Color(0xfff0f0f0),
                          activeFillColor:
                              const Color(0xFF707070).withOpacity(0.03),
                          activeColor: const Color(0xfff0f0f0)),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                    )),
              ),
              const SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  nextPage(widget.userId, '${textEditingController.text}');
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: gradientColor),
                  child: Center(
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ForgotPin(userId: widget.userId);
                  }));
                },
                child: Text(
                  'Forgot Pin',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: mainAppColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
