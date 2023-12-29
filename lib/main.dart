import 'package:flutter/material.dart';
import 'package:medi_deliver/provider/favoritesProvider.dart';
import 'package:medi_deliver/provider/model/cartProvider.dart';
import 'package:medi_deliver/provider/orderProvider.dart';
import 'package:medi_deliver/provider/userProvider.dart';
import 'package:medi_deliver/screens/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritesProvider(),
        ),
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
