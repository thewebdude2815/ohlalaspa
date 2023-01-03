// ignore_for_file: use_build_context_synchronously, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ohlalaspa/screens/bottomNavBar.dart';
import 'package:ohlalaspa/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPin extends StatefulWidget {
  const NewPin({super.key});

  @override
  State<NewPin> createState() => _NewPinState();
}

class _NewPinState extends State<NewPin> {
  TextEditingController pinA = TextEditingController();
  TextEditingController pinB = TextEditingController();
  TextEditingController pinC = TextEditingController();
  TextEditingController pinD = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  loginUser(
    pin,
  ) async {
    late int stCode;
    final msg = jsonEncode({
      "pin": pin,
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uId = prefs.getString('userId')!;
      http.Response res = await http.post(
          Uri.parse('http://ohlala.boostupapp.com/api/user/reset?ID=$uId'),
          headers: {"Content-type": "application/json"},
          body: msg);
      // print(res.body);
      var userData = jsonDecode(res.body);
      print(res.statusCode);
      if (res.statusCode == 200) {
        setState(() {
          // userToken = userData['token'];
          // name = userData['name'];
          // userId = userData['UserID'];
        });
        stCode = 200;

        print('User Logged In');
      } else if (res.statusCode == 422) {
        stCode = 422;
        print('Some Error');
      }
    } catch (e) {
      print(e);
    }
    return stCode;
  }

  void nextPage(
    pin,
  ) async {
    setState(() {
      isLoading = true;
    });
    if (_formkey.currentState!.validate()) {
      int stCode = await loginUser(pin);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (stCode == 200) {
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
                'Create New Pin Code',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Your new pin code must be different\nfrom the previous one',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 36,
              ),
              Form(
                key: _formkey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 64,
                      width: 60,
                      child: TextFormField(
                        controller: pinA,
                        autofocus: true,
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        }),
                        cursorColor: const Color(0xff1DA1F2),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter your pin";
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF707070).withOpacity(0.05),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xfff0f0f0),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xfff0f0f0),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xfff0f0f0)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffB00020),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorStyle: const TextStyle(
                            color: Color(0xffB00020),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 64,
                      width: 60,
                      child: TextFormField(
                        controller: pinB,
                        autofocus: true,
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        }),
                        cursorColor: const Color(0xff1DA1F2),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter your pin";
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF707070).withOpacity(0.05),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xfff0f0f0),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xfff0f0f0),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xfff0f0f0)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffB00020),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorStyle: const TextStyle(
                            color: Color(0xffB00020),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 64,
                      width: 60,
                      child: TextFormField(
                        controller: pinC,
                        autofocus: true,
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        }),
                        cursorColor: const Color(0xff1DA1F2),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter your pin";
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF707070).withOpacity(0.05),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xfff0f0f0),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xfff0f0f0),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xfff0f0f0)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffB00020),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorStyle: const TextStyle(
                            color: Color(0xffB00020),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 64,
                      width: 60,
                      child: TextFormField(
                        controller: pinD,
                        autofocus: true,
                        onChanged: ((value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        }),
                        cursorColor: const Color(0xff1DA1F2),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter your pin";
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF707070).withOpacity(0.05),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xfff0f0f0),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xfff0f0f0),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xfff0f0f0)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffB00020),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorStyle: const TextStyle(
                            color: Color(0xffB00020),
                          ),
                        ),
                      ),
                    ),
                  ],
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
              GestureDetector(
                onTap: () {
                  nextPage('${pinA.text}${pinB.text}${pinC.text}${pinD.text}');
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
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
