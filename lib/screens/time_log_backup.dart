// import 'package:cleaning_llc/utils/custom_colors.dart';
// import 'package:cleaning_llc/utils/spacers.dart';
// import 'package:flutter/material.dart';

// import '../widgets/add_button.dart';
// import '../widgets/custom_appbar.dart';
// import '../widgets/custom_button.dart';
// import '../widgets/navigation_drawer.dart';

// class TimeLogScreen extends StatefulWidget {
//   const TimeLogScreen({super.key});
//   static const routeName = '/time_log_screen';

//   @override
//   State<TimeLogScreen> createState() => _TimeLogScreenState();
// }

// class _TimeLogScreenState extends State<TimeLogScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final List<String> _activeList = [
//     '09 | 09 | 23',
//     '09 | 10 | 23',
//     '09 | 13 | 23',
//   ];
//   final List<String> _inactiveList = [
//     '09 | 10 | 23',
//     '09 | 13 | 23',
//     '09 | 09 | 23',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//         length: 2, vsync: this); // Create TabController with 2 tabs
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(),
//       drawer: const CustomNavigationDrawer(
//         pageIndex: 5,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               verticalSpacer(20),
//               Container(
//                 decoration: BoxDecoration(
//                     color: CustomColors.whiteColor,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset:
//                             const Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(20)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Time Log',
//                         style: TextStyle(
//                           fontSize: 23,
//                           fontWeight: FontWeight.w700,
//                           color: CustomColors.blackColor,
//                         ),
//                       ),
//                       verticalSpacer(15),
//                       const TextField(
//                         maxLines: 1,
//                         decoration: InputDecoration(
//                           hintText: "Enter time",
//                           border: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: Colors.grey, width: 1.0),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0)),
//                           ),
//                           contentPadding: EdgeInsets.all(10.0),
//                         ),
//                       ),
//                       verticalSpacer(15),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           const AddButton(),
//                           horizontalSpacer(10),
//                           const CustomButton(
//                             title: 'Send',
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               verticalSpacer(30),
//               TabBar(
//                 labelColor: CustomColors.whiteColor,
//                 unselectedLabelColor: CustomColors.blackColor,
//                 labelStyle: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                 ),
//                 unselectedLabelStyle: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                 ),

//                 indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: CustomColors.kMainColor,
//                 ),
//                 controller: _tabController, // Assign TabController to TabBar
//                 tabs: const [
//                   Tab(
//                     text: 'Time Stamp',
//                   ),
//                   Tab(
//                     text: 'History',
//                   ),
//                 ],
//               ),
//               verticalSpacer(20),
//               SizedBox(
//                 height: 300,
//                 child: TabBarView(
//                   controller:
//                       _tabController, // Assign TabController to TabBarView
//                   children: [
//                     ActiveList(
//                       activeList: _activeList,
//                     ),
//                     InactiveList(
//                       inActiveList: _inactiveList,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ActiveList extends StatelessWidget {
//   const ActiveList({required this.activeList, super.key});
//   final List<String> activeList;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: activeList.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     activeList[index],
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: CustomColors.blackColor,
//                     ),
//                   ),
//                   const CustomButton(title: "View")
//                 ],
//               ),
//               verticalSpacer(5),
//               const Divider(
//                 color: CustomColors.blackColor,
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class InactiveList extends StatelessWidget {
//   const InactiveList({required this.inActiveList, super.key});
//   final List<String> inActiveList;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: inActiveList.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     inActiveList[index],
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: CustomColors.blackColor,
//                     ),
//                   ),
//                   const CustomButton(title: "View")
//                 ],
//               ),
//               verticalSpacer(5),
//               const Divider(
//                 color: CustomColors.blackColor,
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
