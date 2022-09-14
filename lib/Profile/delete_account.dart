import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jugyourogu/Service/auth.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  DocumentSnapshot? firebasesnapshot;
  List? usersUid;

  void deleteUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    usersUid!.add(uid);
    FirebaseFirestore.instance
        .collection('deletedusers')
        .doc('deletedusers')
        .update({'uid': usersUid});
    await user.delete();
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    await AuthMethods().signOut(context);
  }

  void getHomeLists() async {
    firebasesnapshot = await FirebaseFirestore.instance
        .collection('deletedusers')
        .doc('deletedusers')
        .get();
    usersUid = firebasesnapshot!.get('uid');
  }

  @override
  void initState() {
    getHomeLists();
    super.initState();
  }

  // iOSのshowDialog
  Future iOSDialog(BuildContext parent) {
    return showDialog(
      barrierDismissible: false,
      context: parent,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('退会する'),
          actions: [
            TextButton(
              child: const Text('キャンセル',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
                child: const Text('はい',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                onPressed: () => deleteUser()),
          ],
        );
      },
    );
  }

  // AndroidのshowDialog
  Future androidDialog(BuildContext parent) {
    return showDialog(
      // barrierDismissible: false, 自動的に閉じられなくなるため不要
      context: parent,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text('退会する',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              actions: [
                TextButton(
                  child: const Text('キャンセル'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                    child: const Text('はい',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                    onPressed: () => deleteUser()),
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('退会する',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 45,
                child: InkWell(
                  onTap: () async {
                    Platform.isIOS
                        ? iOSDialog(context)
                        : androidDialog(context);
                  },
                  child: const Center(
                      child: Text('退会する',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white,
                          ))),
                )),
          ),
        ));
  }
}
