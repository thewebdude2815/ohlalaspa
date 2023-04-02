// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/drawStar.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/networking/networking.dart';
import 'package:ohlalaspa/screens/bookingMenus/bookForSomeone.dart';
import 'package:ohlalaspa/screens/bottomNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CongratsScreen extends StatefulWidget {
  const CongratsScreen({super.key});

  @override
  State<CongratsScreen> createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  var profiledata;
  late ConfettiController _controllerCenter;
  bool isLoading = true;
  getProfileData() async {
    NetworkHelper networkHelperProfile =
        NetworkHelper(urlLink: '$baseURL/user/current?ID=$userIdFromDB');

    var dataProfile = await networkHelperProfile.getData();

    setState(() {
      profiledata = dataProfile;
      isLoading = false;
    });
    _controllerCenter.play();
  }

  @override
  void initState() {
    getProfileData();
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
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                        'Thank You ${profiledata['name']} for your booking!',
                        style: headingText1,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Please visit Oh La La Spa on the selected date & time',
                        style: headingText3.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            usersList = [];
                            services = [];
                            myServices = [];
                          });
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
