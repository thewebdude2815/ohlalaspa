import 'package:flutter/material.dart';
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uId = prefs.getString('userId')!;

    NetworkHelper networkHelperProfile = NetworkHelper(
        urlLink: 'http://ohlala.boostupapp.com/api/user/current?ID=$uId');

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
            itemCount: servicesdata['takeServices'].length,
            itemBuilder: (context, index) {
              return ServicesCard(
                duration: servicesdata['takeServices'][index]['serviceID']
                    ['duration'],
                name: servicesdata['takeServices'][index]['serviceID']['name'],
                type: servicesdata['takeServices'][index]['serviceID']['type'],
                serviceTaken: true,
              );
            },
          );
  }
}
