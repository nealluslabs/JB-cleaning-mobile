// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:cleaning_llc/models/rooms_model.dart';
import 'package:cleaning_llc/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../models/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/company_model.dart';
import '../models/property_model.dart';
import '../view_model/local_cache/local_cache.dart';

abstract class UserRepository {
  Future<User?> createUserWithEmail(String email, String password);
  Future<User?> loginWithEmail(String email, String password);
  Future isUserSignedIn();
  Future logOut();
  Future resetPassword(String email);
  Future<AppUser> fetchCurrentUser();
  Future<String?> saveUserCredentials(String email, String firstName,
      String lastName, int companyId, String password, DateTime accountCreated);
  Future<UserDataModel?> getUsersCredentials();
  Future<int?> getCompanyFromId(int companyId);
  Future<List<Property>?> getAllCompanyProperty(String companyId);
  Future<List<Room>?> getAllPropertyRooms(String propertyId);
}

class UserRepositoryImpl implements UserRepository {
  late LocalCache cache;

  UserRepositoryImpl({
    required this.cache,
  }) : super();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection('workers');
  CollectionReference companyFirebaseFirestore =
      FirebaseFirestore.instance.collection('companies');
  CollectionReference propertiesFirebaseFirestore =
      FirebaseFirestore.instance.collection('properties');
  CollectionReference roomsFirebaseFirestore =
      FirebaseFirestore.instance.collection('rooms');

  @override
  Future<User?> createUserWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An Error Occures';
      switch (error.code) {
        case 'invalid-email:':
          message = 'Email is Invalid!';
          break;
        case 'email-already-in-use:':
          message =
              'The email address already exists.Please proceed to login Screen ';
          break;
        case 'wrong-password':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      throw Exception(message);
      print(message);
    }
  }

  @override
  Future<AppUser> fetchCurrentUser() async {
    throw UnimplementedError();
    //  try {
    //   String? userJson = await SharedPreferenceHelper().getcurrentUser();
    //   AppUser currentUser = AppUser.fromJson(json.decode(userJson!));
    //   return currentUser;
    // } on PlatformException catch (error) {
    //   throw Exception(error);
    // }
  }

  @override
  Future isUserSignedIn() async {
    User? user = firebaseAuth.currentUser;
    return user != null && user.uid.isNotEmpty;
  }

  @override
  Future logOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An error has occured.'; // default message
      switch (error.code) {
        case 'user-disabled':
          message =
              'This user has been temporarily disabled, Contact Support for more information';
          break;
        case 'user-not-found':
          message =
              'The email address is not assocciated with a user.Try another Email up or Register with this email address ';
          break;
        case 'wrong-password':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      throw Exception(message);
    }
    return null;
  }

  @override
  Future resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<String?> saveUserCredentials(
      String email,
      String firstName,
      String lastName,
      int companyId,
      String password,
      DateTime accountCreated) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    await firebaseFirestore.doc(uid.toString()).set(
        {
          'id': uid.toString(),
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'accountCreated': accountCreated,
          'timelog': [],
          'companyId': companyId,
          'password': password,
        },
        SetOptions(
          merge: true,
        ));
    return uid;
  }

  @override
  Future<UserDataModel?> getUsersCredentials() async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      final appUser = firebaseFirestore.doc(uid);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        return UserDataModel.fromJson(snapshot.data());
      }
    } catch (error) {}
    return null;
  }

  @override
  Future<int?> getCompanyFromId(int companyId) async {
    try {
      final company =
          companyFirebaseFirestore.where("id", isEqualTo: companyId);
      final snapshot = await company.get();
      if (snapshot.docs.isEmpty) {
        return null;
      }
      var employee = snapshot.docs[0].data();
      var result = Company.fromJson(employee);
      return result.id;
    } catch (error) {
      print(1);
      print(error.toString());
    }
    return null;
  }

  @override
  Future<List<Property>?> getAllCompanyProperty(String companyId) async {
    try {
      // final sharedPreferences = await SharedPreferences.getInstance();
      List<Property> allProperties = [];
      final data =
          propertiesFirebaseFirestore.where("companyId", isEqualTo: companyId);
      final properties = await data.get();
      if (properties.docs.isNotEmpty) {
        List<Property> allProperties =
            properties.docs.map((doc) => Property.fromJson(doc)).toList();
        // for (var movie in movies.docs) {
        //   var newMovie = Movie.fromJson(movie);

        //   if (SharedPreferenceHelper()
        //           .getFromLocalCache(sharedPreferences, movie.id) ==
        //       null) {
        //     SharedPreferenceHelper().saveToLocalCache(key: movie.id, value: 0);
        //   }
        //   allMovies.add(newMovie);
        // }
        // print(allMovies);
        print(allProperties);
        return allProperties;
      }
    } catch (error) {
      print(error);
      // handle the error
    }
    return null;
  }

  @override
  Future<List<Room>?> getAllPropertyRooms(String propertyId) async {
    try {
      // final sharedPreferences = await SharedPreferences.getInstance();
      List<Property> allRooms = [];
      final data =
          roomsFirebaseFirestore.where("propertyId", isEqualTo: propertyId);
      final rooms = await data.get();
      if (rooms.docs.isNotEmpty) {
        List<Room> allProperties =
            rooms.docs.map((doc) => Room.fromJson(doc)).toList();
        // for (var movie in movies.docs) {
        //   var newMovie = Movie.fromJson(movie);

        //   if (SharedPreferenceHelper()
        //           .getFromLocalCache(sharedPreferences, movie.id) ==
        //       null) {
        //     SharedPreferenceHelper().saveToLocalCache(key: movie.id, value: 0);
        //   }
        //   allMovies.add(newMovie);
        // }
        // print(allMovies);
        print(allProperties);
        return allProperties;
      }
    } catch (error) {
      print(error);
      // handle the error
    }
    return null;
  }

  Future<String?> saveUserIssues(String propertyId, String roomId,
      String description, DateTime issueCreated) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();
    final docUser = firebaseFirestore.doc();
    await docUser.set(
        {
          'id': docUser.id,
          'propertyId': propertyId,
          'roomId': roomId,
          'description': description,
          'workerId': uid.toString(),
        },
        SetOptions(
          merge: true,
        ));
    return uid;
  }
}
