import 'package:cleaning_llc/screens/checklist_screen.dart';
import 'package:cleaning_llc/screens/issues_screen.dart';
import 'package:cleaning_llc/screens/items_screen.dart';
import 'package:cleaning_llc/screens/profile_screen.dart';
import 'package:cleaning_llc/screens/time_log_screen.dart';

var appRoutes = {
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  IssuesScreen.routeName: (context) => const IssuesScreen(),
  ChecklistScreen.routeName: (context) => const ChecklistScreen(),
  TimeLogScreen.routeName: (context) => const TimeLogScreen(),
  ItemsScreen.routeName: (context) => const ItemsScreen(),
};
