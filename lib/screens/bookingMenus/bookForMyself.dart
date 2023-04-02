// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/networking/networking.dart';
import 'package:ohlalaspa/networking/notificationsApi.dart';
import 'package:ohlalaspa/screens/bookingMenus/congratsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BookForMyself extends StatefulWidget {
  final selectedServices;
  const BookForMyself({super.key, required this.selectedServices});

  @override
  State<BookForMyself> createState() => _BookForMyselfState();
}

class _BookForMyselfState extends State<BookForMyself> {
  String dateSelected = 'Select Date';
  String timeSelected = 'Select Time';
  bool showBenefits = false;
  bool isLoading = true;
  var servicesdata;
  List selectedBenefits = [];
  final List<int> selectedIndexes = [];
  TextEditingController notesC = TextEditingController();
  bool isLoadingProceed = false;
  String errorDateText = '';
  getavaliableServicesData() async {
    NetworkHelper networkHelperProfile =
        NetworkHelper(urlLink: '$baseURL/service/services?ID=$userIdFromDB');

    var dataProfile = await networkHelperProfile.getData();

    setState(() {
      servicesdata = dataProfile;
      isLoading = false;
    });
  }

  Map<String, dynamic> dataToUpload = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const Text(
                      'Book Now',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: Image.asset(
                  'images/book2.jpeg',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  color: Colors.black38,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Select Date & Time',
                  style: headingText1.copyWith(
                    color: mainAppColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              errorDateText == ''
                  ? Container()
                  : Column(
                      children: [
                        Center(
                          child: Text(
                            errorDateText,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day),
                            maxTime: DateTime(2028, 12, 31),
                            theme: DatePickerTheme(
                                headerColor: mainAppColor,
                                backgroundColor: Colors.white,
                                itemStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                cancelStyle: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                doneStyle: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            onChanged: (date) {}, onConfirm: (date) {
                          setState(() {
                            dateSelected =
                                DateFormat('dd-MM-yyyy').format(date);
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: gradientColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'images/date.svg',
                              height: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              dateSelected,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        DatePicker.showTimePicker(context,
                            showTitleActions: true,
                            showSecondsColumn: false,
                            locale: LocaleType.en,
                            theme: DatePickerTheme(
                                headerColor: mainAppColor,
                                backgroundColor: Colors.white,
                                itemStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                cancelStyle: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                doneStyle: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            onChanged: (date) {}, onConfirm: (date) {
                          setState(() {
                            timeSelected = DateFormat.Hm().format(date);
                          });
                        }, currentTime: DateTime.now());
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: gradientColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'images/time.svg',
                              height: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              timeSelected,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Write A Note',
                  style: headingText1.copyWith(
                    color: mainAppColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: notesC,
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Note',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          if ((dateSelected == 'Select Data' ||
                  timeSelected == 'Select Time') ||
              (dateSelected == 'Select Data' &&
                  timeSelected == 'Select Time')) {
            setState(() {
              errorDateText = 'Please Enter Both Date & Time';
            });
          } else {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            var myID = preferences.getString('userId')!;
            dataToUpload = {
              'ID': myID,
              'book_date': dateSelected,
              'time': timeSelected,
              'note': notesC.text,
              'purchased': widget.selectedServices,
              'status': 'booking'
            };
            http.Response res = await http.post(
                Uri.parse('$baseURL/service/bookService'),
                headers: {"Content-type": "application/json"},
                body: jsonEncode(dataToUpload));

            print(res.statusCode);
            if (res.statusCode == 200) {
              setState(() {
                isLoadingProceed = false;
              });
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const CongratsScreen();
              }));
              NotificationService().showNotification(
                title: 'Booking Done',
                body: 'You just booked services for your self',
              );
            } else if (res.statusCode == 422) {
              print(res.body);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: gradientColor),
            child: Center(
              child: !isLoadingProceed
                  ? const Text(
                      'Proceed',
                      style: TextStyle(color: Colors.white),
                    )
                  : const CircularProgressIndicator(
                      color: Colors.white,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
