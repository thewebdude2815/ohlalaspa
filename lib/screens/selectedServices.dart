// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/screens/bookingMenus/bookForMyself.dart';
import 'package:ohlalaspa/screens/bookingMenus/bookForSomeone.dart';

class SelectedServices extends StatefulWidget {
  var allServices;
  final selectedServices;
  final allData;
  SelectedServices(
      {super.key,
      required this.selectedServices,
      required this.allData,
      required this.allServices});

  @override
  State<SelectedServices> createState() => _SelectedServicesState();
}

class _SelectedServicesState extends State<SelectedServices> {
  var finalList = [];
  bool isLoading = false;
  getSelectedServices() {
    setState(() {
      isLoading = true;
    });
    for (var i = 0; i < widget.allData.length; i++) {
      for (var j = 0; j < widget.selectedServices.length; j++) {
        if (widget.selectedServices[j] == widget.allData[i]['_id']) {
          finalList.add(widget.allData[i]);
        }
      }
    }
    print(finalList);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getSelectedServices();
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
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Selected Services',
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
                      // height: 800,
                      padding: const EdgeInsets.all(12),
                      child: ListView.builder(
                        itemCount: finalList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: mainAppColor.withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 1)
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                finalList[index]['subtitle'],
                                style: headingText3,
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  finalList[index]['price'],
                                  style: headingText3.copyWith(
                                      color: mainAppColor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Container(
              margin: const EdgeInsets.only(right: 12, left: 12),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return BookForMyself(
                          selectedServices: widget.selectedServices,
                        );
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
                            'Book For Myself',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return BookForSomeone(
                            selectedServices: widget.selectedServices,
                            allData: widget.allData,
                            allServices: widget.allServices);
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
                            'Book For Someone',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
