import 'package:flutter/material.dart';
import 'package:ohlalaspa/screens/enterPin.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    print('000');
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 160,
                width: 160,
                child: Image.asset(
                  'images/logoPng.png',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Welcome Back',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Please sign in to your account',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 36,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Enter your membership id',
                    filled: true,
                    fillColor: const Color(0xFF707070).withOpacity(0.05),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0xFF707070).withOpacity(0.09)))),
              ),
              const SizedBox(
                height: 36,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const EnterPin();
                  }));
                },
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF7B3AAD),
                            Color(0xFF652D90),
                            Color(0xFF652D90),
                          ])),
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
