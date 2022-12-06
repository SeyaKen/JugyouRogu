import 'package:flutter/material.dart';
import 'package:jugyourogu/%20Favorite/favorite_list.dart';
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
          selectedFontSize: 10,
          unselectedFontSize: 10,
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
                Icons.bookmark_outline_rounded,
                size: 22,
              ),
              label: '保存済み',
              
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
          favoriteListScreen(),
          ProfilePage(),
        ],
      ),
    );
  }
}
