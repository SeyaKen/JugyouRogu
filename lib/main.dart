import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jugyourogu/Service/google_signIn.dart';
import 'package:jugyourogu/SplashScreen/splash_screen.dart';
import 'package:jugyourogu/main_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          textTheme: const TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const MySplashScreen(),
      ),
    );
  }
}
