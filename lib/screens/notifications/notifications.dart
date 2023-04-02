import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/screens/notifications/singleBookings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../networking/networking.dart';
import '../../widgets/notificationsWidget.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isLoading = true;
  var servicesdata;
  getNotificationsData() async {
    NetworkHelper networkHelperProfile =
        NetworkHelper(urlLink: '$baseURL/service/getBooking?ID=$userIdFromDB');

    var dataProfile = await networkHelperProfile.getData();

    if (mounted) {
      setState(() {
        servicesdata = dataProfile;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getNotificationsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
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
                          'Notifications',
                          style: headingText0.copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: servicesdata.length,
                        itemBuilder: (context, index) {
                          String serviceInString = servicesdata[index]['date'];
                          DateTime dt = DateTime.parse(serviceInString);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return SingleBookings(
                                  bookingsData: servicesdata[index],
                                );
                              }));
                            },
                            child: NotificationWidget(
                                date: DateFormat('dd-MM-yyyy').format(dt),
                                status: servicesdata[index]['status'],
                                time: DateFormat.jm().format(dt)),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
  }
}
