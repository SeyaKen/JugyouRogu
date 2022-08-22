import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jugyourogu/%20Reviews/add_reviews.dart';
import 'package:jugyourogu/Service/database.dart';

class HomeDetail extends StatefulWidget {
  HomeDetail({super.key, required this.articleId});

  String articleId;

  @override
  State<HomeDetail> createState() => _HomeDetailState(articleId);
}

class _HomeDetailState extends State<HomeDetail> {
  DocumentSnapshot? firebasesnapshot;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Stream<QuerySnapshot<Object?>>? kutikomiListsStream;
  String articleId;
  _HomeDetailState(this.articleId);
  final ScrollController _scrollController = ScrollController();
  double? JuujituInt;
  double? RakutanInt;

  getHomeLists() async {
    firebasesnapshot = await FirebaseFirestore.instance
        .collection('classes')
        .doc(articleId)
        .get();
    kutikomiListsStream = DatabaseService(uid).kutikomiCollect(articleId);
    JuujituInt = double.parse(firebasesnapshot!.get('JuujituAverage'));
    RakutanInt = double.parse(firebasesnapshot!.get('RakutanAverage'));
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
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:
            Text(firebasesnapshot != null ? firebasesnapshot!.get('授業名') : '',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
      ),
      body: firebasesnapshot != null
          ? Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(firebasesnapshot!.get('授業名'),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                        InkWell(
                          onTap: () {},
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
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text('学部:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                        firebasesnapshot!.get('学部') != ''
                            ? Text(firebasesnapshot!.get('学部'),
                                style: const TextStyle(
                                  fontSize: 15,
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
                              fontSize: 15,
                            )),
                        Text(firebasesnapshot!.get('教授・講師名'),
                            style: const TextStyle(
                              fontSize: 15,
                            )),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text('内容充実度:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
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
                              JuujituInt!.toString(),
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: [
                            const Text('楽単度:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
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
                              RakutanInt!.toString(),
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
                    Row(children: [
                      const Text('曜日・時限:  ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                        firebasesnapshot!.get('曜日・時限1'),
                      ),
                      firebasesnapshot!.get('曜日・時限1') != ''
                          ? const Text(
                              '-',
                            )
                          : const Text(''),
                      firebasesnapshot!.get('曜日・時限2') == ''
                          ? const Text('')
                          : Text(
                              firebasesnapshot!.get('曜日・時限2'),
                            ),
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Text('口コミ',
                            style: TextStyle(
                              fontSize: 20,
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
                          ? ListView.builder(
                              shrinkWrap: true,
                              controller: _scrollController,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 15),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    top: BorderSide(
                                        width: 0.5, color: Colors.black),
                                  )),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            const Text('内容充実度:',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                  size: 20,
                                                ),
                                                Icon(
                                                  snapshot.data!.docs[index]
                                                              ['Juujitu'] >
                                                          0
                                                      ? Icons.star
                                                      : Icons.star_outline,
                                                  color: Colors.orange,
                                                  size: 20,
                                                ),
                                                Icon(
                                                  snapshot.data!.docs[index]
                                                              ['Juujitu'] >
                                                          1
                                                      ? Icons.star
                                                      : Icons.star_outline,
                                                  color: Colors.orange,
                                                  size: 20,
                                                ),
                                                Icon(
                                                  snapshot.data!.docs[index]
                                                              ['Juujitu'] >
                                                          2
                                                      ? Icons.star
                                                      : Icons.star_outline,
                                                  color: Colors.orange,
                                                  size: 20,
                                                ),
                                                Icon(
                                                  snapshot.data!.docs[index]
                                                              ['Juujitu'] >
                                                          3
                                                      ? Icons.star
                                                      : Icons.star_outline,
                                                  color: Colors.orange,
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
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                  size: 20,
                                                ),
                                                Icon(
                                                  snapshot.data!.docs[index]
                                                              ['Rakutan'] >
                                                          0
                                                      ? Icons.star
                                                      : Icons.star_outline,
                                                  color: Colors.orange,
                                                  size: 20,
                                                ),
                                                Icon(
                                                  snapshot.data!.docs[index]
                                                              ['Rakutan'] >
                                                          1
                                                      ? Icons.star
                                                      : Icons.star_outline,
                                                  color: Colors.orange,
                                                  size: 20,
                                                ),
                                                Icon(
                                                  snapshot.data!.docs[index]
                                                              ['Rakutan'] >
                                                          2
                                                      ? Icons.star
                                                      : Icons.star_outline,
                                                  color: Colors.orange,
                                                  size: 20,
                                                ),
                                                Icon(
                                                  snapshot.data!.docs[index]
                                                              ['Rakutan'] >
                                                          3
                                                      ? Icons.star
                                                      : Icons.star_outline,
                                                  color: Colors.orange,
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
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(Shusseki_list[snapshot
                                              .data!.docs[index]['Shusseki']]),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text('教科書:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(Kyoukasho_list[snapshot
                                              .data!.docs[index]['Kyoukasho']]),
                                        ],
                                      ),
                                    ]),
                                    Row(children: [
                                      Row(
                                        children: [
                                          const Text('中間:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(Chukan_list[snapshot
                                              .data!.docs[index]['Chukan']]),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text('期末:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(Kimatu_list[snapshot
                                              .data!.docs[index]['Kimatu']]),
                                        ],
                                      ),
                                    ]),
                                    Row(
                                      children: [
                                        const Text('持ち込み:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text(Motikomi_list[snapshot
                                            .data!.docs[index]['Motikomi']]),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(150.0),
                                        child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('users')
                                                  .where('uid',
                                                      isEqualTo: snapshot.data!
                                                          .docs[index]['uid'])
                                                  .snapshots(),
                                              builder: (context, snapshot0) {
                                                return snapshot0.hasData
                                                    ? Image.network(
                                                        snapshot0.data!.docs[0][
                                                                    'ProfilePicture'] ==
                                                                ''
                                                            ? 'https://firebasestorage.googleapis.com/v0/b/jugyourogu-d71e0.appspot.com/o/44884218_345707102882519_2446069589734326272_n.jpeg?alt=media&token=816dc8a0-f2d6-4a73-9acc-391a74dbc75b'
                                                            : snapshot0.data!
                                                                    .docs[0][
                                                                'ProfilePicture'],
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.network(
                                                        'https://firebasestorage.googleapis.com/v0/b/jugyourogu-d71e0.appspot.com/o/44884218_345707102882519_2446069589734326272_n.jpeg?alt=media&token=816dc8a0-f2d6-4a73-9acc-391a74dbc75b',
                                                        fit: BoxFit.cover,
                                                      );
                                              }),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                StreamBuilder<QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('users')
                                                        .where('uid',
                                                            isEqualTo: snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                ['uid'])
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot1) {
                                                      return snapshot1.hasData
                                                          ? SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.8,
                                                              child: Text(
                                                                snapshot1.data!
                                                                        .docs[0]
                                                                    ['name'],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            )
                                                          : const Text('');
                                                    }),
                                                const SizedBox(height: 5),
                                                Text(
                                                  snapshot.data!
                                                      .docs[index]['Daytime']
                                                      .toDate()
                                                      .toString()
                                                      .substring(0, 16),
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ]),
                                  ]),
                                );
                              })
                          : const Center(child: CircularProgressIndicator());
                    })
              ],
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: Colors.orange,
          width: MediaQuery.of(context).size.width * 0.4,
          height: 60,
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => AddReviews(
                        articleId: articleId,
                        jugyoumei: firebasesnapshot!.get('授業名'),
                      ),
                      transitionDuration: const Duration(seconds: 0),
                    ));
              },
              child: const Center(
                  child: Text('口コミを追加する',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white,
                      )))),
        ),
      ),
    );
  }
}
