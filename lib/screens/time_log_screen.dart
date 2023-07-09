import 'dart:async';

import 'package:cleaning_llc/utils/custom_colors.dart';
import 'package:cleaning_llc/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/navigation_drawer.dart';
import 'auth/auth_view_model.dart';

class TimeLogScreen extends StatefulHookConsumerWidget {
  const TimeLogScreen({super.key});
  static const routeName = '/time_log_screen';

  @override
  ConsumerState<TimeLogScreen> createState() => _TimeLogScreenState();
}

class _TimeLogScreenState extends ConsumerState<TimeLogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Timer? _timer;
  int _seconds = 0;
  late SharedPreferences _prefs;
  bool _timerRunning = false;
  List<String> allTimeLogs = [];

  final List<String> _inactiveList = [
    '09 | 10 | 23',
    '09 | 13 | 23',
    '09 | 09 | 23',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final timeLogVM = ref.watch(authProvider);
      var timeLog = await timeLogVM.getAllUsersTImelog(ref: ref);
      allTimeLogs = timeLog;
      setState(() {});
    });
    _loadSavedTimer();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _loadSavedTimer() async {
    _prefs = await SharedPreferences.getInstance();
    int? startTime = _prefs.getInt('start_time');
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int elapsedSeconds =
        startTime == null ? 0 : ((currentTime - startTime) / 1000).floor();

    setState(() {
      _seconds = _prefs.getInt('timer') ?? 0;
    });

    if (elapsedSeconds > 0) {
      _seconds += elapsedSeconds;
      _startTimer();
    }
  }

  void _startTimer() async {
    if (_timerRunning) return;

    _timerRunning = true;
    _prefs.setInt('start_time', DateTime.now().millisecondsSinceEpoch);
    var clockedIn = DateTime.now();
    final timeLogVM = ref.watch(authProvider);
    await timeLogVM.saveUserTimeLogClockIn(
        ref: ref, context: context, timeLog: clockedIn);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        _prefs.setInt('timer', _seconds);
      });
    });
  }

  void _stopTimer() async {
    if (!_timerRunning) return;

    _timerRunning = false;
    _seconds = 0;
    _timer?.cancel();
    _prefs.setInt('timer', _seconds);
    _prefs.remove('start_time');

    allTimeLogs.add(DateFormat('dd | MM | yy').format(DateTime.now()));
    var clockedOut = DateTime.now();
    final timeLogVM = ref.watch(authProvider);

    // await timeLogVM.saveUserTimeLog(
    //     ref: ref, context: context, timeLog: allTimeLogs);

    await timeLogVM.saveUserTimeLogClockOut(
        ref: ref, context: context, clockOut: clockedOut);
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    String timerText = _formatTime(_seconds);

    return Scaffold(
      appBar: customAppBar(),
      drawer: const CustomNavigationDrawer(
        pageIndex: 5,
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Time Log',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.blackColor,
                        ),
                      ),
                      verticalSpacer(15),
                      Center(
                        child: Text(
                          timerText,
                          style: const TextStyle(
                              fontSize: 48, fontWeight: FontWeight.w300),
                        ),
                      ),
                      verticalSpacer(15),
                    ],
                  ),
                ),
              ),
              verticalSpacer(30),
              GestureDetector(
                onTap: _startTimer,
                child: CustomButton(
                  title: 'Clock In',
                  height: 45,
                  isOutlined: _timerRunning,
                ),
              ),
              verticalSpacer(10),
              GestureDetector(
                onTap: _stopTimer,
                child: CustomButton(
                  title: 'Clock Out',
                  height: 45,
                  isOutlined: !_timerRunning,
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
                controller: _tabController,
                tabs: const [
                  Tab(
                    text: 'Time Stamp',
                  ),
                  Tab(
                    text: 'History',
                  ),
                ],
              ),
              verticalSpacer(20),
              SizedBox(
                height: 300,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ActiveList(
                      activeList: allTimeLogs,
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
