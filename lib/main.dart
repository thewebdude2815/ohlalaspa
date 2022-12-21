import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ohlalaspa/screens/splashScreen.dart';

void main() {
  runApp(const OhLaLaSpa());
}

class OhLaLaSpa extends StatelessWidget {
  const OhLaLaSpa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const Splashscreen(),
    );
  }
}
