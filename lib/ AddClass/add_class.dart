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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '内容充実度',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              ),
              SizedBox(
                width: 200,
                child: RatingBar(
                    initialRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
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
                        _ratingValue0 = value;
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
                : _ratingValue0 == 1
                ? 'かなり物足りない'
                : '',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Text(
                '楽単度',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              ),
              SizedBox(
                width: 200,
                child: RatingBar(
                    initialRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 30,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Color(0XFF37EBFA)),
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
                        _ratingValue1 = value;
                      });
                    }),
              ),
              Text(
                _ratingValue1 == 5
                ? 'かなり楽勝'
                : _ratingValue1 == 4
                ? 'まぁ楽勝'
                : _ratingValue1 == 3
                ? '普通'
                : _ratingValue1 == 2
                ? 'やや厳しい'
                : _ratingValue1 == 1
                ? 'かなり厳しい'
                : '',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Text(
                'テスト形式(中間)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              ),
              SizedBox(
                width: 200,
                child: RatingBar(
                    initialRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 3,
                    itemSize: 30,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Color(0XFF37EBFA)),
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
                        _ratingValue1 = value;
                      });
                    }),
              ),
              Text(
                _ratingValue1 == 3
                ? '普通'
                : _ratingValue1 == 2
                ? 'やや厳しい'
                : _ratingValue1 == 1
                ? 'かなり厳しい'
                : '',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Text(
                'テスト形式(期末)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              ),
              SizedBox(
                width: 200,
                child: RatingBar(
                    initialRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 3,
                    itemSize: 30,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Color(0XFF37EBFA)),
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
                        _ratingValue1 = value;
                      });
                    }),
              ),
              Text(
                _ratingValue1 == 3
                ? 'テスト・レポートなし'
                : _ratingValue1 == 2
                ? 'レポートのみ'
                : _ratingValue1 == 1
                ? 'テスト有り'
                : '',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Text(
                'テスト時の持込',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              ),
              SizedBox(
                width: 200,
                child: RatingBar(
                    initialRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 3,
                    itemSize: 30,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Color(0XFF37EBFA)),
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
                        _ratingValue1 = value;
                      });
                    }),
              ),
              Text(
                _ratingValue1 == 3
                ? 'テスト・レポートなし'
                : _ratingValue1 == 2
                ? 'レポートのみ'
                : _ratingValue1 == 1
                ? 'テスト有り'
                : '',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Text(
                '教科書',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              ),
              SizedBox(
                width: 200,
                child: RatingBar(
                    initialRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 3,
                    itemSize: 30,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.circle, color: Color(0XFF37EBFA)),
                        half: const Icon(
                          Icons.circle,
                          color: Color(0XFF37EBFA),
                        ),
                        empty: const Icon(
                          Icons.circle_outlined,
                          color: Color(0XFF37EBFA),
                        )),
                    onRatingUpdate: (value) {
                      setState(() {
                        _ratingValue1 = value;
                      });
                    }),
              ),
              Text(
                _ratingValue1 == 3
                ? 'テスト・レポートなし'
                : _ratingValue1 == 2
                ? 'レポートのみ'
                : _ratingValue1 == 1
                ? 'テスト有り'
                : '',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              const Text(
                '出席',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              ),
              SizedBox(
                width: 200,
                child: RatingBar(
                    initialRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 3,
                    itemSize: 30,
                    ratingWidget: RatingWidget(
                        full: const Icon(Icons.star, color: Color(0XFF37EBFA)),
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
                        _ratingValue1 = value;
                      });
                    }),
              ),
              Text(
                _ratingValue1 == 3
                ? 'テスト・レポートなし'
                : _ratingValue1 == 2
                ? 'レポートのみ'
                : _ratingValue1 == 1
                ? 'テスト有り'
                : '',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
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
