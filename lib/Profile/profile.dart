import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jugyourogu/Profile/edit_profile.dart';
import 'package:jugyourogu/Profile/password_reset.dart';
import 'package:jugyourogu/Service/auth.dart';
import 'package:jugyourogu/Service/database.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Stream<QuerySnapshot<Object?>>? profileListsStream;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool switchColor0 = true;
  bool switchColor1 = false;

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  getHomeLists() async {
    profileListsStream = await DatabaseService().fetchImage();
    setState(() {});
  }

  onScreenLoaded() async {
    getHomeLists();
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: profileListsStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Scaffold(
                  backgroundColor: const Color(0xffffffff),
                  key: _scaffoldKey,
                  endDrawer: Drawer(
                      backgroundColor: const Color(0xffffffff),
                      child: ListView(
                        children: [
                          InkWell(
                            onTap: () {
                              AuthMethods().signOut(context);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              child: const ListTile(
                                leading: Icon(
                                  Icons.logout,
                                  color: Colors.black,
                                ),
                                title: Text('ログアウト',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                tileColor: Colors.transparent,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        PasswordReset(),
                                    transitionDuration:
                                        const Duration(seconds: 0),
                                  ));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              child: const ListTile(
                                leading: Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.black,
                                ),
                                title: Text('パスワード',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                tileColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      )),
                  appBar: AppBar(
                    shape: const Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5)),
                    iconTheme: const IconThemeData(
                      color: Colors.black,
                      size: 40,
                    ),
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: const Text(
                      'プロフィール',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  resizeToAvoidBottomInset: false,
                  body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(150.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.width * 0.5,
                            child: Image.network(
                              snapshot.data!.docs[0]['ProfilePicture'] == ''
                                  ? 'https://firebasestorage.googleapis.com/v0/b/jugyourogu-d71e0.appspot.com/o/44884218_345707102882519_2446069589734326272_n.jpeg?alt=media&token=816dc8a0-f2d6-4a73-9acc-391a74dbc75b'
                                  : snapshot.data!.docs[0]['ProfilePicture'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data!.docs[0]['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                snapshot.data!.docs[0]['selfIntroduction'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 40,
                                color: const Color(0xff92b82e),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) =>
                                                EditProfile(
                                                    name: snapshot.data!.docs[0]
                                                        ['name'],
                                                    ex: snapshot.data!.docs[0]
                                                        ['selfIntroduction']),
                                            transitionDuration:
                                                const Duration(seconds: 0),
                                          ));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'プロフィールを編集する',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        )
                      ]))
              : const CircularProgressIndicator();
        });
  }
}
