// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/networking/networking.dart';
import 'package:ohlalaspa/screens/newPin.dart';
import 'package:ohlalaspa/screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var profiledata;
  bool isLoading = true;
  getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uId = prefs.getString('userId')!;

    NetworkHelper networkHelperProfile = NetworkHelper(
        urlLink: 'http://ohlala.boostupapp.com/api/user/current?ID=$uId');

    var dataProfile = await networkHelperProfile.getData();
    print(dataProfile);
    setState(() {
      profiledata = dataProfile;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(22, 0, 0, 0),
                            blurRadius: 10,
                            spreadRadius: 2)
                      ],
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(17, 0, 0, 0),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: const Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(profiledata['image']),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
// name : name,
                  // number: contact
                  // image: image,
                  // userId: uId;
                  // registrationDate : registration
                  // expiredDate : expired
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Expanded(
                            child: Text(
                          profiledata['name'],
                          textAlign: TextAlign.end,
                        )),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          'User Id',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Expanded(
                            child: Text(
                          profiledata['ID'],
                          textAlign: TextAlign.end,
                        )),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          'Registration Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Expanded(
                            child: Text(
                          profiledata['registration'],
                          textAlign: TextAlign.end,
                        )),
                      ],
                    ),
                  ),

                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text(
                          'Expiry Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Expanded(
                            child: Text(
                          profiledata['expired'],
                          textAlign: TextAlign.end,
                        )),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const NewPin();
                              }));
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: gradientColor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'images/pin.svg',
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    'Change Pin',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('userId', '');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const Splashscreen();
                              }));
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
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
                                    'Sign Out',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          );
  }
}
