import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          color: Color(0xffffffff),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              FaIcon(
                FontAwesomeIcons.chalkboard,
                color: Colors.orange,
                size: 180,
              ),
              SizedBox(
                height: 30,
              ),
              Text('授業ログ',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  )),
            ],
          )),
    );
  }
}
