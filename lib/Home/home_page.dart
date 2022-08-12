import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jugyourogu/%20AddClass/add_class.dart';
import 'package:jugyourogu/%20Reviews/add_reviews.dart';
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
      backgroundColor: const Color(0xff131313),
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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xff333333),
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
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 19,
                      color: Colors.grey,
                    ),
                    isDense: true,
                    border: InputBorder.none,
                    hintText: '検索',
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
        ],
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(1000),
        child: Container(
          color: Colors.white,
          width: 65,
          height: 65,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const AddReviews(),
                    transitionDuration: const Duration(seconds: 0),
                  ));
            },
            child: const Icon(
              Icons.add_rounded,
              size: 45,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
