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
  double _ratingValue0 = 1;
  double _ratingValue1 = 1;
  double _ratingValue2 = 1;
  double _ratingValue3 = 1;
  double _ratingValue4 = 1;
  double _ratingValue5 = 1;
  double _ratingValue6 = 1;
  int _selectedFruit = 0;

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

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
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
                      height: 10,
                    ),
                    Text(title_list[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      width: 200,
                      child: InkWell(
                        child: const Text(
                          '選択してください',
                          style: TextStyle(fontSize: 20),
                        ),
                        onTap: () {
                        _showDialog(
                          CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: _kItemExtent,
                            // This is called when selected item is changed.
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                                _selectedFruit = selectedItem;
                              });
                            },
                            children: List<Widget>.generate(title_list.length,
                                (int index) {
                              return Center(
                                child: Text(
                                  title_list[index],
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
