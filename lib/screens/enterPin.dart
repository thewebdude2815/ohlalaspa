// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/screens/bottomNavBar.dart';
import 'package:ohlalaspa/screens/forgotPin.dart';
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
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;
  bool isError = false;
  String dataText = 'Please enter your pin code';
  TextStyle simpleTextStle = const TextStyle(fontSize: 16, color: Colors.black);
  TextStyle errorTextStle = const TextStyle(
      fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold);
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
      http.Response res = await http.post(
          Uri.parse('http://ohlala.boostupapp.com/api/user/login'),
          headers: {"Content-type": "application/json"},
          body: msg);
      // print(res.body);
      var userData = jsonDecode(res.body);

      if (res.statusCode == 200) {
        stCode = 200;

        print('User Logged In');
        // 422 is the status code for invalid id
      } else if (res.statusCode == 400) {
        stCode = 400;
        setState(() {
          isError = true;
          dataText = 'Invalid pin';
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
                      // validator: (v) {
                      //   if (v!.length < 3) {
                      //     return "I'm from validator";
                      //   } else {
                      //     return null;
                      //   }
                      // },
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
              // Form(
              //   key: _formkey,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       SizedBox(
              //         height: 64,
              //         width: 60,
              //         child: TextFormField(
              //           controller: pinA,
              //           autofocus: true,
              //           focusNode: node1,
              //           onChanged: ((value) {
              //             if (value.length == 1) {
              //               FocusScope.of(context).requestFocus(node2);
              //             }
              //           }),
              //           cursorColor: const Color(0xff1DA1F2),
              //           validator: (value) {
              //             if (value!.isEmpty) {
              //               return "enter your pin";
              //             }
              //             return null;
              //           },
              //           style: const TextStyle(
              //             fontSize: 24,
              //             fontWeight: FontWeight.w600,
              //           ),
              //           textAlign: TextAlign.center,
              //           keyboardType: TextInputType.number,
              //           inputFormatters: [
              //             LengthLimitingTextInputFormatter(1),
              //             FilteringTextInputFormatter.digitsOnly,
              //           ],
              //           decoration: InputDecoration(
              //             filled: true,
              //             fillColor: const Color(0xFF707070).withOpacity(0.05),
              //             focusedBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 color: Color(0xfff0f0f0),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             enabledBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 color: Color(0xfff0f0f0),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             errorBorder: OutlineInputBorder(
              //               borderSide:
              //                   const BorderSide(color: Color(0xfff0f0f0)),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             focusedErrorBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 color: Color(0xffB00020),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             errorStyle: const TextStyle(
              //               color: Color(0xffB00020),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 64,
              //         width: 60,
              //         child: TextFormField(
              //           controller: pinB,
              //           autofocus: true,
              //           focusNode: node2,
              //           onChanged: ((value) {
              //             if (value.length == 1) {
              //               FocusScope.of(context).requestFocus(node3);
              //             } else if (value.isEmpty) {
              //               FocusScope.of(context).requestFocus(node1);
              //             }
              //           }),
              //           cursorColor: const Color(0xff1DA1F2),
              //           validator: (value) {
              //             if (value!.isEmpty) {
              //               return "enter your pin";
              //             }
              //             return null;
              //           },
              //           style: const TextStyle(
              //             fontSize: 24,
              //             fontWeight: FontWeight.w600,
              //           ),
              //           textAlign: TextAlign.center,
              //           keyboardType: TextInputType.number,
              //           inputFormatters: [
              //             LengthLimitingTextInputFormatter(1),
              //             FilteringTextInputFormatter.digitsOnly,
              //           ],
              //           decoration: InputDecoration(
              //             filled: true,
              //             fillColor: const Color(0xFF707070).withOpacity(0.05),
              //             focusedBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 color: Color(0xfff0f0f0),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             enabledBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 color: Color(0xfff0f0f0),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             errorBorder: OutlineInputBorder(
              //               borderSide:
              //                   const BorderSide(color: Color(0xfff0f0f0)),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             focusedErrorBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 color: Color(0xffB00020),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             errorStyle: const TextStyle(
              //               color: Color(0xffB00020),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 64,
              //         width: 60,
              //         child: TextFormField(
              //           controller: pinC,
              //           autofocus: true,
              //           focusNode: node3,
              //           onChanged: ((value) {
              //             if (value.length == 1) {
              //               FocusScope.of(context).requestFocus(node4);
              //             } else if (value.isEmpty) {
              //               FocusScope.of(context).requestFocus(node2);
              //             }
              //           }),
              //           cursorColor: const Color(0xff1DA1F2),
              //           validator: (value) {
              //             if (value!.isEmpty) {
              //               return "enter your pin";
              //             }
              //             return null;
              //           },
              //           style: const TextStyle(
              //             fontSize: 24,
              //             fontWeight: FontWeight.w600,
              //           ),
              //           textAlign: TextAlign.center,
              //           keyboardType: TextInputType.number,
              //           inputFormatters: [
              //             LengthLimitingTextInputFormatter(1),
              //             FilteringTextInputFormatter.digitsOnly,
              //           ],
              //           decoration: InputDecoration(
              //             filled: true,
              //             fillColor: const Color(0xFF707070).withOpacity(0.05),
              //             focusedBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 color: Color(0xfff0f0f0),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             enabledBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 color: Color(0xfff0f0f0),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             errorBorder: OutlineInputBorder(
              //               borderSide:
              //                   const BorderSide(color: Color(0xfff0f0f0)),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             focusedErrorBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 color: Color(0xffB00020),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             errorStyle: const TextStyle(
              //               color: Color(0xffB00020),
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 64,
              //         width: 60,
              //         child: TextFormField(
              //           controller: pinD,
              //           autofocus: true,
              //           focusNode: node4,
              //           onChanged: ((value) {
              //             if (value.length == 1) {
              //               FocusScope.of(context).requestFocus(node4);
              //             } else if (value.isEmpty) {
              //               FocusScope.of(context).requestFocus(node3);
              //             }
              //           }),
              //           cursorColor: const Color(0xff1DA1F2),
              //           validator: (value) {
              //             if (value!.isEmpty) {
              //               return "enter your pin";
              //             }
              //             return null;
              //           },
              //           style: const TextStyle(
              //             fontSize: 24,
              //             fontWeight: FontWeight.w600,
              //           ),
              //           textAlign: TextAlign.center,
              //           keyboardType: TextInputType.number,
              //           inputFormatters: [
              //             LengthLimitingTextInputFormatter(1),
              //             FilteringTextInputFormatter.digitsOnly,
              //           ],
              //           decoration: InputDecoration(
              //             filled: true,
              //             fillColor: const Color(0xFF707070).withOpacity(0.05),
              //             focusedBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 color: Color(0xfff0f0f0),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             enabledBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 color: Color(0xfff0f0f0),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             errorBorder: OutlineInputBorder(
              //               borderSide:
              //                   const BorderSide(color: Color(0xfff0f0f0)),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             focusedErrorBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                 color: Color(0xffB00020),
              //               ),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             errorStyle: const TextStyle(
              //               color: Color(0xffB00020),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (_) {
              //       return const ForgotPin();
              //     }));
              //   },
              //   child: const Text(
              //     'Forgot Pin',
              //     style: TextStyle(
              //       fontWeight: FontWeight.w600,
              //       color: Color(0xFF652D90),
              //     ),
              //   ),
              // ),
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
    ));
  }
}
