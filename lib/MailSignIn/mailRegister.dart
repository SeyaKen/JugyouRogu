import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jugyourogu/MailSignIn/mailAuth.dart';
import 'package:jugyourogu/Service/sharedpref_helper.dart';
import 'package:jugyourogu/main_page.dart';

class mailRegister extends StatefulWidget {
  final Function toggleView;
  const mailRegister(this.toggleView);

  @override
  _mailRegisterState createState() => _mailRegisterState();
}

class _mailRegisterState extends State<mailRegister> {
  final auth = FirebaseAuth.instance;
  late User user;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  String email = '';
  String password = '';
  dynamic error;
  bool eye = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff131313),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff131313),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                icon: const Icon(Icons.person),
                label: const Text('ログイン画面へ'),
                onPressed: () async {
                  widget.toggleView();
                },
                style: TextButton.styleFrom(
                  primary: const Color(0XFF37EBFA),
                ),
              )
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () {
            final FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: Form(
            key: _formKey,
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '新規登録',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        validator: (val) =>
                            val!.isEmpty ? '正しいメールアドレスを入力してください' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                        decoration: const InputDecoration(
                          fillColor: Color(0xff333333),
                          filled: true,
                          hintText: 'メールアドレス',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 13),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _usernameController,
                            validator: (val) => password.length >= 7
                                ? null
                                : '7文字以上でパスワードを設定してください',
                            obscureText: eye,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            decoration: const InputDecoration(
                              fillColor: Color(0xff333333),
                              filled: true,
                              hintText: 'パスワード',
                              hintStyle: TextStyle(color: Colors.grey),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 13),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 15,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                eye = !eye;
                              });
                            },
                            child: Icon(
                              eye
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              size: 23,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      decoration: BoxDecoration(
                        color: password.length >= 7
                            ? const Color(0XFF37EBFA)
                            : const Color(0XFF37EBFA).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 48,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await auth
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password).then((value) => 
                                          user = auth.currentUser!)
                                      .then((value) async =>
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .set({
                                            'ProfilePicture': '',
                                            'email': user.email,
                                            'name': '',
                                            'selfIntroduction': '',
                                            'uid': user.uid,
                                          }))
                                      .then((value) => SharedPreferenceHelper()
                                          .saveUserName('LogIned')
                                          .then((value) => Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    MainPage(currenttab: 0),
                                                transitionDuration:
                                                    const Duration(seconds: 0),
                                              ))));
                                } catch (e) {
                                  print(e.toString());
                                  if (e.toString() ==
                                      '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
                                    AuthService()
                                        .errorBox(context, 'パスワードが間違っています。');
                                  } else if (e.toString() ==
                                      '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
                                    AuthService().errorBox(context,
                                        '一致するユーザーが見つかりません。新規登録画面から登録してください。');
                                  } else if (e.toString() ==
                                      '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
                                    AuthService().errorBox(
                                        context, 'すでにこのメールアドレスは登録済みです。');
                                  }
                                }
                              }
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: const Center(
                                child: Text(
                                  '新規登録する',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
