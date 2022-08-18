import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jugyourogu/main_page.dart';

class AddReviews extends StatefulWidget {
  const AddReviews({super.key});

  @override
  State<AddReviews> createState() => _AddReviewsState();
}

class _AddReviewsState extends State<AddReviews> {
  double _kItemExtent = 32.0;

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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text('口コミを追加する',
            style: TextStyle(
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
                                  : Colors.black,
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
                                    // index == 0
                                    //     ? _ratingValue0 = Juujitu_list[0] as int?
                                    //     : index == 1
                                    //         ? _ratingValue1 =
                                    //             _ratingValue1![selectedItem]
                                    //         : index == 2
                                    //             ? _ratingValue2 =
                                    //                 Rating[index][selectedItem]
                                    //             : index == 3
                                    //                 ? _ratingValue3 =
                                    //                     Rating[index]
                                    //                         [selectedItem]
                                    //                 : index == 4
                                    //                     ? _ratingValue4 =
                                    //                         Rating[index]
                                    //                             [selectedItem]
                                    //                     : index == 5
                                    //                         ? _ratingValue5 =
                                    //                             Rating[index][
                                    //                                 selectedItem]
                                    //                         : _ratingValue6 =
                                    //                             Rating[index][
                                    //                                 selectedItem];
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
                print(Rating);
                print(_ratingValue0);
                // Navigator.push(
                //     context,
                //     PageRouteBuilder(
                //       pageBuilder: (_, __, ___) => MainPage(currenttab: 0),
                //       transitionDuration: const Duration(seconds: 0),
                //     ));
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

List<Map<int, String>> Juujitu_list = [
  {0: 'かなり充実'},
  {1: 'まぁ充実'},
  {2: '普通'},
  {3: 'やや物足りない'},
  {4: 'かなり物足りない'},
];

List<Map<int, String>> Rakutan_list = [
  {0: 'かなり楽勝'},
  {1: 'まぁ楽勝'},
  {2: '普通'},
  {3: 'やや厳しい'},
  {4: 'かなり厳しい'},
];

List<Map<int, String>> Shusseki_list = [
  {0: 'ほぼ毎回とる'},
  {1: 'たまにとる'},
  {2: 'とらない'},
];

List<Map<int, String>> Chukan_list = [
  {0: 'テストあり'},
  {1: 'レポートのみ'},
  {2: 'テスト・レポートなし'},
  {3: '授業なし'},
];

List<Map<int, String>> Kimatu_list = [
  {0: 'テストあり'},
  {1: 'レポートのみ'},
  {2: 'テスト・レポートなし'},
  {3: '授業なし'},
];

List<Map<int, String>> Motikomi_list = [
  {0: 'テストなし'},
  {1: '教科書・ノート等持込 ○'},
  {2: '教科書・ノート等持込 × '},
];

List<Map<int, String>> Kyoukasho_list = [
  {0: '教科書必要'},
  {1: '教科書なし、または不要'},
];

int? _ratingValue0;
int? _ratingValue1;
int? _ratingValue2;
int? _ratingValue3;
int? _ratingValue4;
int? _ratingValue5;
int? _ratingValue6;
