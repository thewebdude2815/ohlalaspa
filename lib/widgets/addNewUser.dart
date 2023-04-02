import 'package:flutter/material.dart';
import 'package:ohlalaspa/constants/appConstants.dart';
import 'package:ohlalaspa/constants/texts.dart';
import 'package:ohlalaspa/screens/bookingMenus/bookForSomeone.dart';
import 'package:ohlalaspa/widgets/textFieldSpaApp.dart';
import 'package:select_dialog/select_dialog.dart';

class AddNewUser extends StatefulWidget {
  var finalList;
  TextEditingController nameC;
  TextEditingController numberC;

  AddNewUser(
      {super.key,
      required this.finalList,
      required this.nameC,
      required this.numberC});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Text(
          'Add Details Of Others',
          style: headingText2.copyWith(color: mainAppColor),
        )),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: TextFieldSpaApp(
            idController: widget.nameC,
            hintTxt: "Name",
            textInputType: TextInputType.text,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: TextFieldSpaApp(
            idController: widget.numberC,
            hintTxt: "Number",
            textInputType: TextInputType.number,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  SelectDialog.showModal<String>(
                    context,
                    label: "Select Services",
                    multipleSelectedValues: services,
                    items: List.generate(widget.finalList.length,
                        (index) => widget.finalList[index]['subtitle']),
                    onMultipleItemsChange: (List<String> selected) {
                      setState(() {
                        services = selected;
                      });
                    },
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text('Select Services'),
                ),
              ),
            ),
          ],
        ),
        Text(
          '${services.length} Services Selected',
          style: headingText4,
        )
      ],
    );
  }
}
