// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ohlalaspa/constants/texts.dart';

import '../../constants/appConstants.dart';

class SingleBookings extends StatefulWidget {
  var bookingsData;
  SingleBookings({Key? key, required this.bookingsData}) : super(key: key);

  @override
  State<SingleBookings> createState() => _SingleBookingsState();
}

class _SingleBookingsState extends State<SingleBookings> {
  String timeWhenBookingWasMade = '';
  DateTime? dt;
  ExpandableController clientDataC = ExpandableController();
  ExpandableController servicesForMeC = ExpandableController();
  ExpandableController servicesForOthersC = ExpandableController();

  bool clickedClientData = false;
  bool servicesForMeCData = false;
  bool servicesForOthersCData = false;
  @override
  void initState() {
    timeWhenBookingWasMade = widget.bookingsData['date'];
    dt = DateTime.parse(timeWhenBookingWasMade);
    super.initState();
  }

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
                    Text(
                      'Bookings',
                      style: headingText0.copyWith(color: Colors.black),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          spreadRadius: 2),
                    ]),
                // height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Booked At: ',
                          style: headingText2,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${DateFormat('dd-MM-yyyy').format(dt!)} at ${DateFormat.jm().format(dt!)}',
                              style: headingText2.copyWith(
                                  fontWeight: FontWeight.w400),
                            )
                          ]),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'images/statusA.svg',
                          height: 12,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          capitalize(
                            widget.bookingsData['status'],
                          ),
                          style: headingText3,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Note: ',
                          style: headingText2,
                          children: <TextSpan>[
                            TextSpan(
                              text: '${widget.bookingsData['note']}',
                              style: headingText2.copyWith(
                                  fontWeight: FontWeight.w400),
                            )
                          ]),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ExpandablePanel(
                      theme: const ExpandableThemeData(
                          hasIcon: false,
                          expandIcon: Icons.arrow_drop_down_rounded,
                          collapseIcon: Icons.arrow_drop_up_rounded,
                          tapHeaderToExpand: true,
                          iconPlacement: ExpandablePanelIconPlacement.right),
                      builder: (context, collapsed, expanded) {
                        return Expandable(
                            controller: clientDataC,
                            collapsed: collapsed,
                            expanded: expanded);
                      },
                      header: GestureDetector(
                        onTap: () {
                          if (clickedClientData) {
                            setState(() {
                              clientDataC.toggle();
                              clickedClientData = false;
                            });
                          } else {
                            setState(() {
                              clientDataC.toggle();
                              clickedClientData = true;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: clickedClientData
                                ? []
                                : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 12,
                                        spreadRadius: 2)
                                  ],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Booked By',
                                style: headingText1,
                              ),
                              const Spacer(),
                              Icon(
                                clickedClientData
                                    ? Icons.arrow_drop_up_rounded
                                    : Icons.arrow_drop_down_rounded,
                                size: 38,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                      collapsed: Container(),
                      expanded: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Name: ',
                                  style: headingText2,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: widget.bookingsData['userId']
                                          ['name'],
                                      style: headingText2.copyWith(
                                          fontWeight: FontWeight.w400),
                                    )
                                  ]),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Number: ',
                                style: headingText2,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.bookingsData['userId']
                                        ['contact'],
                                    style: headingText2.copyWith(
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ExpandablePanel(
                      theme: const ExpandableThemeData(
                          hasIcon: false,
                          expandIcon: Icons.arrow_drop_down_rounded,
                          collapseIcon: Icons.arrow_drop_up_rounded,
                          tapHeaderToExpand: true,
                          iconPlacement: ExpandablePanelIconPlacement.right),
                      builder: (context, collapsed, expanded) {
                        return Expandable(
                            controller: servicesForOthersC,
                            collapsed: collapsed,
                            expanded: expanded);
                      },
                      header: GestureDetector(
                        onTap: () {
                          if (servicesForOthersCData) {
                            setState(() {
                              servicesForOthersC.toggle();
                              servicesForOthersCData = false;
                            });
                          } else {
                            setState(() {
                              servicesForOthersC.toggle();
                              servicesForOthersCData = true;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: servicesForOthersCData
                                ? []
                                : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 12,
                                        spreadRadius: 2)
                                  ],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Services Booked For Myself',
                                style: headingText1,
                              ),
                              const Spacer(),
                              Icon(
                                servicesForOthersCData
                                    ? Icons.arrow_drop_up_rounded
                                    : Icons.arrow_drop_down_rounded,
                                size: 38,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                      collapsed: Container(),
                      expanded: widget.bookingsData['purchased'].isEmpty
                          ? const Center(
                              child: Text(
                                  "You Didn't Book Any Service For Yourself"),
                            )
                          : Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    widget.bookingsData['purchased'].length,
                                itemBuilder: (context, index) {
                                  String serviceDateString = widget
                                      .bookingsData['purchased'][index]['data'];
                                  DateTime serviceDateDT =
                                      DateTime.parse(serviceDateString);
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  mainAppColor.withOpacity(0.2),
                                              blurRadius: 10,
                                              spreadRadius: 1)
                                        ]),
                                    child: ListTile(
                                      title: Text(
                                          widget.bookingsData['purchased']
                                              [index]['subtitle']),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.bookingsData['purchased']
                                                  [index]['price'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: mainAppColor),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: 'Booking Schedule: ',
                                                  style: headingText2,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          '${widget.bookingsData['purchased'][index]['data'].toString().substring(0, 10)} at ${DateFormat.jm().format(serviceDateDT)}',
                                                      style:
                                                          headingText2.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    )
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ExpandablePanel(
                      theme: const ExpandableThemeData(
                          hasIcon: false,
                          expandIcon: Icons.arrow_drop_down_rounded,
                          collapseIcon: Icons.arrow_drop_up_rounded,
                          tapHeaderToExpand: true,
                          iconPlacement: ExpandablePanelIconPlacement.right),
                      builder: (context, collapsed, expanded) {
                        return Expandable(
                            controller: servicesForMeC,
                            collapsed: collapsed,
                            expanded: expanded);
                      },
                      header: GestureDetector(
                        onTap: () {
                          if (servicesForMeCData) {
                            setState(() {
                              servicesForMeC.toggle();
                              servicesForMeCData = false;
                            });
                          } else {
                            setState(() {
                              servicesForMeC.toggle();
                              servicesForMeCData = true;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: servicesForMeCData
                                ? []
                                : [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 12,
                                        spreadRadius: 2)
                                  ],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Services Booked For Others',
                                style: headingText1,
                              ),
                              const Spacer(),
                              Icon(
                                servicesForMeCData
                                    ? Icons.arrow_drop_up_rounded
                                    : Icons.arrow_drop_down_rounded,
                                size: 38,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                      collapsed: Container(),
                      expanded: widget.bookingsData['book_for_others'].isEmpty
                          ? const Center(
                              child: Text(
                                  "You Didn't Book Any Service For Anyone Else"),
                            )
                          : Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget
                                    .bookingsData['book_for_others'].length,
                                itemBuilder: (context, index) {
                                  return ExpandablePanel(
                                    theme: const ExpandableThemeData(
                                        hasIcon: true,
                                        expandIcon:
                                            Icons.arrow_drop_down_rounded,
                                        collapseIcon:
                                            Icons.arrow_drop_up_rounded,
                                        tapHeaderToExpand: true,
                                        iconPlacement:
                                            ExpandablePanelIconPlacement.right),
                                    builder: (context, collapsed, expanded) {
                                      return Expandable(
                                          collapsed: collapsed,
                                          expanded: expanded);
                                    },
                                    header: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0, vertical: 8),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.bookingsData[
                                                    'book_for_others'][index]
                                                ['name'],
                                            style: headingText2.copyWith(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            widget.bookingsData[
                                                    'book_for_others'][index]
                                                ['phone'],
                                            style: headingText2.copyWith(
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    collapsed: Container(),
                                    expanded: SizedBox(
                                      // padding:
                                      // const EdgeInsets.symmetric(horizontal: 12),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget
                                            .bookingsData['book_for_others']
                                                [index]['purchases']
                                            .length,
                                        itemBuilder: (context, index2) {
                                          String serviceDateString =
                                              widget.bookingsData[
                                                      'book_for_others'][index]
                                                  ['purchases'][index2]['data'];
                                          DateTime serviceDateDT =
                                              DateTime.parse(serviceDateString);
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: mainAppColor
                                                          .withOpacity(0.2),
                                                      blurRadius: 10,
                                                      spreadRadius: 1)
                                                ]),
                                            child: ListTile(
                                              title: Text(
                                                widget.bookingsData[
                                                            'book_for_others']
                                                        [index]['purchases']
                                                    [index2]['subtitle'],
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.bookingsData[
                                                                  'book_for_others']
                                                              [
                                                              index]['purchases']
                                                          [index2]['price'],
                                                      style:
                                                          headingText3.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  mainAppColor),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        text:
                                                            'Booking Schedule: ',
                                                        style: headingText2,
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                '${widget.bookingsData['purchased'][index]['data'].toString().substring(0, 10)} at ${DateFormat.jm().format(serviceDateDT)}',
                                                            style: headingText2
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
