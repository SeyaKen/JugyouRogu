
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jugyourogu/Home/home_detail.dart';

class favoriteListScreen extends StatefulWidget {
  const favoriteListScreen({super.key});

  @override
  State<favoriteListScreen> createState() => _favoriteListScreenState();
}

class _favoriteListScreenState extends State<favoriteListScreen> {
  final ScrollController _scrollController = ScrollController();
  BannerAd? banner;
  Stream<QuerySnapshot<Object?>>? favoriteListStream;

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
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
                stream: favoriteListStream,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Stack(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                controller: _scrollController,
                                itemCount: snapshot.data!.docs.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return index == 0
                                      ? SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                                pageBuilder: (_, __, ___) =>
                                                    HomeDetail(
                                                  articleId: snapshot
                                                      .data!.docs[index - 1].id,
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
                                              top: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.black),
                                            )),
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                        snapshot.data!
                                                                .docs[index - 1]
                                                            ['授業名'],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 3),
                                              Row(
                                                children: [
                                                  snapshot.data!.docs[index - 1]
                                                              ['学部'] !=
                                                          ''
                                                      ? const Text('学部:',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                          ))
                                                      : Container(),
                                                  snapshot.data!.docs[index - 1]
                                                              ['学部'] !=
                                                          ''
                                                      ? Text(
                                                          snapshot.data!.docs[
                                                              index - 1]['学部'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                          ))
                                                      : Container(),
                                                  snapshot.data!.docs[index - 1]
                                                              ['学部'] !=
                                                          ''
                                                      ? const SizedBox(
                                                          width: 10,
                                                        )
                                                      : Container(),
                                                  const Text('教授:',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  Text(
                                                      snapshot.data!
                                                              .docs[index - 1]
                                                          ['教授・講師名'],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      )),
                                                ],
                                              ),
                                              Column(
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
                                                            double.parse(snapshot
                                                                            .data!
                                                                            .docs[
                                                                        index -
                                                                            1]['JuujituAverage']) !=
                                                                    0.0
                                                                ? Icons.star
                                                                : Icons.star_outline,
                                                            color:
                                                                Colors.orange,
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            double.parse(snapshot.data!.docs[index - 1][
                                                                            'JuujituAverage']) >=
                                                                        1.5 &&
                                                                    double.parse(snapshot.data!.docs[index - 1]
                                                                            [
                                                                            'JuujituAverage']) <
                                                                        2
                                                                ? Icons
                                                                    .star_half_outlined
                                                                : double.parse(snapshot
                                                                            .data!
                                                                            .docs[index - 1]['JuujituAverage']) >=
                                                                        2
                                                                    ? Icons.star
                                                                    : Icons.star_outline,
                                                            color:
                                                                Colors.orange,
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            double.parse(snapshot.data!.docs[index - 1][
                                                                            'JuujituAverage']) >=
                                                                        2.5 &&
                                                                    double.parse(snapshot.data!.docs[index - 1]
                                                                            [
                                                                            'JuujituAverage']) <
                                                                        3
                                                                ? Icons
                                                                    .star_half_outlined
                                                                : double.parse(snapshot
                                                                            .data!
                                                                            .docs[index - 1]['JuujituAverage']) >=
                                                                        3
                                                                    ? Icons.star
                                                                    : Icons.star_outline,
                                                            color:
                                                                Colors.orange,
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            double.parse(snapshot.data!.docs[index - 1][
                                                                            'JuujituAverage']) >=
                                                                        3.5 &&
                                                                    double.parse(snapshot.data!.docs[index - 1]
                                                                            [
                                                                            'JuujituAverage']) <
                                                                        4
                                                                ? Icons
                                                                    .star_half_outlined
                                                                : double.parse(snapshot
                                                                            .data!
                                                                            .docs[index - 1]['JuujituAverage']) >=
                                                                        4
                                                                    ? Icons.star
                                                                    : Icons.star_outline,
                                                            color:
                                                                Colors.orange,
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            double.parse(snapshot.data!.docs[index - 1][
                                                                            'JuujituAverage']) >=
                                                                        4.5 &&
                                                                    double.parse(snapshot.data!.docs[index - 1]
                                                                            [
                                                                            'JuujituAverage']) <
                                                                        5
                                                                ? Icons
                                                                    .star_half_outlined
                                                                : double.parse(snapshot
                                                                            .data!
                                                                            .docs[index - 1]['JuujituAverage']) >=
                                                                        5
                                                                    ? Icons.star
                                                                    : Icons.star_outline,
                                                            color:
                                                                Colors.orange,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        snapshot.data!.docs[
                                                                        index -
                                                                            1][
                                                                    'JuujituAverage'] !=
                                                                '0'
                                                            ? snapshot
                                                                .data!
                                                                .docs[index - 1]
                                                                    [
                                                                    'JuujituAverage']
                                                                .toString()
                                                            : 'データなし',
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
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
                                                            fontSize: 12,
                                                          )),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            double.parse(snapshot
                                                                            .data!
                                                                            .docs[
                                                                        index -
                                                                            1]['RakutanAverage']) !=
                                                                    0.0
                                                                ? Icons.star
                                                                : Icons.star_outline,
                                                            color:
                                                                Colors.orange,
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            double.parse(snapshot.data!.docs[index - 1][
                                                                            'RakutanAverage']) >=
                                                                        1.5 &&
                                                                    double.parse(snapshot.data!.docs[index - 1]
                                                                            [
                                                                            'RakutanAverage']) <
                                                                        2
                                                                ? Icons
                                                                    .star_half_outlined
                                                                : double.parse(snapshot
                                                                            .data!
                                                                            .docs[index - 1]['RakutanAverage']) >=
                                                                        2
                                                                    ? Icons.star
                                                                    : Icons.star_outline,
                                                            color:
                                                                Colors.orange,
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            double.parse(snapshot.data!.docs[index - 1][
                                                                            'RakutanAverage']) >=
                                                                        2.5 &&
                                                                    double.parse(snapshot.data!.docs[index - 1]
                                                                            [
                                                                            'RakutanAverage']) <
                                                                        3
                                                                ? Icons
                                                                    .star_half_outlined
                                                                : double.parse(snapshot
                                                                            .data!
                                                                            .docs[index - 1]['RakutanAverage']) >=
                                                                        3
                                                                    ? Icons.star
                                                                    : Icons.star_outline,
                                                            color:
                                                                Colors.orange,
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            double.parse(snapshot.data!.docs[index - 1][
                                                                            'RakutanAverage']) >=
                                                                        3.5 &&
                                                                    double.parse(snapshot.data!.docs[index - 1]
                                                                            [
                                                                            'RakutanAverage']) <
                                                                        4
                                                                ? Icons
                                                                    .star_half_outlined
                                                                : double.parse(snapshot
                                                                            .data!
                                                                            .docs[index - 1]['RakutanAverage']) >=
                                                                        4
                                                                    ? Icons.star
                                                                    : Icons.star_outline,
                                                            color:
                                                                Colors.orange,
                                                            size: 20,
                                                          ),
                                                          Icon(
                                                            double.parse(snapshot.data!.docs[index - 1][
                                                                            'RakutanAverage']) >=
                                                                        4.5 &&
                                                                    double.parse(snapshot.data!.docs[index - 1]
                                                                            [
                                                                            'RakutanAverage']) <
                                                                        5
                                                                ? Icons
                                                                    .star_half_outlined
                                                                : double.parse(snapshot
                                                                            .data!
                                                                            .docs[index - 1]['RakutanAverage']) >=
                                                                        5
                                                                    ? Icons.star
                                                                    : Icons.star_outline,
                                                            color:
                                                                Colors.orange,
                                                            size: 20,
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        snapshot.data!.docs[
                                                                        index -
                                                                            1][
                                                                    'RakutanAverage'] !=
                                                                '0'
                                                            ? snapshot
                                                                .data!
                                                                .docs[index - 1]
                                                                    [
                                                                    'RakutanAverage']
                                                                .toString()
                                                            : 'データなし',
                                                        style: const TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ]),
                                          ),
                                        );
                                }),
                          ],
                        )
                      : const Center(child: CircularProgressIndicator());
                });
  }
}