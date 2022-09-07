import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jugyourogu/Profile/edit_profile.dart';
import 'package:jugyourogu/Service/sharedpref_helper.dart';

class EditDaigakuScreen extends StatefulWidget {
  EditDaigakuScreen({super.key, required this.name, required this.ex});

  String name, ex;

  @override
  _EditDaigakuScreenState createState() => _EditDaigakuScreenState(name, ex);
}

class _EditDaigakuScreenState extends State<EditDaigakuScreen> {
  String name, ex;

  _EditDaigakuScreenState(this.name, this.ex);
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String? _hasBeenPressed;
  final items = [
    '立教大学',
    '中央大学',
    '明治大学',
    '法政大学',
    '青山学院大学',
    '早稲田大学',
    '慶應義塾大学',
  ];

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    _hasBeenPressed = items[index];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _hasBeenPressed == items[index]
                        ? Colors.grey.withOpacity(0.3)
                        : Colors.white,
                    border: const Border(
                      bottom: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
                  child: Row(
                    children: [
                      Text(
                        items[index],
                        style: TextStyle(
                          color: _hasBeenPressed == items[index]
                              ? Colors.orange
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
            color: _hasBeenPressed != null
                ? const Color(0xff92b82e)
                : const Color(0xff92b82e).withOpacity(0.5),
            width: MediaQuery.of(context).size.width * 0.95,
            height: 50,
            child: InkWell(
              onTap: () async {
                if (_hasBeenPressed != null) {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => EditProfile(
                          daigakuMei: _hasBeenPressed!,
                          name: name,
                          ex: ex,
                        ),
                        transitionDuration: const Duration(seconds: 0),
                      ));
                }
              },
              child: const Center(
                  child: Text('大学を選択する',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ))),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

List daigaku = [
  // 'rikkyou',
  'chuou',
  // 'meiji',
  // 'housei',
  // 'aogaku',
  // 'waseda',
  // 'keiou',
];
