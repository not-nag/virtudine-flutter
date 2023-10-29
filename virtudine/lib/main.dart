import 'package:flutter/material.dart';
import 'package:virtudine/components/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:virtudine/restaurant_options.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

Future fetchDataFromFirebase() async {
  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('cafes').get();
  if (snapshot.exists) {
    return snapshot.value;
  } else {
    debugPrint('No data available.');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFF8600),
        body: SafeArea(
          child: Emojis(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );

  await Future.delayed(const Duration(seconds: 3));

  runApp(MaterialApp(
    home: FutureBuilder(
      future: fetchDataFromFirebase(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final value = snapshot.data;
          return RestaurantOptions(data: value);
        } else {
          return const Scaffold(
            backgroundColor: Color(0xFFFF8600),
            body: SafeArea(
              child: Emojis(),
            ),
          );
        }
      },
    ),
    debugShowCheckedModeBanner: false,
  ));
}
