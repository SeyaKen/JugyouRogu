import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<PasswordReset> {
  // ここでauth.dartで作ったクラスを_authに代入
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool onTapped = false;

  String email = '';
  dynamic error;
  bool eye = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ],
            )),
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
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    const Text(
                        '入力されたメールアドレス宛に、パスワード変更用のリンクを送ります。現在お使いのメールアドレスを入力してください。'),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              validator: (val) =>
                                  val!.isEmpty ? 'メールアドレスを入力してください' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.grey[300],
                                filled: true,
                                border: InputBorder.none,
                                hintText: 'メールアドレス',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 13),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            color: email.contains('@')
                                ? Colors.black
                                : Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 48,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _auth
                                        .sendPasswordResetEmail(email: email)
                                        .then((value) => setState(() {
                                              onTapped = true;
                                            }));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                              actions: [
                                                CupertinoDialogAction(
                                                  isDefaultAction: true,
                                                  child: const Text("閉じる"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                              title: const Text(
                                                  '正しいメールアドレスを入力してください'));
                                        });
                                  }
                                },
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Center(
                                    child: Text(
                                      '送信',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    onTapped ? const Text('送信しました') : Container()
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
