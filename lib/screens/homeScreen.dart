import 'package:flutter/material.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/widgets/avaliableServices.dart';
import 'package:ohlalaspa/widgets/servicesTaken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                child: Row(
                  children: [
                    Image.asset(
                      'images/logoPng.png',
                      height: 50,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Welcome To',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' Oh La La Spa',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: mainAppColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: DefaultTabController(
                  length: 2,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.77,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TabBar(
                            indicator: BoxDecoration(
                                gradient: gradientColor,
                                // color: greenColor,
                                borderRadius: BorderRadius.circular(12.0)),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black,
                            tabs: const [
                              Tab(
                                text: 'Available Benefits',
                              ),
                              Tab(
                                text: 'Benefits Taken',
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          flex: 2,
                          child: TabBarView(children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: AvaliableServices(),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: ServicesTaken(),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
