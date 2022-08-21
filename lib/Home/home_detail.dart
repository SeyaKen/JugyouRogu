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

  getHomeLists() async {
    firebasesnapshot = await FirebaseFirestore.instance
        .collection('classes')
        .doc(articleId)
        .get();
    kutikomiListsStream = DatabaseService(uid).kutikomiCollect(articleId);
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
                        firebasesnapshot!.get('学部') != ''
                            ? Text(firebasesnapshot!.get('学部'),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ))
                            : Container(),
                        firebasesnapshot!.get('学部') != ''
                            ? const SizedBox(
                                width: 10,
                              )
                            : Container(),
                        Text(firebasesnapshot!.get('教授・講師名'),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Row(
                          children: [
                            const Text(
                              '内容充実度:',
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_outline,
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
                            const Text(
                              '単位取得度:',
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_outline,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(children: [
                      const Text(
                        '曜日・時限:  ',
                      ),
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
                                return InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 15),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      top: BorderSide(
                                          width: 0.5, color: Colors.black),
                                    )),
                                    child: Column(children: [
                                      Row(children: [
                                        Text(Shusseki_list[snapshot
                                            .data!.docs[index]['Shusseki']]),
                                        Text(Kyoukasho_list[snapshot
                                            .data!.docs[index]['Kyoukasho']]),
                                      ]),
                                      Row(children: [
                                        Text(Chukan_list[snapshot
                                            .data!.docs[index]['Chukan']]),
                                        Text(Kimatu_list[snapshot
                                            .data!.docs[index]['Kimatu']]),
                                        Text(Motikomi_list[snapshot
                                            .data!.docs[index]['Motikomi']]),
                                      ]),
                                    ]),
                                  ),
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
