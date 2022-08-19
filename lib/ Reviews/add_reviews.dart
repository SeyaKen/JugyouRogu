import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jugyourogu/main_page.dart';

class AddReviews extends StatefulWidget {
  AddReviews({super.key, required this.articleId, required this.jugyoumei});

  String articleId, jugyoumei;

  @override
  State<AddReviews> createState() => _AddReviewsState(articleId, jugyoumei);
}

class _AddReviewsState extends State<AddReviews> {
  double _kItemExtent = 32.0;
  String articleId, jugyoumei;
  _AddReviewsState(this.articleId, this.jugyoumei);

  List<String> title_list = [
    '内容充実度',
    '単位取得度',
    'テスト形式(中間)',
    'テスト形式(期末)',
    'テスト時の持込',
    '教科書',
    '出席',
  ];

  List Select_list = [
    Juujitu_list,
    Rakutan_list,
    Shusseki_list,
    Chukan_list,
    Kimatu_list,
    Motikomi_list,
    Kyoukasho_list,
  ];

  @override
  void initState() {
    super.initState();
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 200,
              padding: const EdgeInsets.only(top: 0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(jugyoumei,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: title_list.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(title_list[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: InkWell(
                          child: Text(
                            index == 0
                                ? _ratingValue0 == null
                                    ? '選択してください'
                                    : _ratingValue0!
                                : index == 1
                                    ? _ratingValue1 == null
                                        ? '選択してください'
                                        : _ratingValue1!
                                    : index == 2
                                        ? _ratingValue2 == null
                                            ? '選択してください'
                                            : _ratingValue2!
                                        : index == 3
                                            ? _ratingValue3 == null
                                                ? '選択してください'
                                                : _ratingValue3!
                                            : index == 4
                                                ? _ratingValue4 == null
                                                    ? '選択してください'
                                                    : _ratingValue4!
                                                : index == 5
                                                    ? _ratingValue5 == null
                                                        ? '選択してください'
                                                        : _ratingValue5!
                                                    : _ratingValue6 == null
                                                        ? '選択してください'
                                                        : _ratingValue6!,
                            style: TextStyle(
                              fontSize: 20,
                              color: index == 0
                                  ? _ratingValue0 == null
                                      ? Colors.grey
                                      : Colors.black
                                  : index == 1
                                      ? _ratingValue1 == null
                                          ? Colors.grey
                                          : Colors.black
                                      : index == 2
                                          ? _ratingValue2 == null
                                              ? Colors.grey
                                              : Colors.black
                                          : index == 3
                                              ? _ratingValue3 == null
                                                  ? Colors.grey
                                                  : Colors.black
                                              : index == 4
                                                  ? _ratingValue4 == null
                                                      ? Colors.grey
                                                      : Colors.black
                                                  : index == 5
                                                      ? _ratingValue5 == null
                                                          ? Colors.grey
                                                          : Colors.black
                                                      : _ratingValue6 == null
                                                          ? Colors.grey
                                                          : Colors.black,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (index == 0) {
                                _ratingValue0 = Juujitu_list[0];
                              } else if (index == 1) {
                                _ratingValue1 = Rakutan_list[0];
                              } else if (index == 2) {
                                _ratingValue2 = Chukan_list[0];
                              } else if (index == 3) {
                                _ratingValue3 = Kimatu_list[0];
                              } else if (index == 4) {
                                _ratingValue4 = Motikomi_list[0];
                              } else if (index == 5) {
                                _ratingValue5 = Kyoukasho_list[0];
                              } else {
                                _ratingValue6 = Shusseki_list[0];
                              }
                            });
                            _showDialog(
                              CupertinoPicker(
                                magnification: 1.22,
                                squeeze: 1.2,
                                useMagnifier: true,
                                itemExtent: _kItemExtent,
                                onSelectedItemChanged: (int selectedItem) {
                                  setState(() {
                                    index == 0
                                        ? _ratingValue0 =
                                            Juujitu_list[selectedItem]
                                        : index == 1
                                            ? _ratingValue1 =
                                                Rakutan_list[selectedItem]
                                            : index == 2
                                                ? _ratingValue2 =
                                                    Chukan_list[selectedItem]
                                                : index == 3
                                                    ? _ratingValue3 =
                                                        Kimatu_list[
                                                            selectedItem]
                                                    : index == 4
                                                        ? _ratingValue4 =
                                                            Motikomi_list[
                                                                selectedItem]
                                                        : index == 5
                                                            ? _ratingValue5 =
                                                                Kyoukasho_list[
                                                                    selectedItem]
                                                            : _ratingValue6 =
                                                                Shusseki_list[
                                                                    selectedItem];
                                  });
                                },
                                children: List<Widget>.generate(
                                    index == 0
                                        ? Juujitu_list.length
                                        : index == 1
                                            ? Rakutan_list.length
                                            : index == 2
                                                ? Chukan_list.length
                                                : index == 3
                                                    ? Kimatu_list.length
                                                    : index == 4
                                                        ? Motikomi_list.length
                                                        : index == 5
                                                            ? Kyoukasho_list
                                                                .length
                                                            : Shusseki_list
                                                                .length,
                                    (int indexx) {
                                  return Center(
                                    child: Text(index == 0
                                        ? Juujitu_list[indexx]
                                        : index == 1
                                            ? Rakutan_list[indexx]
                                            : index == 2
                                                ? Chukan_list[indexx]
                                                : index == 3
                                                    ? Kimatu_list[indexx]
                                                    : index == 4
                                                        ? Motikomi_list[indexx]
                                                        : index == 5
                                                            ? Kyoukasho_list[
                                                                indexx]
                                                            : Shusseki_list[
                                                                indexx]),
                                  );
                                }),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }),
        ),
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
          color: _ratingValue0 != null &&
                  _ratingValue1 != null &&
                  _ratingValue2 != null &&
                  _ratingValue3 != null &&
                  _ratingValue4 != null &&
                  _ratingValue5 != null &&
                  _ratingValue6 != null
              ? Colors.orange
              : Colors.orange.withOpacity(0.5),
          width: MediaQuery.of(context).size.width * 0.95,
          height: 50,
          child: InkWell(
              onTap: () {
                if (_ratingValue0 != null &&
                    _ratingValue1 != null &&
                    _ratingValue2 != null &&
                    _ratingValue3 != null &&
                    _ratingValue4 != null &&
                    _ratingValue5 != null &&
                    _ratingValue6 != null) {
                  FirebaseFirestore.instance
                      .collection('classes')
                      .doc(articleId)
                      .collection('reviews')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .set({
                    'Juujitu': Juujitu_list.indexOf(_ratingValue0),
                    'Rakutan': Rakutan_list.indexOf(_ratingValue1),
                    'Chukan': Chukan_list.indexOf(_ratingValue2),
                    'Kimatu': Kimatu_list.indexOf(_ratingValue3),
                    'Motikomi': Motikomi_list.indexOf(_ratingValue4),
                    'Kyoukasho': Kyoukasho_list.indexOf(_ratingValue5),
                    'Shusseki': Shusseki_list.indexOf(_ratingValue6),
                  });
                  _ratingValue0 = null;
                  _ratingValue1 = null;
                  _ratingValue2 = null;
                  _ratingValue3 = null;
                  _ratingValue4 = null;
                  _ratingValue5 = null;
                  _ratingValue6 = null;
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => MainPage(currenttab: 0),
                        transitionDuration: const Duration(seconds: 0),
                      ));
                }
              },
              child: const Center(
                  child: Text('投稿',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white,
                      )))),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

List Juujitu_list = [
  'かなり充実',
  'まぁ充実',
  '普通',
  'やや物足りない',
  'かなり物足りない',
];

List Rakutan_list = [
  'かなり楽勝',
  'まぁ楽勝',
  '普通',
  'やや厳しい',
  'かなり厳しい',
];

List Shusseki_list = [
  'ほぼ毎回とる',
  'たまにとる',
  'とらない',
];

List Chukan_list = [
  'テストあり',
  'レポートのみ',
  'テスト・レポートなし',
  '授業なし',
];

List Kimatu_list = [
  'テストあり',
  'レポートのみ',
  'テスト・レポートなし',
  '授業なし',
];

List Motikomi_list = [
  'テストなし',
  '教科書・ノート等持込 ○',
  '教科書・ノート等持込 × ',
];

List Kyoukasho_list = [
  '教科書必要',
  '教科書なし、または不要',
];

String? _ratingValue0;
String? _ratingValue1;
String? _ratingValue2;
String? _ratingValue3;
String? _ratingValue4;
String? _ratingValue5;
String? _ratingValue6;
