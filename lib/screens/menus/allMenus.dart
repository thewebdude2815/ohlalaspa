import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/networking/networking.dart';
import 'package:ohlalaspa/screens/selectedServices.dart';

class AllMenus extends StatefulWidget {
  const AllMenus({super.key});

  @override
  State<AllMenus> createState() => _AllMenusState();
}

class _AllMenusState extends State<AllMenus> {
  var getAllMenu;
  bool isLoaded = false;
  List selectedServices = [];
  final List<int> selectedIndexes = [];

  getMenuData() async {
    NetworkHelper networkHelperMenuItem =
        NetworkHelper(urlLink: '$baseURL/menu/getMenu');

    var receivedMenuItem = await networkHelperMenuItem.getData();

    setState(() {
      getAllMenu = receivedMenuItem['menu'];
      isLoaded = true;
    });
  }

  @override
  void initState() {
    getMenuData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              body: SafeArea(
                child: Center(
                  child: CircularProgressIndicator(
                    color: mainAppColor,
                  ),
                ),
              ),
            ))
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
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            'Select Services',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(flex: 2, child: Container()),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'Services: ',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '${selectedIndexes.length} / ${getAllMenu.length}',
                                  style: TextStyle(
                                    color: mainAppColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 800,
                      padding: const EdgeInsets.all(12),
                      child: ListView.builder(
                          itemCount: getAllMenu.length,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIndexes.contains(index)) {
                                    selectedServices.remove(
                                      getAllMenu[index]['_id'],
                                    );
                                    print(selectedServices);
                                    selectedIndexes.remove(index);
                                  } else {
                                    selectedServices.add(
                                      getAllMenu[index]['_id'],
                                    );
                                    selectedIndexes.add(index);
                                    print(selectedServices);
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: selectedIndexes.contains(index)
                                        ? mainAppColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                          color: mainAppColor.withOpacity(0.2),
                                          blurRadius: 10,
                                          spreadRadius: 1)
                                    ]),
                                child: ListTile(
                                  title: Text(
                                    getAllMenu[index]['subtitle'],
                                    style: TextStyle(
                                        color: selectedIndexes.contains(index)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      getAllMenu[index]['price'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: selectedIndexes.contains(index)
                                              ? Colors.white
                                              : mainAppColor),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: selectedIndexes.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return SelectedServices(
                            allServices: getAllMenu,
                            selectedServices: selectedServices,
                            allData: getAllMenu);
                      }));
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: gradientColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'images/signout.svg',
                            height: 20,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Proceed',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'images/signout.svg',
                          height: 20,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Proceed',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
          );
  }
}
