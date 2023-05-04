import 'package:cleaning_llc/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: appRoutes,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Raleway',
      ),
      home: const ProfileScreen(),
    );
  }
}