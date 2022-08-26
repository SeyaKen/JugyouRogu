import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jugyourogu/MailSignIn/daigaku_select.dart';
import 'package:jugyourogu/MailSignIn/mailAuth.dart';
import 'package:jugyourogu/MailSignIn/mailAuthenticate.dart';
import 'package:jugyourogu/SelectLogin/privacy_policy.dart';
import 'package:jugyourogu/SelectLogin/riyoukiyaku.dart';
import 'package:jugyourogu/Service/google_signIn.dart';
import 'package:jugyourogu/Service/sharedpref_helper.dart';
import 'package:jugyourogu/main_page.dart';
import 'package:provider/provider.dart';

class SelectLoginScreen extends StatefulWidget {
  const SelectLoginScreen({Key? key}) : super(key: key);

  @override
  State<SelectLoginScreen> createState() => _SelectLoginScreenState();
}

String? loginCheck;

class _SelectLoginScreenState extends State<SelectLoginScreen> {
  void Check() async {
    loginCheck = await SharedPreferenceHelper().getUserName();
  }

  @override
  void initState() {
    Check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : loginCheck == 'LogIned'
                  ? MainPage(currenttab: 0)
                  : snapshot.hasError
                      ? const Center(
                          child: Text('エラーが発生しました、もう一度やり直してください。'),
                        )
                      : Scaffold(
                          backgroundColor: const Color(0xffffffff),
                          body: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    FaIcon(
                                      FontAwesomeIcons.chalkboard,
                                      color: Colors.orange,
                                      size: 180,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                  onTap: () {
                                    final provider =
                                        Provider.of<GoogleSignInProvider>(
                                            context,
                                            listen: false);
                                    try {
                                      provider.googleLogin().then((user) => {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .get()
                                                .then((value) {
                                                
                                              if (value.data() == null) {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .set({
                                                  'ProfilePicture': '',
                                                  'email': FirebaseAuth.instance
                                                      .currentUser!.email,
                                                  'name': '',
                                                  'selfIntroduction': '',
                                                  'uid': FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                });
                                              }
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (_, __, ___) =>
                                                        DaigakuSelectScreen(),
                                                    transitionDuration:
                                                        const Duration(
                                                            seconds: 0),
                                                  ));
                                            }),
                                          });
                                    } catch (e) {
                                      print(e.toString());
                                      if (e.toString() ==
                                          '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
                                        AuthService().errorBox(
                                            context, 'パスワードが間違っています。');
                                      } else if (e.toString() ==
                                          '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
                                        AuthService().errorBox(context,
                                            '一致するユーザーが見つかりません。新規登録画面から登録してください。');
                                      }
                                    }
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: Image.asset(
                                                  'assets/googleLogo.png')),
                                          const Text('Googleで始める',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          const FaIcon(
                                            FontAwesomeIcons.google,
                                            color: Colors.transparent,
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(height: 30),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (_, __, ___) =>
                                              const mailAuthenticate(),
                                          transitionDuration:
                                              const Duration(seconds: 0),
                                        ));
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        border: Border.all(
                                            color: Colors.grey, width: 0.5),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.mail,
                                            color: Colors.black,
                                          ),
                                          Text('メールアドレスで始める',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          FaIcon(
                                            FontAwesomeIcons.google,
                                            color: Colors.transparent,
                                          ),
                                        ],
                                      )),
                                ),
                                const SizedBox(height: 50),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: RichText(
                                      text: TextSpan(
                                    style: const TextStyle(color: Colors.black),
                                    children: [
                                      const TextSpan(
                                        text: '登録またはログインすることで、',
                                      ),
                                      TextSpan(
                                        style:
                                            const TextStyle(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      const Riyoukiyaku(),
                                                  transitionDuration:
                                                      const Duration(
                                                          seconds: 0),
                                                ));
                                          },
                                        text: '利用規約',
                                      ),
                                      const TextSpan(
                                        text: 'と',
                                      ),
                                      TextSpan(
                                        style:
                                            const TextStyle(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      const PrivacyPolicy(),
                                                  transitionDuration:
                                                      const Duration(
                                                          seconds: 0),
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
                          ));
        });
  }
}
