import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.isLoading = false,
    this.height = 40,
    this.isOutlined = false,
  });
  final String title;
  final bool isLoading;
  final bool isOutlined;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isOutlined ? Colors.transparent : CustomColors.kMainColor,
          border: Border.all(
              color:
                  isOutlined ? CustomColors.kMainColor : Colors.transparent)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isOutlined
                        ? CustomColors.kMainColor
                        : CustomColors.whiteColor,
                  ),
                ),
        ),
      ),
    );
  }
}
