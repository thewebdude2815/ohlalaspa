import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/screens/homeScreen.dart';
import 'package:ohlalaspa/screens/menus/menu.dart';
import 'package:ohlalaspa/screens/profile.dart';
import 'package:ohlalaspa/screens/qrScanner/qrScanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int index = 0;

  storeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uId = prefs.getString('userId')!;
    if (mounted) {
      setState(() {
        userIdFromDB = uId;
      });
    }
  }

  List<Widget> screens = [
    const HomeScreen(),
    const QRScanner(),
    const Menu(),
    const Profile(),
  ];
  @override
  void initState() {
    storeUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        // margin: const EdgeInsets.all(12),
        child: GNav(
            selectedIndex: index,
            onTabChange: (value) {
              setState(() {
                index = value;
              });
            },
            rippleColor:
                Colors.grey[800]!, // tab button ripple color when pressed
            hoverColor: Colors.grey[700]!, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 25,
            curve: Curves.easeOutExpo, // tab animation curves
            duration:
                const Duration(milliseconds: 900), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.grey[800], // unselected icon color
            activeColor: Colors.white, // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor: mainAppColor, // selected tab background color
            tabBackgroundGradient: gradientColor,
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 10), // navigation bar padding
            tabs: const [
              GButton(
                icon: Icons.home,
                // icon: SvgPicture.asset(''),
                // leading: SvgPicture.asset('assets/marcket.svg'),
                text: 'Home',
              ),
              GButton(
                icon: Icons.qr_code,
                text: 'Scan QR Code',
              ),
              GButton(
                icon: Icons.menu,
                text: 'Menu',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              )
            ]),
      ),
    );
  }
}
