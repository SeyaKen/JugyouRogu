import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jugyourogu/%20AddClass/add_class.dart';
import 'package:jugyourogu/Home/home_detail.dart';
import 'package:jugyourogu/Service/database.dart';
import 'package:jugyourogu/ad_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Stream<QuerySnapshot<Object?>>? jugyouListsStream, searchStateStream;
  final ScrollController _scrollController = ScrollController();
  int _currentMax = 20;
  BannerAd? banner;
  double? _ratingValue;

  getHomeLists() async {
    jugyouListsStream = DatabaseService(uid).dataCollect();
    setState(() {});
  }

  _getMoreData() async {
    _currentMax = _currentMax + 20;
    jugyouListsStream =
        await DatabaseService(uid).fetchAdditionalData(_currentMax);
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
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  List preForSearch = [];
                  if (text.length > 1) {
                    for (int i = 0; i < text.length - 1; i++) {
                      if (!preForSearch.contains(text.substring(i, i + 2))) {
                        preForSearch.add(text.substring(i, i + 2));
                      }
                    }
                    searchStateStream = await DatabaseService(uid)
                        .searchDataCollect(preForSearch);
                    setState(() {});
                  } else {
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
                    hintText: '検索',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                      color: Colors.black,
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
          StreamBuilder<QuerySnapshot>(
              stream: jugyouListsStream,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => HomeDetail(
                                    articleId: snapshot.data!.docs[index].id,
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
                                top:
                                    BorderSide(width: 0.5, color: Colors.black),
                              )),
                              child: Column(children: [
                                Row(
                                  children: [
                                    Text(snapshot.data!.docs[index]['授業名'],
                                        style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    snapshot.data!.docs[index]['学部'] != ''
                                        ? Text(snapshot.data!.docs[index]['学部'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ))
                                        : Container(),
                                    snapshot.data!.docs[index]['学部'] != ''
                                        ? const SizedBox(
                                            width: 10,
                                          )
                                        : Container(),
                                    Text(snapshot.data!.docs[index]['教授・講師名'],
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
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          '楽単度:',
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
                              ]),
                            ),
                          );
                        })
                    : const Center(child: CircularProgressIndicator());
              }),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const AddClass(),
                  transitionDuration: const Duration(seconds: 0),
                ));
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: Container(
              color: Colors.orange,
              width: 65,
              height: 65,
              child: const Icon(
                Icons.add_rounded,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
