import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jugyourogu/MailSignIn/mailAuth.dart';
import 'package:jugyourogu/MailSignIn/mailRegister.dart';
import 'package:jugyourogu/Service/google_signIn.dart';
import 'package:jugyourogu/Service/sharedpref_helper.dart';
import 'package:jugyourogu/main_page.dart';
import 'package:provider/provider.dart';

import '../Apple/apple_service.dart';
import '../Apple/apple_sign_in_available.dart';

class SelectRegisterScreen extends StatefulWidget {
  const SelectRegisterScreen({Key? key}) : super(key: key);

  @override
  State<SelectRegisterScreen> createState() => _SelectRegisterScreenState();
}

String? loginCheck;

class _SelectRegisterScreenState extends State<SelectRegisterScreen> {
  String? Daigakumei;

  void Getdaigakumei() async {
    Daigakumei = await SharedPreferenceHelper().getUserDaigaku();
  }

  Future _signInWithApple(BuildContext context) async {
    try {
      final authService2 = Provider.of<AuthService2>(context, listen: false);
      final user = await authService2.signInWithApple();
      return user;
    } catch (e) {
      // TODO: Show alert here
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    Getdaigakumei();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: const Color(0xffffffff),
          title: Container(),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 70),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Univ.',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
                  SizedBox(height: 10),
                  Text(
                    '新規登録する方法を選択してください。',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  try {
                    provider.googleLogin().then((user) => {
                          if (FirebaseAuth.instance.currentUser != null)
                            {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get()
                                  .then((value) {
                                if (value.data() == null) {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .set({
                                    'ProfilePicture': '',
                                    'email': FirebaseAuth
                                        .instance.currentUser!.email,
                                    'name': '',
                                    'selfIntroduction': '',
                                    'uid':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    'daigaku': Daigakumei,
                                    'favorite': {},
                                  });
                                }
                              }).then((value) => SharedPreferenceHelper()
                                      .saveUserName('LogIned')
                                      .then((value) => Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  MainPage(currenttab: 0),
                                              transitionDuration:
                                                  const Duration(
                                                      seconds: 0))))),
                            }
                        });
                  } catch (e) {
                    print(e.toString());
                    if (e.toString() ==
                        '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
                      AuthService().errorBox(context, 'パスワードが間違っています。');
                    } else if (e.toString() ==
                        '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
                      AuthService().errorBox(
                          context, '一致するユーザーが見つかりません。新規登録画面から登録してください。');
                    }
                  }
                },
                child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 24,
                            height: 24,
                            child: Image.asset('assets/googleLogo.png')),
                        const Text('Googleで始める',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15,
                            )),
                        const FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.transparent,
                        ),
                      ],
                    )),
              ),
              Platform.isIOS
                  ? Column(
                      children: [
                        const SizedBox(height: 30),
                        if (appleSignInAvailable.isAvailable)
                          InkWell(
                            onTap: () {
                              _signInWithApple(context).then((user) => {
                                    if (user != null)
                                      {
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user.uid)
                                            .get()
                                            .then((value) {
                                          if (value.data() == null) {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(user.uid)
                                                .set({
                                              'ProfilePicture': '',
                                              'email': FirebaseAuth
                                                  .instance.currentUser!.email,
                                              'name': '',
                                              'selfIntroduction': '',
                                              'uid': FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              'daigaku': Daigakumei,
                                              'favorite': {},
                                            });
                                          }
                                        }).then((value) => SharedPreferenceHelper()
                                                .saveUserName('LogIned')
                                                .then((value) => Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                        pageBuilder: (_, __,
                                                                ___) =>
                                                            MainPage(
                                                                currenttab: 0),
                                                        transitionDuration:
                                                            const Duration(
                                                                seconds: 0)))))
                                      }
                                  });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  color: Colors.black,
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.apple,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Text('Appleで始める',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 15)),
                                      FaIcon(
                                        FontAwesomeIcons.google,
                                        color: Colors.transparent,
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => mailRegister(),
                        transitionDuration: const Duration(seconds: 0),
                      ));
                },
                child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.mail,
                          color: Colors.black,
                        ),
                        Text('メールアドレスで始める',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15,
                            )),
                        FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.transparent,
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ));
  }
}
