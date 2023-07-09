import 'package:cleaning_llc/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../screens/auth/auth_view_model.dart';
import '../utils/custom_colors.dart';
import '../utils/spacers.dart';

class ChecklistContainer extends StatefulHookConsumerWidget {
  ChecklistContainer({
    super.key,
    required this.checked,
    required this.iconUrl,
    required this.title,
    this.check = Checks.unknown,
  });
  bool checked;
  final String title;
  final String iconUrl;
  final Checks check;

  @override
  ConsumerState<ChecklistContainer> createState() => _ChecklistContainerState();
}

class _ChecklistContainerState extends ConsumerState<ChecklistContainer> {
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
            Row(
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
            Theme(
              data: ThemeData(
                unselectedWidgetColor:
                    CustomColors.kMainColor, // Change the color here
              ),
              child: Checkbox(
                activeColor: CustomColors.kMainColor,
                value: widget.check == Checks.tv
                    ? ref.watch(tvCheck.notifier).state
                    : widget.check == Checks.fan
                        ? ref.watch(fanCheck.notifier).state
                        : widget.checked,
                onChanged: (value) {
                  setState(() {
                    if (widget.check == Checks.tv) {
                      ref.read(tvCheck.notifier).state = value!;
                    } else if (widget.check == Checks.fan) {
                      ref.read(fanCheck.notifier).state = value!;
                    } else {
                      widget.checked = value!;
                    }
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
