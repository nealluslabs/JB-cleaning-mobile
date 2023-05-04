import 'package:cleaning_llc/utils/custom_colors.dart';
import 'package:cleaning_llc/utils/spacers.dart';
import 'package:cleaning_llc/widgets/add_button.dart';
import 'package:cleaning_llc/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../widgets/checklist_container.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/sub_checklist_container.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});
  static const routeName = '/item_screen';

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final List<bool> _checked = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const CustomNavigationDrawer(
        pageIndex: 4,
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
                  'Items',
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
                  SubChecklistContainer(
                    checked: _checked[1],
                    title: "Television",
                    iconUrl: 'assets/icons/bedroom_icon.svg',
                  ),
                  verticalSpacer(20),
                  SubChecklistContainer(
                    checked: _checked[2],
                    title: "Fan",
                    iconUrl: 'assets/icons/bedroom_icon.svg',
                  ),
                  verticalSpacer(20),
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
