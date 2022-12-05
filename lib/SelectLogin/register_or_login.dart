import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jugyourogu/SelectLogin/daigaku_select.dart';
import 'package:jugyourogu/SelectLogin/privacy_policy.dart';
import 'package:jugyourogu/SelectLogin/riyoukiyaku.dart';
import 'package:jugyourogu/SelectLogin/select_login_screen.dart';
import 'package:jugyourogu/ad_state.dart';
import 'package:provider/provider.dart';

class RegisterLoginScreen extends StatefulWidget {
  const RegisterLoginScreen({super.key});

  @override
  State<RegisterLoginScreen> createState() => _RegisterLoginScreenState();
}

class _RegisterLoginScreenState extends State<RegisterLoginScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());
    initPlugin();
    super.initState();
  }

  Future<void> initPlugin() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Univ.',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 120,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Container(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => DaigakuSelectScreen(),
                            transitionDuration: const Duration(seconds: 0),
                          ));
                    },
                    child: const Center(
                        child: Text('アカウント登録',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                            ))),
                  )),
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const SelectLoginScreen(),
                            transitionDuration: const Duration(seconds: 0),
                          ));
                    },
                    child: const Center(
                        child: Text('ログイン',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ))),
                  )),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: RichText(
                  text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  const TextSpan(
                    text: '登録またはログインすることで、',
                  ),
                  TextSpan(
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => const Riyoukiyaku(),
                              transitionDuration: const Duration(seconds: 0),
                            ));
                      },
                    text: '利用規約',
                  ),
                  const TextSpan(
                    text: 'と',
                  ),
                  TextSpan(
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  const PrivacyPolicy(),
                              transitionDuration: const Duration(seconds: 0),
                            ));
                      },
                    text: 'プライバシーポリシー',
                  ),
                  const TextSpan(
                    text: 'に同意したものと見なされます。',
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
