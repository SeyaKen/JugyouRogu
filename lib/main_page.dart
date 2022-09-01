import 'package:flutter/material.dart';
import 'package:jugyourogu/Home/home_page.dart';
import 'package:jugyourogu/Profile/profile.dart';

class MainPage extends StatefulWidget {
  int currenttab;
  MainPage({super.key, required this.currenttab});

  @override
  _MainPageState createState() => _MainPageState(currenttab);
}

class _MainPageState extends State<MainPage> {
  int currenttab;
  _MainPageState(this.currenttab);
  String? uid;

  getMyUserUid() async {
    setState(() {});
  }

  onScreenLoaded() async {
    await getMyUserUid();
    setState(() {});
  }

  @override
  void initState() {
    onScreenLoaded();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currenttab = index;
            });
          },
          currentIndex: currenttab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          selectedFontSize: 8,
          unselectedFontSize: 8,
          backgroundColor: const Color(0xffffffff),
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 22,
              ),
              label: 'ホーム',
              
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 22,
              ),
              label: 'プロフィール',
            ),
          ]),
      body: IndexedStack(
        index: currenttab,
        children: const [
          HomePage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
