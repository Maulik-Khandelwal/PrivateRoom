import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:privateroom/screens/dashboard_screen/dashboard_screen.dart';
import 'package:privateroom/utility/ui_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: ScrollBehavior().copyWith(physics: const BouncingScrollPhysics()),
      theme: ThemeData(accentColor: kImperialRed, primaryColor: kImperialRed, fontFamily: 'Freshman',),
      title: 'Private Room',
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}
