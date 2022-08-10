import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jugyourogu/main_page.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  double? _ratingValue;

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '内容充実度',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(
              width: 200,
              child: RatingBar(
                  initialRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
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
                      _ratingValue = value;
                    });
                  }),
            ),
            Text(
              _ratingValue != 0 ? _ratingValue.toString() : 'Rate it!',
              style: const TextStyle(fontSize: 30),
            ),
          ],
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
                  child: Text('授業を作成する',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )))),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
