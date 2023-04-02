// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/screens/qrScanner/webView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;
  @override
  void dispose() {
    _screenWasClosed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                child: Center(
                  child: Text(
                    'Profile',
                    style: headingText0.copyWith(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 600,
                child: MobileScanner(
                  allowDuplicates: true,
                  controller: cameraController,
                  onDetect: _foundBarcode,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Please Scan The QR Code Here',
                style: headingText2,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _foundBarcode(Barcode barcode, MobileScannerArguments? args) async {
    /// open screen
    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      debugPrint('Barcode found! $code');
      _screenOpened = true;
      var jsonData = jsonDecode(code);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String uId = sharedPreferences.getString('userId')!;
      if (jsonData["id"] == uId) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoundCodeScreen(
                screenClosed: _screenWasClosed,
                value: jsonData,
                dataReceived: code,
              ),
            ));
      }
      _screenWasClosed();
    }
  }

  void _screenWasClosed() {
    setState(() {
      _screenOpened = false;
    });
  }
}
