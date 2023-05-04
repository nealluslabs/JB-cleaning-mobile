import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

PreferredSizeWidget customAppBar() {
  return AppBar(
    iconTheme: const IconThemeData(color: CustomColors.blackColor),
    // leading: GestureDetector(
    //   // onTap: onTap,
    //   child: const Icon(
    //     Icons.menu,
    //     color: CustomColors.blackColor,
    //   ),
    // ),
    title: const Text(
      "J & B Cleaning LLC",
      style: TextStyle(
        color: CustomColors.blackColor,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    ),
    centerTitle: true,
    actions: const [
      Padding(
        padding: EdgeInsets.only(right: 15.0),
        child: Icon(
          Icons.settings,
          color: CustomColors.blackColor,
        ),
      ),
    ],
    backgroundColor: CustomColors.whiteColor,
    elevation: 0,
  );
}
