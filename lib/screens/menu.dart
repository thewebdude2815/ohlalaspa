import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List imagesMenu = [
    'images/menu1.jpg',
    'images/menu2.jpg',
    'images/menu3.jpg',
    'images/menu4.jpg',
    'images/menu5.jpg',
    'images/menu6.jpg',
    'images/menu7.jpg',
  ];
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
                child: const Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  shrinkWrap: true,
                  children: List.generate(imagesMenu.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        showImageViewer(
                            context, Image.asset(imagesMenu[index]).image,
                            swipeDismissible: false);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(imagesMenu[index]),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(20))),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
