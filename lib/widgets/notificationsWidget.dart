import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ohlalaspa/constants/texts.dart';

import '../constants/appConstants.dart';

class NotificationWidget extends StatelessWidget {
  String status;
  String date;
  String time;
  NotificationWidget(
      {Key? key, required this.date, required this.status, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: mainAppColor.withOpacity(0.09),
                blurRadius: 12,
                spreadRadius: 2)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'You Booked A Service',
                style: headingText3,
              ),
              const Spacer(),
              Row(
                children: [
                  SvgPicture.asset(
                    'images/statusA.svg',
                    height: 12,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(capitalize(status))
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
                text: 'Booked At: ',
                style: headingText2,
                children: <TextSpan>[
                  TextSpan(
                    text: '$date at $time',
                    style: headingText2.copyWith(fontWeight: FontWeight.w400),
                  )
                ]),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Tap To See Details',
            style: headingText4,
          ),
        ],
      ),
    );
  }
}
