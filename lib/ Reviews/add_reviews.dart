import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jugyourogu/main_page.dart';

class AddReviews extends StatefulWidget {
  const AddReviews({super.key});

  @override
  State<AddReviews> createState() => _AddReviewsState();
}

class _AddReviewsState extends State<AddReviews> {
  double _kItemExtent = 32.0;

  bool isBelowThreshold(currentValue) {
    return currentValue == null;
  }

  List<String> title_list = [
    '内容充実度',
    '楽単度',
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

  List Rating = [
    _ratingValue0,
    _ratingValue1,
    _ratingValue2,
    _ratingValue3,
    _ratingValue4,
    _ratingValue5,
    _ratingValue6,
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
      backgroundColor: const Color(0xff131313),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
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
                      width: 200,
                      child: InkWell(
                          child: Text(
                            Rating[index] == null
                                ? '選択してください'
                                : Select_list[index][Rating[index]],
                            style: TextStyle(
                              fontSize: 20,
                              color: Rating[index] == null
                                  ? Colors.grey
                                  : Colors.white,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              Rating[index] = 0;
                            });
                            _showDialog(
                              CupertinoPicker(
                                magnification: 1.22,
                                squeeze: 1.2,
                                useMagnifier: true,
                                itemExtent: _kItemExtent,
                                // This is called when selected item is changed.
                                onSelectedItemChanged: (int selectedItem) {
                                  setState(() {
                                    Rating[index] = selectedItem;
                                  });
                                },
                                children: List<Widget>.generate(
                                    Select_list[index].length, (int indexx) {
                                  return Center(
                                    child: Text(
                                      Select_list[index][indexx],
                                    ),
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
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Rating.every(isBelowThreshold)
              ? const Color(0XFF37EBFA).withOpacity(0.5)
              : const Color(0XFF37EBFA),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => MainPage(currenttab: 0),
                      transitionDuration: const Duration(seconds: 0),
                    ));
              },
              child: const Center(
                  child: Text('投稿',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      )))),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

List<String> Juujitu_list = [
  'かなり充実',
  'まぁ充実',
  '普通',
  'やや物足りない',
  'かなり物足りない',
];

List<String> Rakutan_list = [
  'かなり楽勝',
  'まぁ楽勝',
  '普通',
  'やや厳しい',
  'かなり厳しい',
];

List<String> Shusseki_list = [
  'ほぼ毎回とる',
  'たまにとる',
  'とらない',
];

List<String> Chukan_list = [
  'テストあり',
  'レポートのみ',
  'テスト・レポートなし',
  '授業なし',
];

List<String> Kimatu_list = [
  'テストあり',
  'レポートのみ',
  'テスト・レポートなし',
  '授業なし',
];

List<String> Motikomi_list = [
  'テストなし',
  '教科書・ノート等持込 ○',
  '教科書・ノート等持込 × ',
];

List<String> Kyoukasho_list = [
  '教科書必要',
  '教科書なし、または不要',
];

int? _ratingValue0;
int? _ratingValue1;
int? _ratingValue2;
int? _ratingValue3;
int? _ratingValue4;
int? _ratingValue5;
int? _ratingValue6;
