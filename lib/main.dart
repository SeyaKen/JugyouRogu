import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jugyourogu/Service/google_signIn.dart';
import 'package:jugyourogu/SplashScreen/splash_screen.dart';
import 'package:jugyourogu/ad_state.dart';
import 'package:jugyourogu/updater.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  runApp(Provider.value(
    value: adState,
    builder: (context, child) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Stack(
          children: const  [
            MySplashScreen(),
            // Updater(appStoreUrl: '', playStoreUrl: '',),
          ],
        ),
      ),
    );
  }
}
