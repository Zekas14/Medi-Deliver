import 'package:flutter/material.dart';
import 'package:medi_deliver/screens/HomePage.dart';
import 'package:medi_deliver/screens/Regestration.dart';
import 'package:medi_deliver/screens/Verification.dart';
import 'package:medi_deliver/screens/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MediDeliverApp(),
  );
}

class MediDeliverApp extends StatelessWidget {
  const MediDeliverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'Signup': (context) => SignUp(),
        'Login': (context) => Login(),
        'HomePage': (context) => HomePageScreen(),
        'Verification': (context) => Verification(),
      },
      initialRoute: 'Login',
    );
  }
}
