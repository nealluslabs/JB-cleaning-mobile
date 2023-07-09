import 'dart:async';
import 'dart:convert';

import 'package:cleaning_llc/models/user_data.dart';
import 'package:cleaning_llc/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/app_user_model.dart';
import '../../models/property_model.dart';
import '../../utils/custom_string.dart';
import '../../view_model/base_change_notifier.dart';

final authProvider = ChangeNotifierProvider.autoDispose<AuthViewModel>((ref) {
  return AuthViewModel.initWhoAmI();
});

class AuthViewModel extends BaseChangeNotifier {
  bool _isloading;

  String authorized = 'Not Authorized';

  AuthViewModel.initWhoAmI()
      : _isloading = false,
        _userId = "",
        _userName = "",
        _password = "",
        _email = "";
  AuthViewModel.profile()
      : _userId = "",
        _userName = "",
        _email = "",
        _password = "",
        _isloading = false;

  bool get isLoading => _isloading;
  String _email, _userId, _userName, _password = "";

  String get email => _email;
  String get password => _password;
  String get userId => _userId;

  String get userName => _userName;

  set isLoading(bool isloading) {
    _isloading = isloading;
    notifyListeners();
  }

  // FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required int companyId,
      BuildContext? context}) async {
    try {
      isLoading = true;

      if (companyId != 0) {
        var company = await userRepository.getCompanyFromId(companyId);
        // .getEmployerFromNumber(event.employerNumber);
        if (company == null) {
          isLoading = false;
          ScaffoldMessenger.of(context!)
            ..removeCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text(
                'Employer Number is not valid, Contact your Organization',
              ),
              backgroundColor: Colors.red,
            ));
          return;
        }
      }
      final user = await userRepository.createUserWithEmail(
        email,
        password,
      );

      if (user != null) {
        _email = email;
        var userId = await userRepository.saveUserCredentials(
            email, firstName, lastName, companyId, password, DateTime.now());

        if (userId != null) {
          AppUser user = AppUser(id: userId, userName: userName, email: email);
          final userJson = json.encode(user.toJson());
          localCache.saveToLocalCache(
              key: ConstantString.userJson, value: userJson);
        }

        isLoading = false;
        Navigator.of(context!).pushNamed(
          ProfileScreen.routeName,
        );

        // navigationHandler.pushNamed(
        //   ProfileScreen.routeName,
        // );
      } else {
        isLoading = false;

        // GenericDialog().showSimplePopup(
        //   type: InfoBoxType.warning,
        //   title: ConstantString.apiErrorResponseTitle,
        //   content: res.message,
        // );
      }
    } catch (e, stacktrace) {
      isLoading = false;
      ScaffoldMessenger.of(context!)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<void> signIn(email, password, {BuildContext? context}) async {
    try {
      isLoading = true;
      final user = await userRepository.loginWithEmail(
        email,
        password,
      );

      if (user != null) {
        _email = email;
        var user = await userRepository.getUsersCredentials();

        if (user != null) {
          final userJson = json.encode(user.toJson());
          localCache.saveToLocalCache(
              key: ConstantString.userJson, value: userJson);
        }

        isLoading = false;

        // navigationHandler.pushNamed(
        //   ProfileScreen.routeName,
        // );
        Navigator.of(context!).pushNamed(
          ProfileScreen.routeName,
        );
      } else {
        isLoading = false;
      }
    } catch (e, stacktrace) {
      isLoading = false;
      ScaffoldMessenger.of(context!)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future<UserDataModel?> getUsersCredentialsLocal() async {
    var userData = localCache.getUserData();
    return userData;
  }

  Future<List<String>> getAllUsersTImelog(
      {BuildContext? context, required WidgetRef ref}) async {
    try {
      var userTimeLog = await userRepository.getUsersCredentials();

      if (userTimeLog != null) {
        List<String> result = userTimeLog.timeLog.map((item) {
          var clockedOut = item.clockOut;
          print(clockedOut);
          return DateFormat('dd | MM | yy').format(clockedOut).toString();
        }).toList();
        return result;
        // ref.read(propertNameProvider.notifier).state =
        //     properties[0].propertyName;
        //     snapshot.data![0].propertyName;
      } else {
        isLoading = false;
        return [];
      }
    } catch (e, stacktrace) {
      isLoading = false;
      print(e.toString());
      // ScaffoldMessenger.of(context!)
      //   ..removeCurrentSnackBar()
      //   ..showSnackBar(SnackBar(
      //     content: Text(e.toString()),
      //     backgroundColor: Colors.red,
      //   ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
    return [];
  }

  Future<List<Property>?> getAllCompanyProperty(
      {BuildContext? context, required WidgetRef ref}) async {
    try {
      isLoading = true;
      UserDataModel data = localCache.getUserData();
      final properties =
          await userRepository.getAllCompanyProperty(data.companyId);

      if (properties != null) {
        isLoading = false;
        // ref.read(propertNameProvider.notifier).state =
        //     properties[0].propertyName;
        //     snapshot.data![0].propertyName;
        return properties;
      } else {
        isLoading = false;
        return [];
      }
    } catch (e, stacktrace) {
      isLoading = false;
      print(e.toString());
      // ScaffoldMessenger.of(context!)
      //   ..removeCurrentSnackBar()
      //   ..showSnackBar(SnackBar(
      //     content: Text(e.toString()),
      //     backgroundColor: Colors.red,
      //   ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
    return null;
  }

  Future<List<String>?> getAllPropertyRooms(
      {BuildContext? context,
      required WidgetRef ref,
      required String propertyId}) async {
    try {
      isLoading = true;
      final rooms = await userRepository.getAllPropertyRooms(propertyId);

      if (rooms != null) {
        List<String> data = rooms.map((item) => item.toString()).toList();
        isLoading = false;
        // ref.read(propertNameProvider.notifier).state =
        //     properties[0].propertyName;
        //     snapshot.data![0].propertyName;
        // return rooms;
        return data;
      } else {
        isLoading = false;
        return [];
      }
    } catch (e, stacktrace) {
      isLoading = false;
      print(e.toString());
      // ScaffoldMessenger.of(context!)
      //   ..removeCurrentSnackBar()
      //   ..showSnackBar(SnackBar(
      //     content: Text(e.toString()),
      //     backgroundColor: Colors.red,
      //   ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
    return null;
  }

  Future saveUserIssues({
    BuildContext? context,
    required WidgetRef ref,
    required String propertyId,
    required String roomId,
    required List<String> description,
    // required String workerId,
    required DateTime issueCreated,
    // required bool functionalTv,
    // required bool functionalFan,
    // required List<String> listedIssues,
  }) async {
    try {
      isLoading = true;
      UserDataModel data = localCache.getUserData();
      final result = await userRepository.saveUserIssues(
        propertyId: propertyId,
        roomId: roomId,
        companyId: data.companyId,
        description: description,
        issueCreated: issueCreated,
        // workerId: workerId,
        // functionalTv: functionalTv,
        // functionalFan: functionalFan,
        // listedIssues: listedIssues,
      );

      if (result) {
        isLoading = false;
        // ref.read(propertNameProvider.notifier).state =
        //     properties[0].propertyName;
        //     snapshot.data![0].propertyName;
        ref.read(propertyNameProvider.notifier).state = null;
        ref.read(roomNameProvider.notifier).state = null;

        Navigator.of(context!).pushNamed(ProfileScreen.routeName);
      } else {
        isLoading = false;
      }
    } catch (e, stacktrace) {
      isLoading = false;
      print(e.toString());
      ScaffoldMessenger.of(context!)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  // Future saveUserTimeLog({
  //   BuildContext? context,
  //   required WidgetRef ref,
  //   required List<String> timeLog,
  // }) async {
  //   try {
  //     isLoading = true;
  //     final lastClockedIn =
  //         localCache.getFromLocalCache(ConstantString.lastClockIn);
  //     if (lastClockedIn != null) {
  //       return DateTime.parse(lastClockedIn.toString());
  //     }
  //     final result = await userRepository.saveUserTimeLog(timeLog: timeLog);
  //     isLoading = false;
  //   } catch (e, stacktrace) {
  //     isLoading = false;
  //     print(e.toString());
  //     ScaffoldMessenger.of(context!)
  //       ..removeCurrentSnackBar()
  //       ..showSnackBar(SnackBar(
  //         content: Text(e.toString()),
  //         backgroundColor: Colors.red,
  //       ));
  //     debugPrint(e.toString());

  //     log(e.toString());
  //     log(stacktrace.toString());
  //   }
  // }

  Future saveUserTimeLogClockOut({
    BuildContext? context,
    required WidgetRef ref,
    required DateTime clockOut,
  }) async {
    try {
      isLoading = true;
      final lastClockedIn =
          localCache.getFromLocalCache(ConstantString.lastClockIn);
      if (lastClockedIn != null) {
        final clockedIn = DateTime.parse(lastClockedIn.toString());

        final result = await userRepository.saveUserTimeLog(
            clockIn: clockedIn, clockOut: clockOut);
      }

      isLoading = false;
    } catch (e, stacktrace) {
      isLoading = false;
      print(e.toString());
      ScaffoldMessenger.of(context!)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }

  Future saveUserTimeLogClockIn({
    BuildContext? context,
    required WidgetRef ref,
    required DateTime timeLog,
  }) async {
    try {
      isLoading = true;
      final formattedDateTime = timeLog.toIso8601String();
      await localCache.saveToLocalCache(
          key: ConstantString.lastClockIn, value: formattedDateTime);
      isLoading = false;
    } catch (e, stacktrace) {
      isLoading = false;
      print(e.toString());
      ScaffoldMessenger.of(context!)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ));
      debugPrint(e.toString());

      log(e.toString());
      log(stacktrace.toString());
    }
  }
}

final propertyNameProvider = StateProvider.autoDispose<String?>((ref) => null);
final roomNameProvider = StateProvider.autoDispose<String?>((ref) => null);
final propertyProvider = StateProvider.autoDispose<Property?>((ref) => null);
final tvCheck = StateProvider.autoDispose<bool>((ref) => false);
final fanCheck = StateProvider.autoDispose<bool>((ref) => false);
