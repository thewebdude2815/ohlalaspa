// ignore_for_file: use_build_context_synchronously, avoid_print, unused_local_variable, prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/screens/signup/otpVerification.dart';
import 'package:ohlalaspa/widgets/textFieldSpaApp.dart';

class ForgotPin extends StatefulWidget {
  var userId;
  ForgotPin({super.key, required this.userId});

  @override
  State<ForgotPin> createState() => _ForgotPinState();
}

class _ForgotPinState extends State<ForgotPin> {
  TextEditingController emailC = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  resetUser(
    email,
  ) async {
    late int stCode;
    final msg = jsonEncode({
      "email": email,
    });
    print(widget.userId);
    try {
      http.Response res = await http.post(
          Uri.parse('$baseURL/user/createotp?ID=${widget.userId}'),
          headers: {"Content-type": "application/json"},
          body: msg);
      if (res.statusCode == 200) {
        stCode = 200;
      } else if (res.statusCode == 422) {
        stCode = 422;
      }
    } catch (e) {
      print(e);
    }
    return stCode;
  }

  void nextPage(
    email,
  ) async {
    setState(() {
      isLoading = true;
    });
    if (_formkey.currentState!.validate()) {
      int stCode = await resetUser(email);

      if (stCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => OTPVerification(
                  userId: widget.userId,
                )),
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
                  'Forgot Pin Code?',
                  style: headingText0.copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Enter your email address to get OTP',
                  style: headingText2,
                ),
                const SizedBox(
                  height: 36,
                ),
                Form(
                  key: _formkey,
                  child: TextFieldSpaApp(
                    idController: emailC,
                    hintTxt: 'Enter Your Email',
                    textInputType: TextInputType.text,
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                GestureDetector(
                  onTap: () {
                    nextPage(emailC.text);
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF7B3AAD),
                              Color(0xFF652D90),
                              Color(0xFF652D90),
                            ])),
                    child: const Center(
                      child: Text(
                        'Get OTP',
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
    ));
  }
}
