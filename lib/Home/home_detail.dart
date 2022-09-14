import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jugyourogu/%20AddClass/edit_class.dart';
import 'package:jugyourogu/%20Reviews/add_reviews.dart';
import 'package:jugyourogu/Home/kutikomi_detail.dart';
import 'package:jugyourogu/Service/database.dart';
import 'package:jugyourogu/Service/sharedpref_helper.dart';
import 'package:jugyourogu/main_page.dart';

class HomeDetail extends StatefulWidget {
  HomeDetail({super.key, required this.articleId, required this.fromTag});

  String articleId;
  int fromTag;

  @override
  State<HomeDetail> createState() => _HomeDetailState(articleId, fromTag);
}

class _HomeDetailState extends State<HomeDetail> {
  DocumentSnapshot? firebasesnapshot,
      firebasesnapshot1,
      firebasesnapshot2,
      firebasesnapshot3;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Stream<QuerySnapshot<Object?>>? kutikomiListsStream;
  String articleId;
  _HomeDetailState(this.articleId, this.fromTag);
  final ScrollController _scrollController = ScrollController();
  double? JuujituInt;
  double? RakutanInt;
  String? daigakuMei;
  var favoriteList = {};
  List favoriteListDaigakubetu = [];
  bool? hukumu;
  int fromTag;
  List usersUid = [];

  getHomeLists() async {
    firebasesnapshot3 = await FirebaseFirestore.instance
        .collection('deletedusers')
        .doc('deletedusers')
        .get();
    usersUid = firebasesnapshot3!.get('uid');
    daigakuMei = await SharedPreferenceHelper().getUserDaigaku();
    firebasesnapshot = await FirebaseFirestore.instance
        .collection(daigakuMei!)
        .doc(articleId)
        .get();
    kutikomiListsStream =
        DatabaseService().kutikomiCollect(articleId, daigakuMei);
    if (firebasesnapshot!.get('JuujituAverage') == '0' ||
        firebasesnapshot!.get('RakutanAverage') == '0') {
      JuujituInt = 0;
      RakutanInt = 0;
    } else {
      JuujituInt = double.parse(firebasesnapshot!.get('JuujituAverage'));
      RakutanInt = double.parse(firebasesnapshot!.get('RakutanAverage'));
    }
    try {
      firebasesnapshot1 = await FirebaseFirestore.instance
          .collection(daigakuMei!)
          .doc(articleId)
          .collection('reviews')
          .doc(uid)
          .get();
      firebasesnapshot1!.get('uid');
    } catch (e) {
      print(e.toString());
      firebasesnapshot1 = null;
    }
    firebasesnapshot2 =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    favoriteList = firebasesnapshot2!.get('favorite');
    try {
      favoriteListDaigakubetu = favoriteList[daigakuMei];
    } catch (e) {
      favoriteList[daigakuMei] = [];
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'favorite': favoriteList,
      });
      firebasesnapshot2 =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      favoriteList = firebasesnapshot2!.get('favorite');
      favoriteListDaigakubetu = favoriteList[daigakuMei];
    }
    if (favoriteListDaigakubetu.contains(articleId)) {
      hukumu = true;
    } else {
      hukumu = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    getHomeLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          MainPage(currenttab: fromTag),
                      transitionDuration: const Duration(seconds: 0),
                    ));
              },
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 30,
                color: Colors.black,
              ),
            ),
            Text(
              firebasesnapshot != null
                  ? firebasesnapshot!.get('授業名').length > 11
                      ? firebasesnapshot!.get('授業名').substring(0, 12) + '...'
                      : ''
                  : '',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
              color: Colors.transparent,
            ),
          ],
        ),
      ),
      body: firebasesnapshot != null
          ? Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 5),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(firebasesnapshot!.get('授業名'),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => EditClass(
                                      jugyoumei: firebasesnapshot!.get('授業名'),
                                      kyouju: firebasesnapshot!.get('教授・講師名'),
                                      gakubu2: firebasesnapshot!.get('学部'),
                                      youbi0: firebasesnapshot!.get('曜日・時限1'),
                                      youbi1: firebasesnapshot!.get('曜日・時限2'),
                                      classId: firebasesnapshot!.id,
                                    ),
                                    transitionDuration:
                                        const Duration(seconds: 0),
                                  ));
                            });
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 5),
                              Text('編集する',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        firebasesnapshot!.get('学部') != ''
                            ? const Text('学部:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ))
                            : Container(),
                        firebasesnapshot!.get('学部') != ''
                            ? Text(firebasesnapshot!.get('学部'),
                                style: const TextStyle(
                                  fontSize: 12,
                                ))
                            : Container(),
                        firebasesnapshot!.get('学部') != ''
                            ? const SizedBox(
                                width: 10,
                              )
                            : Container(),
                        const Text('教授:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            )),
                        Text(firebasesnapshot!.get('教授・講師名'),
                            style: const TextStyle(
                              fontSize: 12,
                            )),
                        firebasesnapshot!.get('曜日・時限1') != ''
                            ? const SizedBox(
                                width: 10,
                              )
                            : Container(),
                        Row(children: [
                          const Text('曜日・時限:  ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              )),
                          Text(firebasesnapshot!.get('曜日・時限1'),
                              style: const TextStyle(
                                fontSize: 12,
                              )),
                          firebasesnapshot!.get('曜日・時限1') != ''
                              ? const Text('-',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ))
                              : const Text(''),
                          firebasesnapshot!.get('曜日・時限2') == ''
                              ? const Text('')
                              : Text(firebasesnapshot!.get('曜日・時限2'),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  )),
                        ]),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text('内容充実度:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                )),
                            Row(
                              children: [
                                Icon(
                                  JuujituInt != 0
                                      ? Icons.star
                                      : Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  JuujituInt! >= 1.5 && JuujituInt! < 2
                                      ? Icons.star_half_outlined
                                      : JuujituInt! >= 2
                                          ? Icons.star
                                          : Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  JuujituInt! >= 2.5 && JuujituInt! < 3
                                      ? Icons.star_half_outlined
                                      : JuujituInt! >= 3
                                          ? Icons.star
                                          : Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  JuujituInt! >= 3.5 && JuujituInt! < 4
                                      ? Icons.star_half_outlined
                                      : JuujituInt! >= 4
                                          ? Icons.star
                                          : Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  JuujituInt! >= 4.5 && JuujituInt! < 5
                                      ? Icons.star_half_outlined
                                      : JuujituInt! >= 5
                                          ? Icons.star
                                          : Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                              ],
                            ),
                            Text(
                              JuujituInt != 0
                                  ? JuujituInt!.toString()
                                  : 'データなし',
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('楽単度:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                )),
                            Row(
                              children: [
                                Icon(
                                  RakutanInt != 0
                                      ? Icons.star
                                      : Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  RakutanInt! >= 1.5 && RakutanInt! < 2
                                      ? Icons.star_half_outlined
                                      : RakutanInt! >= 2
                                          ? Icons.star
                                          : Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  RakutanInt! >= 2.5 && RakutanInt! < 3
                                      ? Icons.star_half_outlined
                                      : RakutanInt! >= 3
                                          ? Icons.star
                                          : Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  RakutanInt! >= 3.5 && RakutanInt! < 4
                                      ? Icons.star_half_outlined
                                      : RakutanInt! >= 4
                                          ? Icons.star
                                          : Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  RakutanInt! >= 4.5 && RakutanInt! < 5
                                      ? Icons.star_half_outlined
                                      : RakutanInt! >= 5
                                          ? Icons.star
                                          : Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                              ],
                            ),
                            Text(
                              RakutanInt != 0
                                  ? RakutanInt!.toString()
                                  : 'データなし',
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: const [
                        Text('口コミ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ]),
                ),
                StreamBuilder(
                    stream: kutikomiListsStream,
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        if (!usersUid.contains(snapshot
                                            .data!.docs[index]['uid'])) {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    KutikomiDetail(
                                                  jugyoumei: firebasesnapshot!
                                                      .get('授業名'),
                                                  AitenoUid: snapshot
                                                      .data!.docs[index].id,
                                                  articleId: articleId,
                                                ),
                                                transitionDuration:
                                                    const Duration(seconds: 0),
                                              ));
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 8, bottom: 8),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              width: 0.5, color: Colors.black),
                                        )),
                                        child: Row(
                                          children: [
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Text('内容充実度:',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                              )),
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .orange,
                                                                size: 20,
                                                              ),
                                                              Icon(
                                                                snapshot.data!.docs[index]
                                                                            [
                                                                            'Juujitu'] >
                                                                        0
                                                                    ? Icons.star
                                                                    : Icons
                                                                        .star_outline,
                                                                color: Colors
                                                                    .orange,
                                                                size: 20,
                                                              ),
                                                              Icon(
                                                                snapshot.data!.docs[index]
                                                                            [
                                                                            'Juujitu'] >
                                                                        1
                                                                    ? Icons.star
                                                                    : Icons
                                                                        .star_outline,
                                                                color: Colors
                                                                    .orange,
                                                                size: 20,
                                                              ),
                                                              Icon(
                                                                snapshot.data!.docs[index]
                                                                            [
                                                                            'Juujitu'] >
                                                                        2
                                                                    ? Icons.star
                                                                    : Icons
                                                                        .star_outline,
                                                                color: Colors
                                                                    .orange,
                                                                size: 20,
                                                              ),
                                                              Icon(
                                                                snapshot.data!.docs[index]
                                                                            [
                                                                            'Juujitu'] >
                                                                        3
                                                                    ? Icons.star
                                                                    : Icons
                                                                        .star_outline,
                                                                color: Colors
                                                                    .orange,
                                                                size: 20,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text('楽単度:',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                              )),
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .orange,
                                                                size: 20,
                                                              ),
                                                              Icon(
                                                                snapshot.data!.docs[index]
                                                                            [
                                                                            'Rakutan'] >
                                                                        0
                                                                    ? Icons.star
                                                                    : Icons
                                                                        .star_outline,
                                                                color: Colors
                                                                    .orange,
                                                                size: 20,
                                                              ),
                                                              Icon(
                                                                snapshot.data!.docs[index]
                                                                            [
                                                                            'Rakutan'] >
                                                                        1
                                                                    ? Icons.star
                                                                    : Icons
                                                                        .star_outline,
                                                                color: Colors
                                                                    .orange,
                                                                size: 20,
                                                              ),
                                                              Icon(
                                                                snapshot.data!.docs[index]
                                                                            [
                                                                            'Rakutan'] >
                                                                        2
                                                                    ? Icons.star
                                                                    : Icons
                                                                        .star_outline,
                                                                color: Colors
                                                                    .orange,
                                                                size: 20,
                                                              ),
                                                              Icon(
                                                                snapshot.data!.docs[index]
                                                                            [
                                                                            'Rakutan'] >
                                                                        3
                                                                    ? Icons.star
                                                                    : Icons
                                                                        .star_outline,
                                                                color: Colors
                                                                    .orange,
                                                                size: 20,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(children: [
                                                    Row(
                                                      children: [
                                                        const Text('出席:',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                            )),
                                                        Text(
                                                            Shusseki_list[snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['Shusseki']],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                            )),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text('教科書:',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                            )),
                                                        Text(
                                                            Kyoukasho_list[snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['Kyoukasho']],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                            )),
                                                      ],
                                                    ),
                                                  ]),
                                                  Row(children: [
                                                    Row(
                                                      children: [
                                                        const Text('中間:',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                            )),
                                                        Text(
                                                            Chukan_list[snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['Chukan']],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                            )),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text('期末:',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                            )),
                                                        Text(
                                                            Kimatu_list[snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['Kimatu']],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                            )),
                                                      ],
                                                    ),
                                                  ]),
                                                  Row(
                                                    children: [
                                                      const Text('持ち込み:',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                          )),
                                                      Text(
                                                          Motikomi_list[snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ['Motikomi']],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                          )),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  usersUid.contains(snapshot
                                                          .data!
                                                          .docs[index]['uid'])
                                                      ? Row(children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        150.0),
                                                            child: SizedBox(
                                                                width: 30,
                                                                height: 30,
                                                                child: Image
                                                                    .network(
                                                                  'https://firebasestorage.googleapis.com/v0/b/jugyourogu-d71e0.appspot.com/o/44884218_345707102882519_2446069589734326272_n.jpeg?alt=media&token=816dc8a0-f2d6-4a73-9acc-391a74dbc75b',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.8,
                                                                      child:
                                                                          const Text(
                                                                        '退会済みのユーザー',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ]),
                                                        ])
                                                      : Row(children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        150.0),
                                                            child: SizedBox(
                                                              width: 30,
                                                              height: 30,
                                                              child: StreamBuilder<
                                                                      QuerySnapshot>(
                                                                  stream: FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .where(
                                                                          'uid',
                                                                          isEqualTo: snapshot.data!.docs[index]
                                                                              [
                                                                              'uid'])
                                                                      .snapshots(),
                                                                  builder: (context,
                                                                      snapshot0) {
                                                                    return snapshot0
                                                                            .hasData
                                                                        ? Image
                                                                            .network(
                                                                            snapshot0.data!.docs[0]['ProfilePicture'] == ''
                                                                                ? 'https://firebasestorage.googleapis.com/v0/b/jugyourogu-d71e0.appspot.com/o/44884218_345707102882519_2446069589734326272_n.jpeg?alt=media&token=816dc8a0-f2d6-4a73-9acc-391a74dbc75b'
                                                                                : snapshot0.data!.docs[0]['ProfilePicture'],
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )
                                                                        : Image
                                                                            .network(
                                                                            'https://firebasestorage.googleapis.com/v0/b/jugyourogu-d71e0.appspot.com/o/44884218_345707102882519_2446069589734326272_n.jpeg?alt=media&token=816dc8a0-f2d6-4a73-9acc-391a74dbc75b',
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          );
                                                                  }),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    StreamBuilder<
                                                                            QuerySnapshot>(
                                                                        stream: FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                'users')
                                                                            .where('uid',
                                                                                isEqualTo: snapshot.data!.docs[index][
                                                                                    'uid'])
                                                                            .snapshots(),
                                                                        builder:
                                                                            (context,
                                                                                snapshot1) {
                                                                          return snapshot1.hasData
                                                                              ? SizedBox(
                                                                                  width: MediaQuery.of(context).size.width * 0.8,
                                                                                  child: Text(
                                                                                    snapshot1.data!.docs[0]['name'],
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 10,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              : const Text('');
                                                                        }),
                                                                    Text(
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              index]
                                                                              [
                                                                              'Daytime']
                                                                          .toDate()
                                                                          .toString()
                                                                          .substring(
                                                                              0,
                                                                              10),
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ]),
                                                        ])
                                                ]),
                                            usersUid.contains(snapshot
                                                    .data!.docs[index]['uid'])
                                                ? Container()
                                                : const Expanded(
                                                    child: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : const Center(child: CircularProgressIndicator());
                    }),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            onTap: () {
                              if (favoriteListDaigakubetu.contains(articleId)) {
                                // 元々含んでいたら消す処理
                                favoriteListDaigakubetu.remove(articleId);
                                favoriteList[daigakuMei] =
                                    favoriteListDaigakubetu;
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(uid)
                                    .update({
                                  'favorite': favoriteList,
                                });
                                setState(() {
                                  hukumu = false;
                                });
                              } else {
                                // 含んでいなかったら加える処理
                                favoriteListDaigakubetu.add(articleId);
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(uid)
                                    .update({
                                  'favorite': favoriteList,
                                });
                                setState(() {
                                  hukumu = true;
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                hukumu!
                                    ? const Icon(
                                        Icons.bookmark_outlined,
                                        color: Colors.orange,
                                        size: 35,
                                      )
                                    : const Icon(
                                        Icons.bookmark_outline_rounded,
                                        color: Colors.black,
                                        size: 35,
                                      ),
                                Text('保存する',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: hukumu!
                                            ? Colors.orange
                                            : Colors.black))
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Container(
                            color: Colors.orange,
                            width: 120,
                            height: 40,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) => AddReviews(
                                          articleId: articleId,
                                          jugyoumei:
                                              firebasesnapshot!.get('授業名'),
                                        ),
                                        transitionDuration:
                                            const Duration(seconds: 0),
                                      ));
                                },
                                child: Center(
                                    child: Text(
                                        firebasesnapshot1 == null
                                            ? '口コミを追加する'
                                            : '口コミを編集する',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.white,
                                        )))),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
