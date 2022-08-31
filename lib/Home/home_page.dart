import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jugyourogu/%20AddClass/add_class.dart';
import 'package:jugyourogu/Home/home_detail.dart';
import 'package:jugyourogu/Service/database.dart';
import 'package:jugyourogu/Service/sharedpref_helper.dart';
import 'package:jugyourogu/ad_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

bool buttonCheck = false;
List preForSearch = [];

class _HomePageState extends State<HomePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Stream<QuerySnapshot<Object?>>? jugyouListsStream,
      searchStateStream,
      searchAndNarabikaeStream;
  final ScrollController _scrollController = ScrollController();
  int _currentMax = 20;
  BannerAd? banner;
  String? daigakuMei;
  int dore = 0;

  getHomeLists() async {
    daigakuMei = await SharedPreferenceHelper().getUserDaigaku();
    jugyouListsStream = DatabaseService().dataCollect(daigakuMei!);
    setState(() {});
  }

  _getMoreData() async {
    _currentMax = _currentMax + 20;
    jugyouListsStream =
        await DatabaseService().fetchAdditionalData(_currentMax, daigakuMei!);
    // UIを読み込み直す
    setState(() {});
  }

  final BannerAdListener _adLister = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  @override
  void initState() {
    final adState = Provider.of<AdState>(context, listen: false);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          request: const AdRequest(),
          listener: const BannerAdListener(),
        )..load();
      });
    });
    getHomeLists();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: const Color(0xffffffff),
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                toolbarHeight: 80,
                elevation: 0,
                title: Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.95,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[300],
                  ),
                  child: TextField(
                      onChanged: (text) async {
                        dore = 1;
                        preForSearch = [];
                        if (text.length > 1) {
                          for (int i = 0; i < text.length - 1; i++) {
                            if (!preForSearch
                                .contains(text.substring(i, i + 2))) {
                              preForSearch.add(text.substring(i, i + 2));
                            }
                          }
                          searchStateStream = await DatabaseService()
                              .searchDataCollect(preForSearch, daigakuMei!);
                          setState(() {});
                        } else {
                          dore = 0;
                          searchStateStream = null;
                          setState(() {});
                        }
                      },
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: 19,
                            color: Colors.black,
                          ),
                          isDense: true,
                          border: InputBorder.none,
                          hintText: '授業名・教員名など(2文字以上)',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                            color: Colors.grey,
                          ))),
                )),
            body: Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: banner != null
                        ? AdWidget(
                            ad: banner!,
                          )
                        : const SizedBox()),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            buttonCheck = !buttonCheck;
                          });
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_drop_down,
                              size: 30,
                              color: Colors.black,
                            ),
                            Text('並び順',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Stack(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: dore == 0
                              ? jugyouListsStream
                              : dore == 1
                                  ? searchStateStream
                                  : searchAndNarabikaeStream,
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    controller: _scrollController,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  HomeDetail(
                                                articleId: snapshot
                                                    .data!.docs[index].id,
                                              ),
                                              transitionDuration:
                                                  const Duration(seconds: 0),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 13, vertical: 15),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                            top: BorderSide(
                                                width: 0.5,
                                                color: Colors.black),
                                          )),
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                Text(
                                                    snapshot.data!.docs[index]
                                                        ['授業名'],
                                                    style: const TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                snapshot.data!.docs[index]
                                                            ['学部'] !=
                                                        ''
                                                    ? const Text('学部:',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ))
                                                    : Container(),
                                                snapshot.data!.docs[index]
                                                            ['学部'] !=
                                                        ''
                                                    ? Text(
                                                        snapshot.data!
                                                            .docs[index]['学部'],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ))
                                                    : Container(),
                                                snapshot.data!.docs[index]
                                                            ['学部'] !=
                                                        ''
                                                    ? const SizedBox(
                                                        width: 10,
                                                      )
                                                    : Container(),
                                                const Text('教授:',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                Text(
                                                    snapshot.data!.docs[index]
                                                        ['教授・講師名'],
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
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          double.parse(snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'JuujituAverage']) !=
                                                                  0.0
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_outline,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        ),
                                                        Icon(
                                                          double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'JuujituAverage']) >=
                                                                      1.5 &&
                                                                  double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'JuujituAverage']) <
                                                                      2
                                                              ? Icons
                                                                  .star_half_outlined
                                                              : double.parse(snapshot
                                                                          .data!
                                                                          .docs[index]['JuujituAverage']) >=
                                                                      2
                                                                  ? Icons.star
                                                                  : Icons.star_outline,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        ),
                                                        Icon(
                                                          double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'JuujituAverage']) >=
                                                                      2.5 &&
                                                                  double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'JuujituAverage']) <
                                                                      3
                                                              ? Icons
                                                                  .star_half_outlined
                                                              : double.parse(snapshot
                                                                          .data!
                                                                          .docs[index]['JuujituAverage']) >=
                                                                      3
                                                                  ? Icons.star
                                                                  : Icons.star_outline,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        ),
                                                        Icon(
                                                          double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'JuujituAverage']) >=
                                                                      3.5 &&
                                                                  double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'JuujituAverage']) <
                                                                      4
                                                              ? Icons
                                                                  .star_half_outlined
                                                              : double.parse(snapshot
                                                                          .data!
                                                                          .docs[index]['JuujituAverage']) >=
                                                                      4
                                                                  ? Icons.star
                                                                  : Icons.star_outline,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        ),
                                                        Icon(
                                                          double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'JuujituAverage']) >=
                                                                      4.5 &&
                                                                  double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'JuujituAverage']) <
                                                                      5
                                                              ? Icons
                                                                  .star_half_outlined
                                                              : double.parse(snapshot
                                                                          .data!
                                                                          .docs[index]['JuujituAverage']) >=
                                                                      5
                                                                  ? Icons.star
                                                                  : Icons.star_outline,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                                  [
                                                                  'JuujituAverage'] !=
                                                              '0'
                                                          ? snapshot
                                                              .data!
                                                              .docs[index][
                                                                  'JuujituAverage']
                                                              .toString()
                                                          : 'データなし',
                                                      style: const TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text('楽単度:',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          double.parse(snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'RakutanAverage']) !=
                                                                  0.0
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_outline,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        ),
                                                        Icon(
                                                          double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'RakutanAverage']) >=
                                                                      1.5 &&
                                                                  double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'RakutanAverage']) <
                                                                      2
                                                              ? Icons
                                                                  .star_half_outlined
                                                              : double.parse(snapshot
                                                                          .data!
                                                                          .docs[index]['RakutanAverage']) >=
                                                                      2
                                                                  ? Icons.star
                                                                  : Icons.star_outline,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        ),
                                                        Icon(
                                                          double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'RakutanAverage']) >=
                                                                      2.5 &&
                                                                  double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'RakutanAverage']) <
                                                                      3
                                                              ? Icons
                                                                  .star_half_outlined
                                                              : double.parse(snapshot
                                                                          .data!
                                                                          .docs[index]['RakutanAverage']) >=
                                                                      3
                                                                  ? Icons.star
                                                                  : Icons.star_outline,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        ),
                                                        Icon(
                                                          double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'RakutanAverage']) >=
                                                                      3.5 &&
                                                                  double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'RakutanAverage']) <
                                                                      4
                                                              ? Icons
                                                                  .star_half_outlined
                                                              : double.parse(snapshot
                                                                          .data!
                                                                          .docs[index]['RakutanAverage']) >=
                                                                      4
                                                                  ? Icons.star
                                                                  : Icons.star_outline,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        ),
                                                        Icon(
                                                          double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'RakutanAverage']) >=
                                                                      4.5 &&
                                                                  double.parse(snapshot
                                                                              .data!
                                                                              .docs[index][
                                                                          'RakutanAverage']) <
                                                                      5
                                                              ? Icons
                                                                  .star_half_outlined
                                                              : double.parse(snapshot
                                                                          .data!
                                                                          .docs[index]['RakutanAverage']) >=
                                                                      5
                                                                  ? Icons.star
                                                                  : Icons.star_outline,
                                                          color: Colors.orange,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                                  [
                                                                  'RakutanAverage'] !=
                                                              '0'
                                                          ? snapshot
                                                              .data!
                                                              .docs[index][
                                                                  'RakutanAverage']
                                                              .toString()
                                                          : 'データなし',
                                                      style: const TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ),
                                      );
                                    })
                                : const Center(
                                    child: CircularProgressIndicator());
                          }),
                      buttonCheck
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  buttonCheck = false;
                                });
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                              ),
                            )
                          : Container(),
                      buttonCheck
                          ? Positioned(
                              top: -10,
                              right: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        dore = 2;
                                        buttonCheck = false;
                                        searchAndNarabikaeStream =
                                            await DatabaseService()
                                                .searchAndNarabikae(
                                                    preForSearch,
                                                    daigakuMei!,
                                                    'JuujituAverage');
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey,
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: const [
                                            Text('内容充実度順',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        dore = 2;
                                        buttonCheck = false;
                                        searchAndNarabikaeStream =
                                            await DatabaseService()
                                                .searchAndNarabikae(
                                                    preForSearch,
                                                    daigakuMei!,
                                                    'RakutanAverage');
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Row(
                                          children: const [
                                            Text(
                                              '楽単順',
                                              style: TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Container(
                color: const Color(0xff92b82e),
                width: MediaQuery.of(context).size.width * 0.4,
                height: 60,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const AddClass(),
                          transitionDuration: const Duration(seconds: 0),
                        ));
                  },
                  child: const Center(
                    child: Text('授業を作成',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
