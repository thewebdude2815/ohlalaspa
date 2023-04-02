// ignore_for_file: sort_child_properties_last, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/networking/notificationsApi.dart';
import 'package:ohlalaspa/widgets/addNewUser.dart';
import 'package:http/http.dart' as http;
import 'package:select_dialog/select_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'congratsScreen.dart';

var usersList = [];
List<String> services = [];
List<String> myServices = [];

class BookForSomeone extends StatefulWidget {
  final selectedServices;
  final allData;
  final allServices;
  const BookForSomeone(
      {super.key,
      required this.selectedServices,
      required this.allData,
      required this.allServices});

  @override
  State<BookForSomeone> createState() => _BookForSomeoneState();
}

class _BookForSomeoneState extends State<BookForSomeone> {
  String dateSelected = 'Select Date';
  String timeSelected = 'Select Time';
  bool isLoading = true;
  var finalList = [];
  bool isLoadingProceed = false;
  TextEditingController noteC = TextEditingController();

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
    setState(() {
      isLoading = false;
    });
  }

  List<String> ex5 = [];
  @override
  void initState() {
    getSelectedServices();
    super.initState();
  }

  @override
  void dispose() {
    usersList = [];
    services = [];
    myServices = [];
    super.dispose();
  }

  String errorDateText = '';
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
                    Text(
                      'Book Now',
                      style: headingText0.copyWith(color: Colors.black),
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
                              'images/pin.svg',
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
                              'images/pin.svg',
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
                child: TextField(
                  controller: noteC,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Select Services For Yourself',
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
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          SelectDialog.showModal<String>(
                            context,
                            label: "Select Services",
                            multipleSelectedValues: myServices,
                            items: List.generate(finalList.length,
                                (index) => finalList[index]['subtitle']),
                            onMultipleItemsChange: (List<String> selected) {
                              setState(() {
                                myServices = selected;
                              });
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            'Select Services',
                            style: headingText3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  '${myServices.length} Services Selected',
                  style: headingText4.copyWith(fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Add Details Of Others',
                  style: headingText1.copyWith(
                    color: mainAppColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  TextEditingController nameC = TextEditingController();
                  TextEditingController numberC = TextEditingController();

                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.zero,
                          actions: [
                            const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: () {
                                usersList.add({
                                  'name': nameC.text,
                                  'phone': numberC.text,
                                  'purchases': services
                                });

                                setState(() {
                                  services = [];
                                  nameC.text = '';
                                  numberC.text = '';
                                });
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                          content: Container(
                              height: 240,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: AddNewUser(
                                finalList: widget.allServices,
                                nameC: nameC,
                                numberC: numberC,
                              )),
                        );
                      });
                },
                child: Container(
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: gradientColor),
                  child: const Center(
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: usersList.length,
                  itemBuilder: (ctx, index) {
                    // var decoded = jsonDecode(usersList);
                    return Container(
                      margin: const EdgeInsets.all(12),
                      child: Material(
                        elevation: 1,
                        child: ListTile(
                          tileColor: Colors.white,
                          title: Text(
                            usersList[index]['name'],
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(usersList[index]['phone']),
                              const SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          height: 300,
                                          child: Column(
                                            children: [
                                              const Text(
                                                'Services You Selected',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              const Divider(),
                                              SizedBox(
                                                height: 240,
                                                width: 220,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: usersList[index]
                                                            ['purchases']
                                                        .length,
                                                    itemBuilder: (ctx, index2) {
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(usersList[index]
                                                                  ['purchases']
                                                              [index2]),
                                                          const Divider(
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Center(
                                  child: Text('See Services Selected',
                                      style: TextStyle(color: Colors.blue)),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
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
              'purchased': myServices,
              'book_for_others': usersList,
              'status': 'booking'
            };
            http.Response res = await http.post(
                Uri.parse('$baseURL/service/bookService'),
                headers: {"Content-type": "application/json"},
                body: jsonEncode(dataToUpload));

            if (res.statusCode == 200) {
              setState(() {
                isLoadingProceed = false;
              });
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const CongratsScreen();
              }));
              NotificationService().showNotification(
                title: 'Booking Done',
                body: 'You just booked services for yourself or others',
              );
            } else if (res.statusCode == 422) {}
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
            child: const Center(
              child: Text(
                'Proceed',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
