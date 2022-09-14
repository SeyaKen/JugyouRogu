import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jugyourogu/Home/home_detail.dart';
import 'package:jugyourogu/Service/database.dart';
import 'package:jugyourogu/Service/sharedpref_helper.dart';
import 'package:jugyourogu/ad_state.dart';
import 'package:provider/provider.dart';

class favoriteListScreen extends StatefulWidget {
  const favoriteListScreen({super.key});

  @override
  State<favoriteListScreen> createState() => _favoriteListScreenState();
}

class _favoriteListScreenState extends State<favoriteListScreen> {
  final ScrollController _scrollController = ScrollController();
  BannerAd? banner;
  Stream<QuerySnapshot<Object?>>? favoriteListStream;
  String? daigakuMei;
  DocumentSnapshot? firebasesnapshot;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Map? favo;
  List favoriteList3 = [];

  getHomeLists() async {
    daigakuMei = await SharedPreferenceHelper().getUserDaigaku();
    firebasesnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    favo = firebasesnapshot!.get('favorite');
    if(favo![daigakuMei] != null) {
      for (int i = 0; i < favo![daigakuMei].length; i++) {
      DocumentSnapshot favoriteList2 = await FirebaseFirestore.instance
          .collection(daigakuMei!)
          .doc(favo![daigakuMei][i])
          .get();
      favoriteList3.add(favoriteList2);
      if (i == favo!.length - 1) {
        favoriteList3 = favoriteList3;
      }
    }
    }
    
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
    getHomeLists();
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

    super.initState();
    setState(() {});
  }

  // 上に引っ張った時の処理
  Future _loadData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text('お気に入り',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: RefreshIndicator(
          onRefresh: (() async {
            _loadData();
          }),
          child: favoriteList3.isEmpty
              ? const Center(
                  child: Text(
                  'お気に入りがありません。',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ))
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: favoriteList3.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index == 0
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: banner != null
                                ? AdWidget(
                                    ad: banner!,
                                  )
                                : const SizedBox())
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => HomeDetail(
                                    articleId: favoriteList3[index - 1].id,
                                    fromTag: 1,
                                  ),
                                  transitionDuration:
                                      const Duration(seconds: 0),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 8),
                              decoration: const BoxDecoration(
                                  border: Border(
                                top:
                                    BorderSide(width: 0.5, color: Colors.black),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                favoriteList3[index - 1]
                                                    .get('授業名'),
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Row(
                                          children: [
                                            favoriteList3[index - 1]
                                                        .get('学部') !=
                                                    ''
                                                ? const Text('学部:',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ))
                                                : Container(),
                                            favoriteList3[index - 1]
                                                        .get('学部') !=
                                                    ''
                                                ? Text(
                                                    favoriteList3[index - 1]
                                                        .get('学部'),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                    ))
                                                : Container(),
                                            favoriteList3[index - 1]
                                                        .get('学部') !=
                                                    ''
                                                ? const SizedBox(
                                                    width: 10,
                                                  )
                                                : Container(),
                                            const Text('教授:',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            Text(
                                                favoriteList3[index - 1]
                                                    .get('教授・講師名'),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                )),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text('内容充実度:',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      double.parse(favoriteList3[
                                                                      index - 1]
                                                                  .get(
                                                                      'JuujituAverage')) !=
                                                              0.0
                                                          ? Icons.star
                                                          : Icons.star_outline,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'JuujituAverage')) >=
                                                                  1.5 &&
                                                              double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'JuujituAverage')) <
                                                                  2
                                                          ? Icons
                                                              .star_half_outlined
                                                          : double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'JuujituAverage')) >=
                                                                  2
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_outline,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'JuujituAverage')) >=
                                                                  2.5 &&
                                                              double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'JuujituAverage')) <
                                                                  3
                                                          ? Icons
                                                              .star_half_outlined
                                                          : double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'JuujituAverage')) >=
                                                                  3
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_outline,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'JuujituAverage')) >=
                                                                  3.5 &&
                                                              double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'JuujituAverage')) <
                                                                  4
                                                          ? Icons
                                                              .star_half_outlined
                                                          : double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'JuujituAverage')) >=
                                                                  4
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_outline,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'JuujituAverage')) >=
                                                                  4.5 &&
                                                              double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'JuujituAverage')) <
                                                                  5
                                                          ? Icons
                                                              .star_half_outlined
                                                          : double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'JuujituAverage')) >=
                                                                  5
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_outline,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  favoriteList3[index - 1].get(
                                                              'JuujituAverage') !=
                                                          '0'
                                                      ? favoriteList3[index - 1]
                                                          .get('JuujituAverage')
                                                          .toString()
                                                      : 'データなし',
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text('楽単度:',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    )),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      double.parse(favoriteList3[
                                                                      index - 1]
                                                                  .get(
                                                                      'RakutanAverage')) !=
                                                              0.0
                                                          ? Icons.star
                                                          : Icons.star_outline,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'RakutanAverage')) >=
                                                                  1.5 &&
                                                              double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'RakutanAverage')) <
                                                                  2
                                                          ? Icons
                                                              .star_half_outlined
                                                          : double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'RakutanAverage')) >=
                                                                  2
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_outline,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'RakutanAverage')) >=
                                                                  2.5 &&
                                                              double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'RakutanAverage')) <
                                                                  3
                                                          ? Icons
                                                              .star_half_outlined
                                                          : double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'RakutanAverage')) >=
                                                                  3
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_outline,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'RakutanAverage')) >=
                                                                  3.5 &&
                                                              double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'RakutanAverage')) <
                                                                  4
                                                          ? Icons
                                                              .star_half_outlined
                                                          : double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'RakutanAverage')) >=
                                                                  4
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_outline,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                    Icon(
                                                      double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'RakutanAverage')) >=
                                                                  4.5 &&
                                                              double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'RakutanAverage')) <
                                                                  5
                                                          ? Icons
                                                              .star_half_outlined
                                                          : double.parse(favoriteList3[
                                                                          index -
                                                                              1]
                                                                      .get(
                                                                          'RakutanAverage')) >=
                                                                  5
                                                              ? Icons.star
                                                              : Icons
                                                                  .star_outline,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  favoriteList3[index - 1].get(
                                                              'RakutanAverage') !=
                                                          '0'
                                                      ? favoriteList3[index - 1]
                                                          .get('RakutanAverage')
                                                          .toString()
                                                      : 'データなし',
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                  InkWell(
                                    onTap: () {
                                      if (favo![daigakuMei].contains(
                                          favoriteList3[index - 1].id)) {
                                        // 元々含んでいたら消す処理
                                        favo![daigakuMei].remove(
                                            favoriteList3[index - 1].id);
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(uid)
                                            .update({
                                          'favorite': favo,
                                        });
                                      } else {
                                        // 含んでいなかったら加える処理
                                        favo![daigakuMei]
                                            .add(favoriteList3[index - 1].id);
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(uid)
                                            .update({
                                          'favorite': favo,
                                        });
                                      }
                                      setState(() {});
                                    },
                                    child: favo![daigakuMei].contains(
                                            favoriteList3[index - 1].id)
                                        ? const Icon(
                                            Icons.bookmark_outlined,
                                            color: Colors.orange,
                                            size: 35,
                                          )
                                        : const Icon(
                                            Icons.bookmark_outline_rounded,
                                            color: Colors.black,
                                            size: 35,
                                          ),
                                  )
                                ],
                              ),
                            ),
                          );
                  }),
        ));
  }
}
