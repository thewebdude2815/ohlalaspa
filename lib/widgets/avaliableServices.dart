import 'package:flutter/material.dart';
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

    NetworkHelper networkHelperProfile = NetworkHelper(
        urlLink: 'http://ohlala.boostupapp.com/api/service/services?ID=$uId');

    var dataProfile = await networkHelperProfile.getData();
    print(dataProfile);
    setState(() {
      servicesdata = dataProfile;
      isLoading = false;
    });
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
            itemCount: servicesdata.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showBenefitNameSheet(context, servicesdata[index]['name']);
                },
                child: ServicesCard(
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
