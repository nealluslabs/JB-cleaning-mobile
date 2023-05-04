import 'package:cleaning_llc/screens/checklist_screen.dart';
import 'package:cleaning_llc/screens/issues_screen.dart';
import 'package:cleaning_llc/screens/time_log_screen.dart';
import 'package:cleaning_llc/utils/custom_colors.dart';
import 'package:cleaning_llc/utils/spacers.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/home_container.dart';
import '../widgets/navigation_drawer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const routeName = '/profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const CustomNavigationDrawer(
        pageIndex: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpacer(20),
            const Text.rich(
              TextSpan(
                text: 'Welcome ',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w400,
                  color: CustomColors.blackColor,
                ),
                children: [
                  TextSpan(
                    text: 'Bonita',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: CustomColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacer(30),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  const HomeContainer(
                    isActive: true,
                    title: "Profile",
                    iconUrl: 'assets/icons/profile_icon.svg',
                  ),
                  horizontalSpacer(20),
                  HomeContainer(
                    title: "Issues",
                    iconUrl: 'assets/icons/issues_icon.svg',
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, IssuesScreen.routeName);
                    },
                  )
                ],
              ),
            ),
            verticalSpacer(15),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  HomeContainer(
                    title: "Checklists",
                    iconUrl: 'assets/icons/checklist_icon.svg',
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, ChecklistScreen.routeName);
                    },
                  ),
                  horizontalSpacer(20),
                  HomeContainer(
                    title: "Time Log",
                    iconUrl: 'assets/icons/clock_icon.svg',
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, TimeLogScreen.routeName);
                    },
                  )
                ],
              ),
            ),
            verticalSpacer(15),
            const Text(
              'Schedule',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
                color: CustomColors.blackColor,
              ),
            ),
            verticalSpacer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '09 | 09 | 23',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: CustomColors.blackColor,
                  ),
                ),
                CustomButton(title: "View")
              ],
            ),
            verticalSpacer(5),
            const Divider(
              color: CustomColors.blackColor,
            )
          ],
        ),
      ),
    );
  }
}
