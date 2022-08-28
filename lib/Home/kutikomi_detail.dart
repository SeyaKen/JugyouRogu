import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jugyourogu/%20Reviews/add_reviews.dart';
import 'package:jugyourogu/Service/sharedpref_helper.dart';

class KutikomiDetail extends StatefulWidget {
  KutikomiDetail(
      {super.key,
      required this.jugyoumei,
      required this.AitenoUid,
      required this.articleId});

  String jugyoumei, AitenoUid, articleId;

  @override
  State<KutikomiDetail> createState() =>
      _KutikomiDetailState(jugyoumei, AitenoUid, articleId);
}

class _KutikomiDetailState extends State<KutikomiDetail> {
  String jugyoumei, AitenoUid, articleId;
  _KutikomiDetailState(this.jugyoumei, this.AitenoUid, this.articleId);
  DocumentSnapshot? firebasesnapshot, firebasesnapshot2;
  String? daigakuMei;

  getHomeLists() async {
    daigakuMei = await SharedPreferenceHelper().getUserDaigaku();
    firebasesnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(AitenoUid)
        .get();
    firebasesnapshot2 = await FirebaseFirestore.instance
        .collection(daigakuMei!)
        .doc(articleId)
        .collection('reviews')
        .doc(AitenoUid)
        .get();
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
          shape:
              const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(jugyoumei,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: firebasesnapshot != null && firebasesnapshot2 != null
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    children: [
                      Row(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(150.0),
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.network(
                                firebasesnapshot!.get('ProfilePicture') == ''
                                    ? 'https://firebasestorage.googleapis.com/v0/b/jugyourogu-d71e0.appspot.com/o/44884218_345707102882519_2446069589734326272_n.jpeg?alt=media&token=816dc8a0-f2d6-4a73-9acc-391a74dbc75b'
                                    : firebasesnapshot!.get('ProfilePicture'),
                                fit: BoxFit.cover,
                              )),
                        ),
                        const SizedBox(width: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                firebasesnapshot!.get('name'),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                firebasesnapshot2!
                                    .get('Daytime')
                                    .toDate()
                                    .toString()
                                    .substring(0, 16),
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ]),
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                              firebasesnapshot2!
                                                          .get('Juujitu') >
                                                      0
                                                  ? Icons.star
                                                  : Icons.star_outline,
                                              color: Colors.orange,
                                              size: 20,
                                            ),
                                            Icon(
                                              firebasesnapshot2!
                                                          .get('Juujitu') >
                                                      1
                                                  ? Icons.star
                                                  : Icons.star_outline,
                                              color: Colors.orange,
                                              size: 20,
                                            ),
                                            Icon(
                                              firebasesnapshot2!
                                                          .get('Juujitu') >
                                                      2
                                                  ? Icons.star
                                                  : Icons.star_outline,
                                              color: Colors.orange,
                                              size: 20,
                                            ),
                                            Icon(
                                              firebasesnapshot2!
                                                          .get('Juujitu') >
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
                                              firebasesnapshot2!
                                                          .get('Rakutan') >
                                                      0
                                                  ? Icons.star
                                                  : Icons.star_outline,
                                              color: Colors.orange,
                                              size: 20,
                                            ),
                                            Icon(
                                              firebasesnapshot2!
                                                          .get('Rakutan') >
                                                      1
                                                  ? Icons.star
                                                  : Icons.star_outline,
                                              color: Colors.orange,
                                              size: 20,
                                            ),
                                            Icon(
                                              firebasesnapshot2!
                                                          .get('Rakutan') >
                                                      2
                                                  ? Icons.star
                                                  : Icons.star_outline,
                                              color: Colors.orange,
                                              size: 20,
                                            ),
                                            Icon(
                                              firebasesnapshot2!
                                                          .get('Rakutan') >
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
                                      Text(Shusseki_list[
                                          firebasesnapshot2!.get('Shusseki')]),
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
                                      Text(Kyoukasho_list[
                                          firebasesnapshot2!.get('Kyoukasho')]),
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
                                      Text(Chukan_list[
                                          firebasesnapshot2!.get('Chukan')]),
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
                                      Text(Kimatu_list[
                                          firebasesnapshot2!.get('Kimatu')]),
                                    ],
                                  ),
                                ]),
                                Row(
                                  children: [
                                    const Text('持ち込み:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Text(Motikomi_list[
                                        firebasesnapshot2!.get('Motikomi')]),
                                  ],
                                ),
                              ]),
                        ],
                      ),
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
                      Text(
                        firebasesnapshot2!.get('Kutikomi'),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
