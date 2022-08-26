import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterLoginScreen extends StatefulWidget {
  const RegisterLoginScreen({super.key});

  @override
  State<RegisterLoginScreen> createState() => _RegisterLoginScreenState();
}

class _RegisterLoginScreenState extends State<RegisterLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.chalkboard,
              color: Colors.orange,
              size: 180,
            ),
            const Text('授業ログ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            const SizedBox(
              height: 50,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Container(
                  color: const Color(0xff92b82e),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: InkWell(
                    onTap: () async {},
                    child: const Center(
                        child: Text('アカウント登録',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white,
                            ))),
                  )),
            ),
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff92b82e)),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: InkWell(
                    onTap: () async {},
                    child: const Center(
                        child: Text('ログイン',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xff92b82e),
                            ))),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
