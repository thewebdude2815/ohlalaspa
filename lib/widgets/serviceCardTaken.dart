// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ohlalaspa/constants/texts.dart';

class ServicesCardTaken extends StatelessWidget {
  final String name;
  final String type;
  final String duration;

  const ServicesCardTaken(
      {super.key,
      required this.duration,
      required this.name,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: headingText1,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'images/statusA.svg',
                height: 16,
              ),
              const SizedBox(
                width: 4,
              ),
              Text('You Are Going To Avail This'),
            ],
          ),
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
