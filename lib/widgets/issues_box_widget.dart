import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

class IssuesBox extends StatefulWidget {
  const IssuesBox({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<IssuesBox> createState() => _IssuesBoxState();
}

class _IssuesBoxState extends State<IssuesBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Text(
          widget.title,
          style: const TextStyle(
            color: CustomColors.blackColor,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
