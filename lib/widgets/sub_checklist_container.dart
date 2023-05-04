import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/custom_colors.dart';
import '../utils/spacers.dart';

class SubChecklistContainer extends StatefulWidget {
  SubChecklistContainer({
    super.key,
    required this.checked,
    required this.iconUrl,
    required this.title,
  });
  bool checked;
  final String title;
  final String iconUrl;

  @override
  State<SubChecklistContainer> createState() => _SubChecklistContainerState();
}

class _SubChecklistContainerState extends State<SubChecklistContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    widget.iconUrl,

                    // height: 30,
                  ),
                  horizontalSpacer(20),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: CustomColors.blackColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Theme(
              data: ThemeData(
                unselectedWidgetColor:
                    CustomColors.kMainColor, // Change the color here
              ),
              child: Checkbox(
                activeColor: CustomColors.kMainColor,
                value: widget.checked,
                onChanged: (value) {
                  setState(() {
                    widget.checked = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
