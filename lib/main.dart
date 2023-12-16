import 'package:flutter/material.dart';
import 'package:medi_deliver/core/ExtensionFunctions.dart';
import 'package:medi_deliver/dummy_product_list.dart';
import 'package:medi_deliver/model/product.dart';
import 'package:medi_deliver/screens/hom_page.dart';
import 'package:medi_deliver/screens/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:medi_deliver/screens/screens_holder_nav.dart';
import 'package:medi_deliver/screens/splashScreen.dart';
import 'firebase_options.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: homPage(),
//   ));
// }

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
      home: Login(),
    );
  }
}
