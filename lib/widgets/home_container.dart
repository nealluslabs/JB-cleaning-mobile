import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/custom_colors.dart';
import '../utils/spacers.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    super.key,
    this.isActive = false,
    this.onTap,
    required this.iconUrl,
    required this.title,
  });
  final bool isActive;
  final String title;
  final String iconUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color:
              isActive ? CustomColors.kMainColor : CustomColors.kLightMainColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isActive
                    ? CustomColors.whiteColor
                    : CustomColors.blackColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            verticalSpacer(20),
            SvgPicture.asset(
              iconUrl,
              color:
                  isActive ? CustomColors.whiteColor : CustomColors.blackColor,
              // height: 30,
            ),
          ],
        ),
      ),
    ));
  }
}
