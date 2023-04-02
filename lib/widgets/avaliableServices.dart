// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/networking/networking.dart';
import 'package:ohlalaspa/widgets/benefitNameBottomSheet.dart';
import 'package:ohlalaspa/widgets/servicesCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvaliableServices extends StatefulWidget {
  const AvaliableServices({super.key});

  @override
  State<AvaliableServices> createState() => _AvaliableServicesState();
}

class _AvaliableServicesState extends State<AvaliableServices> {
  var servicesdata;
  bool isLoading = true;
  getavaliableServicesData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uId = prefs.getString('userId')!;
    NetworkHelper networkHelperProfile =
        NetworkHelper(urlLink: '$baseURL/service/services?ID=$uId');

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
  void dispose() {
    getavaliableServicesData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: servicesdata.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showBenefitNameSheet(context, servicesdata[index]['name']);
                },
                child: ServicesCard(
                  date: '',
                  duration: servicesdata[index]['duration'],
                  name: servicesdata[index]['name'],
                  type: servicesdata[index]['type'],
                  serviceTaken: false,
                ),
              );
            },
          );
  }
}
