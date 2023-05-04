import 'package:flutter/material.dart';

import '../utils/custom_colors.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColors.kMainColor),
      ),
      child: const Icon(
        Icons.add,
        color: CustomColors.kMainColor,
      ),
    );
  }
}
