// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/main.dart';

class ServicesCard extends StatelessWidget {
  var date;
  final String name;
  final String type;
  final String duration;
  final bool serviceTaken;
  ServicesCard(
      {super.key,
      required this.date,
      required this.duration,
      required this.name,
      required this.serviceTaken,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: serviceTaken ? 140 : 120,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name.capitalize(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: headingText1,
          ),
          serviceTaken
              ? Row(
                  children: [
                    SvgPicture.asset(
                      'images/red2.svg',
                      height: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text('Service Already Taken'),
                  ],
                )
              : Row(
                  children: [
                    SvgPicture.asset(
                      'images/statusA.svg',
                      height: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text('Avail Now'),
                  ],
                ),
          serviceTaken
              ? Row(
                  children: [
                    SvgPicture.asset(
                      'images/date.svg',
                      height: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(date.toString()),
                  ],
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'images/money.svg',
                    height: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(type),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'images/clock.svg',
                    height: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(duration),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
