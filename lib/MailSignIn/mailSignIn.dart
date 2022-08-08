import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jugyourogu/MailSignIn/mailAuth.dart';
import 'package:jugyourogu/Profile/password_reset.dart';
import 'package:jugyourogu/SelectLogin/select_login_screen.dart';

class mailSignIn extends StatefulWidget {
  final Function toggleView;
  const mailSignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<mailSignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  dynamic error;
  bool eye = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xff131313),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff131313),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const SelectLoginScreen(),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
              TextButton.icon(
                icon: const Icon(
                  Icons.person,
                ),
                label: const Text('新規登録画面へ'),
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'ログイン',
                              style: TextStyle(
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
                                val!.isEmpty ? 'メールアドレスを入力してください' : null,
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
                                validator: (val) => val!.length < 7
                                    ? '7文字以上のパスワードを入力してください'
                                    : null,
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
                                    // ファイアベースでのメール認証の処理
                                    await _auth.signInWithEmailAndPassword(
                                        context,
                                        email.toString().trim(),
                                        password.toString().trim());
                                  }
                                },
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: const Center(
                                    child: Text(
                                      'ログイン',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => PasswordReset(),
                                  transitionDuration:
                                      const Duration(seconds: 0),
                                ));
                          },
                          child: const Text(
                            'パスワードを忘れた場合',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
