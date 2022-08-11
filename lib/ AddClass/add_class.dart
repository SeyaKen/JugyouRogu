import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jugyourogu/main_page.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  double _ratingValue0 = 1;
  double _ratingValue1 = 1;
  double _ratingValue2 = 1;
  double _ratingValue3 = 1;
  double _ratingValue4 = 1;
  double _ratingValue5 = 1;
  double _ratingValue6 = 1;

  List<int> stars_list = [5, 5, 3, 3, 3, 3, 2];

  List<String> title_list = [
    '内容充実度',
    '楽単度',
    'テスト形式(中間)',
    'テスト形式(期末)',
    'テスト時の持込',
    '教科書',
    '出席',
  ];

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
                      height: 10,
                    ),
                    Text(title_list[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      width: 200,
                      child: RatingBar(
                          initialRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: stars_list[index],
                          itemSize: 30,
                          ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star,
                                color: Color(0XFF37EBFA),
                              ),
                              half: const Icon(
                                Icons.star_half,
                                color: Color(0XFF37EBFA),
                              ),
                              empty: const Icon(
                                Icons.star_outline,
                                color: Color(0XFF37EBFA),
                              )),
                          onRatingUpdate: (value) {
                            setState(() {
                              index == 0
                                  ? _ratingValue0 = value
                                  : index == 1
                                      ? _ratingValue1 = value
                                      : index == 2
                                          ? _ratingValue2 = value
                                          : index == 3
                                              ? _ratingValue3 = value
                                              : index == 4
                                                  ? _ratingValue4 = value
                                                  : index == 5
                                                      ? _ratingValue5 = value
                                                      : _ratingValue6 = value;
                            });
                          }),
                    ),
                    Text(
                      _ratingValue0 == 5
                          ? 'かなり充実'
                          : _ratingValue0 == 4
                              ? 'まぁ充実'
                              : _ratingValue0 == 3
                                  ? '普通'
                                  : _ratingValue0 == 2
                                      ? 'やや物足りない'
                                      : 'かなり物足りない',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                );
              }),
        ),
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: const Color(0XFF37EBFA).withOpacity(0.5),
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
