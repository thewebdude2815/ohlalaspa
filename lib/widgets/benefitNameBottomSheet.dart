import 'package:flutter/material.dart';

void showBenefitNameSheet(BuildContext context, String text) {
  var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
      top: Radius.circular(30),
    )),
    builder: (context) => DraggableScrollableSheet(
        initialChildSize: isPortrait ? 0.3 : 0.7,
        maxChildSize: isPortrait ? 0.3 : 0.7,
        minChildSize: 0.15,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage('images/spaImg.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(158, 0, 0, 0), BlendMode.darken),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(
                  child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
            ),
          );
        }),
  );
}
