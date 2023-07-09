import 'package:cleaning_llc/screens/issues_screen.dart';
import 'package:cleaning_llc/screens/items_screen.dart';
import 'package:cleaning_llc/screens/profile_screen.dart';
import 'package:cleaning_llc/screens/time_log_screen.dart';
import 'package:cleaning_llc/utils/custom_colors.dart';
import 'package:cleaning_llc/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/checklist_screen_backup.dart';

class CustomNavigationDrawer extends StatefulWidget {
  final int pageIndex;
  const CustomNavigationDrawer({Key? key, required this.pageIndex})
      : super(key: key);

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 240,
      backgroundColor: CustomColors.whiteColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(
              context,
              widget.pageIndex,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.25,
    decoration: const BoxDecoration(
      color: CustomColors.kMainColor,
    ),
    child: Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "J & B",
            style: TextStyle(
                color: CustomColors.whiteColor,
                fontWeight: FontWeight.w700,
                fontSize: 20),
          ),
          verticalSpacer(10),
          const Text(
            "Cleaning LLC",
            style: TextStyle(
                color: CustomColors.whiteColor,
                fontWeight: FontWeight.w700,
                fontSize: 20),
          ),
          verticalSpacer(35),
        ],
      ),
    ),
  );
// //
}

class SideMenus extends StatelessWidget {
  SideMenus({
    this.padding = 16,
    this.color = Colors.white,
    required this.onClick,
    required this.iconUrl,
    required this.title,
    //required onClick,
    Key? key,
  }) : super(key: key);
  final String iconUrl;
  final String title;
  double padding;
  Color color;
  VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: ListTile(
        horizontalTitleGap: 4,
        // contentPadding: EdgeInsets.symmetric(horizontal: padding),
        leading: SvgPicture.asset(
          iconUrl,
          color: Colors.grey,
          height: 30,
          // height: 30,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w700, color: color, fontSize: 22),
        ),
        onTap: onClick,
      ),
    );
  }
}

Widget buildMenuItems(
  BuildContext context,
  int pageIndex,
) {
  return Column(
    children: [
      // SideDivider(),
      verticalSpacer(40),
      SideMenus(
          color: pageIndex == 1
              ? CustomColors.kMainColor
              : CustomColors.blackColor,
          iconUrl: 'assets/icons/profile_icon.svg',
          title: 'Profile',
          onClick: pageIndex == 1
              ? () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                }
              : () {
                  Navigator.pushReplacementNamed(
                      context, ProfileScreen.routeName);
                }),

      // SideDivider(),
      SideMenus(
          color: pageIndex == 2
              ? CustomColors.kMainColor
              : CustomColors.blackColor,
          iconUrl: 'assets/icons/issues_icon.svg',
          title: 'Issues',
          onClick: pageIndex == 2
              ? () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                }
              : () {
                  Navigator.pushReplacementNamed(
                      context, IssuesScreen.routeName);
                }),
      SideMenus(
          color: pageIndex == 3
              ? CustomColors.kMainColor
              : CustomColors.blackColor,
          iconUrl: 'assets/icons/checklist_icon.svg',
          title: 'Check Lists',
          padding: 40,
          onClick: pageIndex == 3
              ? () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                }
              : () {
                  Navigator.pushReplacementNamed(
                      context, ChecklistScreen.routeName);
                }),
      SideMenus(
          color: pageIndex == 4
              ? CustomColors.kMainColor
              : CustomColors.blackColor,
          iconUrl: 'assets/icons/checklist_icon.svg',
          title: 'Items',
          padding: 40,
          onClick: pageIndex == 4
              ? () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                }
              : () {
                  Navigator.pushReplacementNamed(
                      context, ItemsScreen.routeName);
                }),
      SideMenus(
          color: pageIndex == 5
              ? CustomColors.kMainColor
              : CustomColors.blackColor,
          iconUrl: 'assets/icons/clock_icon.svg',
          title: 'Time Log',
          padding: 40,
          onClick: pageIndex == 5
              ? () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                }
              : () {
                  Navigator.pushReplacementNamed(
                      context, TimeLogScreen.routeName);
                }),
    ],
  );
}
