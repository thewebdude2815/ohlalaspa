// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/networking/networking.dart';

class SingleMenu extends StatefulWidget {
  String menuName;
  SingleMenu({super.key, required this.menuName});

  @override
  State<SingleMenu> createState() => _SingleMenuState();
}

class _SingleMenuState extends State<SingleMenu> {
  bool isLoading = true;
  var getAllMenu;
  getMenuData() async {
    NetworkHelper networkHelperMenuItem = NetworkHelper(
        urlLink: '$baseURL/menu/getMenu?title=${widget.menuName}');

    var receivedMenuItem = await networkHelperMenuItem.getData();

    if (mounted) {
      setState(() {
        getAllMenu = receivedMenuItem['menu'];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getMenuData();
    super.initState();
  }

  showOptionBox(String name, String price, String description) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: headingText1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      price,
                      style: headingText2.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      description,
                      style: headingText3,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            ),
          )
        : Scaffold(
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
                          const SizedBox(
                            width: 2,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back)),
                          const Spacer(),
                          Text(
                            widget.menuName,
                            style: headingText0.copyWith(color: Colors.black),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: getAllMenu.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color: mainAppColor.withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 1)
                                ]),
                            child: ListTile(
                              title: Text(getAllMenu[index]['subtitle']),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  getAllMenu[index]['price'],
                                  style: headingText3.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: mainAppColor),
                                ),
                              ),
                              trailing: GestureDetector(
                                  onTap: () {
                                    showOptionBox(
                                        getAllMenu[index]['subtitle'],
                                        getAllMenu[index]['price'],
                                        getAllMenu[index]['description']);
                                  },
                                  child:
                                      const Icon(Icons.info_outline_rounded)),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
  }
}
