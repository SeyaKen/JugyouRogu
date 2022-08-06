import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jugyourogu/SelectLogin/select_login_screen.dart';
import 'package:jugyourogu/Service/sharedpref_helper.dart';
import 'package:jugyourogu/main_page.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  Future<void> starttimer() async {
    loginCheck = await SharedPreferenceHelper().getUserName();
    Timer(const Duration(seconds: 1), () async {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => loginCheck == 'LogIned'
                  ? MainPage(
                      currenttab: 0,
                    )
                  : const SelectLoginScreen()));
    });
  }

  String? loginCheck;

  @override
  void initState() {
    super.initState();
    starttimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: const Color(0XFFF2D095),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                '授業ログ',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          )),
    );
  }
}
