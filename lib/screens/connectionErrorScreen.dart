import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ohlalaspa/constants/texts.dart';

class ConnectionErrorScreen extends StatelessWidget {
  const ConnectionErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('images/noInternet.json'),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Please Make Sure You Have An\nActive Internet Connection',
              textAlign: TextAlign.center,
              style: headingText1,
            ),
          ],
        ),
      ),
    );
  }
}
