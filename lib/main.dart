import 'package:firebase_core/firebase_core.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(accentColor: kImperialRed, primaryColor: kImperialRed, fontFamily: GoogleFonts.poppins().fontFamily,),
      title: 'Private Room',
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}
