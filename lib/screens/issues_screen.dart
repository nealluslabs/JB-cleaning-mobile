import 'package:cleaning_llc/utils/custom_colors.dart';
import 'package:cleaning_llc/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/property_model.dart';
import '../widgets/add_button.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/navigation_drawer.dart';
import 'auth/auth_view_model.dart';

class IssuesScreen extends StatefulHookConsumerWidget {
  const IssuesScreen({super.key});
  static const routeName = '/issues_screen';

  @override
  ConsumerState<IssuesScreen> createState() => _IssuesScreenState();
}

class _IssuesScreenState extends ConsumerState<IssuesScreen>
    with SingleTickerProviderStateMixin {
  String _selectedOption = 'Bedroom';
  // String _selectedProperty = 'Property 1';
  late TabController _tabController;
  final List<String> _activeList = [
    'Kitchen Sink',
    'Bedroom Ceiling',
    'Front Door'
  ];
  final List<String> _inactiveList = [
    'Bedroom Ceiling',
    'Front Door',
    'Kitchen Sink',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this); // Create TabController with 2 tabs
  }

  @override
  Widget build(BuildContext context) {
    final issuesVM = ref.watch(authProvider);
    String? propertyName = ref.watch(propertyNameProvider);
    Property? propertyState = ref.watch(propertyProvider);
    return Scaffold(
      appBar: customAppBar(),
      drawer: const CustomNavigationDrawer(
        pageIndex: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacer(20),
              Container(
                decoration: BoxDecoration(
                    color: CustomColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Property ',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.blackColor,
                        ),
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
                                  .getAllCompanyProperty(
                                      context: context, ref: ref),
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
                                      hint: const Text("Select Property ..."),
                                      isExpanded: true,
                                      elevation: 0,
                                      value: ref
                                                  .watch(propertyNameProvider
                                                      .notifier)
                                                  .state ==
                                              null
                                          ? null
                                          : ref
                                              .watch(
                                                  propertyNameProvider.notifier)
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
                                        ref
                                            .read(propertyNameProvider.notifier)
                                            .state = value;
                                        print("object");
                                        print(ref.watch(propertyProvider));
                                        print(propertyName);
                                        print(propertyState);
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
                      const Text(
                        'Room ',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.blackColor,
                        ),
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
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              elevation: 0,
                              value: _selectedOption,
                              items: const [
                                DropdownMenuItem(
                                  value: 'Bedroom',
                                  child: Text('Bedroom'),
                                ),
                                DropdownMenuItem(
                                  value: 'Bathroom',
                                  child: Text('Bathroom'),
                                ),
                                DropdownMenuItem(
                                  value: 'Restroom',
                                  child: Text('Restroom'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      verticalSpacer(15),
                      const Text(
                        'Issues ',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.blackColor,
                        ),
                      ),
                      verticalSpacer(15),
                      TextFormField(
                        maxLines: 4,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                      ),
                      verticalSpacer(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const AddButton(),
                          horizontalSpacer(10),
                          const CustomButton(
                            title: 'Send',
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              verticalSpacer(30),
              TabBar(
                labelColor: CustomColors.whiteColor,
                unselectedLabelColor: CustomColors.blackColor,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),

                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.kMainColor,
                ),
                controller: _tabController, // Assign TabController to TabBar
                tabs: const [
                  Tab(
                    text: 'Active',
                  ),
                  Tab(
                    text: 'Inactive',
                  ),
                ],
              ),
              verticalSpacer(20),
              SizedBox(
                height: 300,
                child: TabBarView(
                  controller:
                      _tabController, // Assign TabController to TabBarView
                  children: [
                    ActiveList(
                      activeList: _activeList,
                    ),
                    InactiveList(
                      inActiveList: _inactiveList,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActiveList extends StatelessWidget {
  const ActiveList({required this.activeList, super.key});
  final List<String> activeList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activeList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    activeList[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.blackColor,
                    ),
                  ),
                  const CustomButton(title: "View")
                ],
              ),
              verticalSpacer(5),
              const Divider(
                color: CustomColors.blackColor,
              )
            ],
          ),
        );
      },
    );
  }
}

class InactiveList extends StatelessWidget {
  const InactiveList({required this.inActiveList, super.key});
  final List<String> inActiveList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: inActiveList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    inActiveList[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.blackColor,
                    ),
                  ),
                  const CustomButton(title: "View")
                ],
              ),
              verticalSpacer(5),
              const Divider(
                color: CustomColors.blackColor,
              )
            ],
          ),
        );
      },
    );
  }
}
