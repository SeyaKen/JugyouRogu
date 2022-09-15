import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jugyourogu/MailSignIn/mailAuth.dart';
import 'package:jugyourogu/Service/google_signIn.dart';
import 'package:jugyourogu/SplashScreen/splash_screen.dart';
import 'package:jugyourogu/ad_state.dart';
import 'package:jugyourogu/updater.dart';
import 'package:provider/provider.dart';

import 'Apple/apple_service.dart';
import 'Apple/apple_sign_in_available.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(MultiProvider(
    providers: [
      Provider.value(
        value: appleSignInAvailable,
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService2>(
     create: (_) => AuthService2(),
      child: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Stack(
            children: const [
              MySplashScreen(),
              // Updater(appStoreUrl: '', playStoreUrl: '',),
            ],
          ),
        ),
      ),
    );
  }
}
