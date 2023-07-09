import 'package:cleaning_llc/utils/custom_colors.dart';
import 'package:cleaning_llc/utils/spacers.dart';
import 'package:cleaning_llc/widgets/add_button.dart';
import 'package:cleaning_llc/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/property_model.dart';
import '../widgets/checklist_container.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/navigation_drawer.dart';
import 'auth/auth_view_model.dart';

class ChecklistScreen extends StatefulHookConsumerWidget {
  const ChecklistScreen({super.key});
  static const routeName = '/checklist_screen';

  @override
  ConsumerState<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends ConsumerState<ChecklistScreen> {
  final List<bool> _checked = [false, false, false, false, false, false, false];

  String selectedPropertyId = '';
  String selectedRoomId = '';

  @override
  Widget build(BuildContext context) {
    final issuesVM = ref.watch(authProvider);
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
            Row(
              children: const [
                Text(
                  'Property ',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: CustomColors.blackColor,
                  ),
                ),
              ],
            ),
            verticalSpacer(15),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: FutureBuilder<List<Property>?>(
                    future: AuthViewModel.initWhoAmI()
                        .getAllCompanyProperty(context: context, ref: ref),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While the data is loading, display a loader
                        return const Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError) {
                        // If there's an error, display an error message
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        // Future.delayed(Duration.zero, () {
                        //   ref
                        //       .read(propertNameProvider.notifier)
                        //       .state = snapshot.data![0].propertyName;
                        // });
                        // Future.delayed(() {
                        //   ref
                        //       .read(propertNameProvider.notifier)
                        //       .state = snapshot.data![0].propertyName;
                        // });
                        // ref.read(propertNameProvider.notifier).state =
                        //     snapshot.data![0].propertyName;
                        return DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: const Text("Select Property ..."),
                            isExpanded: true,
                            elevation: 0,
                            value: ref
                                        .watch(propertyNameProvider.notifier)
                                        .state ==
                                    null
                                ? null
                                : ref
                                    .watch(propertyNameProvider.notifier)
                                    .state!,
                            //  ??
                            //     snapshot.data![0].propertyName,
                            items: snapshot.data!.map((property) {
                              return DropdownMenuItem(
                                value: property.id,
                                child: Text(property.propertyName!),
                              );
                            }).toList(),

                            onChanged: (value) {
                              // ref
                              //     .read(propertyNameProvider.notifier)
                              //     .state = value!.propertyName;
                              ref.read(propertyNameProvider.notifier).state =
                                  value;

                              setState(() {
                                selectedPropertyId = value ?? '';
                              });
                              // print("object");
                              // print(ref.watch(propertyProvider));
                              // print(propertyName);
                              // print(propertyState);
                              // setState(() {
                              //   ref
                              //       .read(
                              //           propertyNameProvider.notifier)
                              //       .state = value!.propertyName;
                              //   ref
                              //       .read(propertyProvider.notifier)
                              //       .state = value;
                              //   // propertyName = value!;
                              //   // _selectedProperty = value!;
                              // });
                            },
                          ),
                        );
                      } else {
                        // If there's no data available, display an empty state
                        return const Text('No data available');
                      }
                    }),
              ),
            ),
            verticalSpacer(15),
            Row(
              children: const [
                Text(
                  'Room ',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: CustomColors.blackColor,
                  ),
                ),
              ],
            ),
            verticalSpacer(15),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: selectedPropertyId.isEmpty
                    ? DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: const Text("Select Room ..."),
                          isExpanded: true,
                          elevation: 0,
                          value: null,
                          items: null,
                          onChanged: (value) {},
                        ),
                      )
                    : FutureBuilder<List<String>?>(
                        future: AuthViewModel.initWhoAmI().getAllPropertyRooms(
                            context: context,
                            ref: ref,
                            propertyId: selectedPropertyId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // While the data is loading, display a loader
                            return const Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator()),
                            );
                          } else if (snapshot.hasError) {
                            // If there's an error, display an error message
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            // Future.delayed(Duration.zero, () {
                            //   ref
                            //       .read(propertNameProvider.notifier)
                            //       .state = snapshot.data![0].propertyName;
                            // });
                            // Future.delayed(() {
                            //   ref
                            //       .read(propertNameProvider.notifier)
                            //       .state = snapshot.data![0].propertyName;
                            // });
                            // ref.read(propertNameProvider.notifier).state =
                            //     snapshot.data![0].propertyName;
                            return DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: const Text("Select Room ..."),
                                isExpanded: true,
                                elevation: 0,
                                value: ref
                                            .watch(roomNameProvider.notifier)
                                            .state ==
                                        null
                                    ? null
                                    : ref
                                        .watch(roomNameProvider.notifier)
                                        .state!,
                                //  ??
                                //     snapshot.data![0].propertyName,
                                items: snapshot.data!.map((room) {
                                  return DropdownMenuItem(
                                    value: room,
                                    child: Text(room),
                                  );
                                }).toList(),

                                onChanged: (value) {
                                  // ref
                                  //     .read(propertyNameProvider.notifier)
                                  //     .state = value!.propertyName;
                                  ref.read(roomNameProvider.notifier).state =
                                      value;
                                  setState(() {
                                    selectedRoomId = value ?? '';
                                  });

                                  print("object");
                                  print(ref.watch(roomNameProvider));
                                  // print(propertyName);
                                  // print(propertyState);
                                  // setState(() {
                                  //   ref
                                  //       .read(
                                  //           propertyNameProvider.notifier)
                                  //       .state = value!.propertyName;
                                  //   ref
                                  //       .read(propertyProvider.notifier)
                                  //       .state = value;
                                  //   // propertyName = value!;
                                  //   // _selectedProperty = value!;
                                  // });
                                },
                              ),
                            );
                          } else {
                            // If there's no data available, display an empty state
                            return const Text('No data available');
                          }
                        }),
              ),
            ),
            verticalSpacer(15),
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
                  GestureDetector(
                      onTap: () {
                        print(_checked);
                      },
                      child: const CustomButton(title: "Submit"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
