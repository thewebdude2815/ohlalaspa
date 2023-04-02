import 'dart:convert';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/drawStar.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/screens/bottomNavBar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CongratsQRScreen extends StatefulWidget {
  var msg;
  CongratsQRScreen({super.key, required this.msg});

  @override
  State<CongratsQRScreen> createState() => _CongratsQRScreenState();
}

class _CongratsQRScreenState extends State<CongratsQRScreen> {
  var profiledata;
  late ConfettiController _controllerCenter;
  bool isLoading = true;
  congratsSuccess() async {
    late int stCode;
    final msg = jsonEncode({
      "service": widget.msg,
    });

    try {
      http.Response res = await http.post(
          Uri.parse('$baseURL/service/takeServices?ID=$userIdFromDB'),
          headers: {"Content-type": "application/json"},
          body: msg);
      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        stCode = 200;
      } else if (res.statusCode == 422) {
        setState(() {});
        stCode = 422;
      }
    } catch (e) {
      print('----- $e');
    }
    _controllerCenter.play();
    return stCode;
  }

  @override
  void initState() {
    congratsSuccess();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: ConfettiWidget(
                          confettiController: _controllerCenter,
                          blastDirectionality: BlastDirectionality
                              .explosive, // don't specify a direction, blast randomly
                          shouldLoop:
                              true, // start again as soon as the animation is finished
                          colors: const [
                            Colors.green,
                            Colors.blue,
                            Colors.pink,
                            Colors.orange,
                            Colors.purple
                          ], // manually specify the colors to be used
                          createParticlePath:
                              drawStar, // define a custom shape/path.
                        ),
                      ),
                      Image.asset(
                        'images/logoPng.png',
                        height: 200,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Thank You for availing our service!',
                        style: headingText1,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Hoping You Will Have A Wonderful Time',
                        style: headingText3.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const MainBottomNavBar();
                          }));
                        },
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: gradientColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'images/signout.svg',
                                height: 20,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                'Back To Home',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
