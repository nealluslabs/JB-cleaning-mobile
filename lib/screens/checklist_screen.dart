import 'package:cleaning_llc/utils/custom_colors.dart';
import 'package:cleaning_llc/utils/spacers.dart';
import 'package:cleaning_llc/widgets/add_button.dart';
import 'package:cleaning_llc/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../widgets/checklist_container.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/navigation_drawer.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});
  static const routeName = '/checklist_screen';

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final List<bool> _checked = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const CustomNavigationDrawer(
        pageIndex: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            verticalSpacer(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Checklist',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: CustomColors.blackColor,
                  ),
                ),
                AddButton(),
              ],
            ),
            verticalSpacer(20),
            Expanded(
              child: ListView(
                children: [
                  ChecklistContainer(
                    checked: _checked[0],
                    title: "Living Room",
                    iconUrl: 'assets/icons/living_room_icon.svg',
                  ),
                  verticalSpacer(20),
                  ChecklistContainer(
                    checked: _checked[1],
                    title: "Bedroom 1",
                    iconUrl: 'assets/icons/bedroom_icon.svg',
                  ),
                  verticalSpacer(20),
                  ChecklistContainer(
                    checked: _checked[2],
                    title: "Bedroom 2",
                    iconUrl: 'assets/icons/bedroom_icon.svg',
                  ),
                  verticalSpacer(20),
                  ChecklistContainer(
                    checked: _checked[3],
                    title: "Kitchen",
                    iconUrl: 'assets/icons/kitchen_icon.svg',
                  ),
                  verticalSpacer(20),
                  ChecklistContainer(
                    checked: _checked[4],
                    title: "Bathroom 1",
                    iconUrl: 'assets/icons/bathroom_icon.svg',
                  ),
                  verticalSpacer(20),
                  ChecklistContainer(
                    checked: _checked[5],
                    title: "Bathroom 2",
                    iconUrl: 'assets/icons/bathroom_icon.svg',
                  ),
                  verticalSpacer(20),
                  ChecklistContainer(
                    checked: _checked[6],
                    title: "Guest Bathroom",
                    iconUrl: 'assets/icons/guest_bath_icon.svg',
                  ),
                  verticalSpacer(25),
                  const CustomButton(title: "Submit")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
