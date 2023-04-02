// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/networking/networking.dart';
import 'package:ohlalaspa/screens/qrScanner/congratsQRScreen.dart';
import 'package:ohlalaspa/widgets/serviceCardTaken.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoundCodeScreen extends StatefulWidget {
  var value;
  var dataReceived;
  final Function() screenClosed;
  FoundCodeScreen({
    Key? key,
    required this.dataReceived,
    required this.value,
    required this.screenClosed,
  }) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  List servicesdata = [];
  bool isLoading = true;
  List getFinalData = [];
  getavaliableServicesData() async {
    NetworkHelper networkHelperProfile =
        NetworkHelper(urlLink: '$baseURL/service/services?ID=$userIdFromDB');

    var dataProfile = await networkHelperProfile.getData();

    for (var i = 0; i < dataProfile.length; i++) {
      for (var j = 0; j < widget.value['service'].length; j++) {
        if (widget.value['service'][j]['services'] == dataProfile[i]['_id']) {
          getFinalData.add(dataProfile[i]);
          servicesdata.add({
            'services': dataProfile[i]['_id'],
          });
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    widget.screenClosed;
    getavaliableServicesData();
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          const Spacer(),
                          Text(
                            'Results',
                            style: headingText0.copyWith(color: Colors.black),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'Benefits You Are Going To Avail',
                        style: headingText1,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: getFinalData.length,
                          itemBuilder: (context, index) {
                            return ServicesCardTaken(
                              duration: getFinalData[index]['duration'],
                              name: getFinalData[index]['name'],
                              type: getFinalData[index]['type'],
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return CongratsQRScreen(msg: servicesdata);
                }));
              },
              child: Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.all(6),
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
                      'Proceed',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
