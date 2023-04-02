// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/networking/networking.dart';
import 'package:ohlalaspa/widgets/servicesCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicesTaken extends StatefulWidget {
  const ServicesTaken({super.key});

  @override
  State<ServicesTaken> createState() => _ServicesTakenState();
}

class _ServicesTakenState extends State<ServicesTaken> {
  var servicesdata;
  bool isLoading = true;
  getavaliableServicesData() async {
    NetworkHelper networkHelperProfile =
        NetworkHelper(urlLink: '$baseURL/user/current?ID=$userIdFromDB');

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
    getavaliableServicesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: servicesdata['takeServices'].length,
            itemBuilder: (context, index) {
              String serviceInString =
                  servicesdata['takeServices'][index]['date'];
              DateTime dt = DateTime.parse(serviceInString);
              return ServicesCard(
                date: DateFormat('dd-MM-yyyy').format(dt),
                duration: servicesdata['takeServices'][index]['services']
                    ['duration'],
                name: servicesdata['takeServices'][index]['services']['name'],
                type: servicesdata['takeServices'][index]['services']['type'],
                serviceTaken: true,
              );
            },
          );
  }
}
