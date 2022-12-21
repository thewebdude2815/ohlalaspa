import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ohlalaspa/screens/forgotPin.dart';

class NewPin extends StatelessWidget {
  const NewPin({super.key});

  @override
  Widget build(BuildContext context) {
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
                'Create New Pin Code',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Your new pin code must be different\nfrom the previous one',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 64,
                    width: 60,
                    child: TextFormField(
                      autofocus: true,
                      onChanged: ((value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                      cursorColor: const Color(0xff1DA1F2),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter your pin";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF707070).withOpacity(0.05),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xfff0f0f0),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xfff0f0f0),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xfff0f0f0)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffB00020),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle: const TextStyle(
                          color: Color(0xffB00020),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 64,
                    width: 60,
                    child: TextFormField(
                      autofocus: true,
                      onChanged: ((value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                      cursorColor: const Color(0xff1DA1F2),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter your pin";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF707070).withOpacity(0.05),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xfff0f0f0),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xfff0f0f0),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xfff0f0f0)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffB00020),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle: const TextStyle(
                          color: Color(0xffB00020),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 64,
                    width: 60,
                    child: TextFormField(
                      autofocus: true,
                      onChanged: ((value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                      cursorColor: const Color(0xff1DA1F2),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter your pin";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF707070).withOpacity(0.05),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xfff0f0f0),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xfff0f0f0),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xfff0f0f0)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffB00020),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle: const TextStyle(
                          color: Color(0xffB00020),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 64,
                    width: 60,
                    child: TextFormField(
                      autofocus: true,
                      onChanged: ((value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      }),
                      cursorColor: const Color(0xff1DA1F2),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter your pin";
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF707070).withOpacity(0.05),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xfff0f0f0),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xfff0f0f0),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xfff0f0f0)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffB00020),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle: const TextStyle(
                          color: Color(0xffB00020),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (_) {
              //       return const ForgotPin();
              //     }));
              //   },
              //   child: const Text(
              //     'Forgot Pin',
              //     style: TextStyle(
              //       fontWeight: FontWeight.w600,
              //       color: Color(0xFF652D90),
              //     ),
              //   ),
              // ),
              Container(
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
                    'Done',
                    style: TextStyle(color: Colors.white),
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
