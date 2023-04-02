// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/screens/signup/newPin.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerification extends StatefulWidget {
  var userId;
  OTPVerification({super.key, required this.userId});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  bool hasError = false;
  String currentText = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;
  bool isError = false;
  String dataText = 'Please enter the OTP sent to you\nemail address';

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
  otpVerify(
    email,
  ) async {
    late int stCode;
    final msg = jsonEncode({
      "otp": int.parse(email),
    });
    try {
      http.Response res = await http.post(
          Uri.parse('$baseURL/user/matchotp?ID=${widget.userId}'),
          headers: {"Content-type": "application/json"},
          body: msg);

      if (res.statusCode == 200) {
        stCode = 200;
      } else if (res.statusCode == 422) {
        setState(() {
          isError = true;
          dataText = 'Invalid pin';
        });
        stCode = 422;
      }
    } catch (e) {
      print('----- $e');
    }
    return stCode;
  }

  void nextPage(
    email,
  ) async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      int stCode = await otpVerify(email);

      if (stCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => NewPin(
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
                  'OTP Verification',
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
                    nextPage(textEditingController.text);
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
                    child: Center(
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Verify OTP',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "I didn't receive a code!",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (_) {
                        //   return  ForgotPin();
                        // }));
                      },
                      child: const Text(
                        'Please resend',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF652D90),
                        ),
                      ),
                    ),
                  ],
                ),
                // Container(
                //   height: 70,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(12),
                //       gradient: const LinearGradient(
                //           begin: Alignment.topCenter,
                //           end: Alignment.bottomCenter,
                //           colors: [
                //             Color(0xFF7B3AAD),
                //             Color(0xFF652D90),
                //             Color(0xFF652D90),
                //           ])),
                //   child: const Center(
                //     child: Text(
                //       'Continue',
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
