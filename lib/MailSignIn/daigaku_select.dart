import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jugyourogu/Service/sharedpref_helper.dart';
import 'package:jugyourogu/main_page.dart';

class DaigakuSelectScreen extends StatefulWidget {
  @override
  _DaigakuSelectScreenState createState() => _DaigakuSelectScreenState();
}

class _DaigakuSelectScreenState extends State<DaigakuSelectScreen> {
  String _hasBeenPressed = '立教大学';
  final items = [
    '立教大学',
    '中央大学',
    '明治大学',
    '法政大学',
    '青山学院大学',
    '早稲田大学',
    '慶應義塾大学',
  ];

  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
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
              const Text('大学を選択',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
              color: Colors.white,
            ),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, left: 30.0, right: 30.0),
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '学部を教えてください',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                  child: Text(
                                    items[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: _hasBeenPressed == items[index]
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _hasBeenPressed = items[index];
                                    });
                                  }),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
            color: Colors.orange,
            width: MediaQuery.of(context).size.width * 0.95,
            height: 50,
            child: InkWell(
              onTap: () async {
                SharedPreferenceHelper().saveUserName('LogIned');
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  'daigaku': daigaku[items.indexOf(_hasBeenPressed)],
                });
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => MainPage(currenttab: 0),
                      transitionDuration: const Duration(seconds: 0),
                    ));
              },
              child: const Center(
                  child: Text('大学を選択する',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white,
                      ))),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

List daigaku = [
  'rikkyou',
  'chuou',
  'meiji',
  'housei',
  'aogaku',
  'waseda',
  'keiou',
];
