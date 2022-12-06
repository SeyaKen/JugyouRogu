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
  String? _hasBeenPressed;
  FocusNode _focus = FocusNode();
  bool keyboardIsOpened = false;

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

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  // この関数を使って、キーボードを消したり、現したりする？
  void _onFocusChange() {
    keyboardIsOpened = !keyboardIsOpened;
    print(keyboardIsOpened);
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
    _focus.addListener(_onFocusChange);
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

  // 上に引っ張った時の処理
  Future _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Container(
            height: MediaQuery.of(context).size.width * 0.097,
            width: MediaQuery.of(context).size.width * 0.95,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[300],
            ),
            child: TextField(
                focusNode: _focus,
                onChanged: (text) async {
                  dore = 1;
                  preForSearch = [];
                  if (text.length > 1) {
                    for (int i = 0; i < text.length - 1; i++) {
                      if (!preForSearch.contains(text.substring(i, i + 2))) {
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
                  fontSize: 15,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      size: 19,
                      color: Colors.black,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0,
                    ),
                    isDense: true,
                    border: InputBorder.none,
                    hintText: '授業名・教員名など(2文字以上)',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.grey,
                    ))),
          )),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.black),
            )),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: PopUpMen(
                    menuList: [
                      PopupMenuItem(
                        onTap: () async {
                          dore = 2;
                          searchAndNarabikaeStream = await DatabaseService()
                              .searchAndNarabikae(
                                  preForSearch, daigakuMei!, 'JuujituAverage');
                          setState(() {});
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: const Text("内容充実度順")),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                        onTap: () async {
                          dore = 2;
                          searchAndNarabikaeStream = await DatabaseService()
                              .searchAndNarabikae(
                                  preForSearch, daigakuMei!, 'RakutanAverage');
                          setState(() {});
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: const Text("楽単順")),
                      ),
                    ],
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Flexible(
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                        Flexible(
                          child: Text('並び順',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
                stream: dore == 0
                    ? jugyouListsStream
                    : dore == 1
                        ? searchStateStream
                        : searchAndNarabikaeStream,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Stack(
                          children: [
                            RefreshIndicator(
                              onRefresh: (() async {
                                _loadData();
                              }),
                              child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: snapshot.data!.docs.length + 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return index == 0
                                        ? SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                                    articleId: snapshot.data!
                                                        .docs[index - 1].id,
                                                    fromTag: 0,
                                                  ),
                                                  transitionDuration:
                                                      const Duration(
                                                          seconds: 0),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 13,
                                                      vertical: 8),
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
                                                          snapshot.data!.docs[
                                                              index - 1]['授業名'],
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 3),
                                                Row(
                                                  children: [
                                                    snapshot.data!.docs[index -
                                                                1]['学部'] !=
                                                            ''
                                                        ? const Text('学部:',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                            ))
                                                        : Container(),
                                                    snapshot.data!.docs[index -
                                                                1]['学部'] !=
                                                            ''
                                                        ? Text(
                                                            snapshot.data!.docs[
                                                                    index - 1]
                                                                ['学部'],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                            ))
                                                        : Container(),
                                                    snapshot.data!.docs[index -
                                                                1]['学部'] !=
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
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                            )),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              double.parse(snapshot
                                                                              .data!
                                                                              .docs[index - 1]
                                                                          [
                                                                          'JuujituAverage']) !=
                                                                      0.0
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_outline,
                                                              color:
                                                                  Colors.orange,
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              double.parse(snapshot.data!.docs[index - 1]['JuujituAverage']) >=
                                                                          1.5 &&
                                                                      double.parse(snapshot.data!.docs[index - 1][
                                                                              'JuujituAverage']) <
                                                                          2
                                                                  ? Icons
                                                                      .star_half_outlined
                                                                  : double.parse(snapshot.data!.docs[index - 1]
                                                                              [
                                                                              'JuujituAverage']) >=
                                                                          2
                                                                      ? Icons
                                                                          .star
                                                                      : Icons
                                                                          .star_outline,
                                                              color:
                                                                  Colors.orange,
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              double.parse(snapshot.data!.docs[index - 1]['JuujituAverage']) >=
                                                                          2.5 &&
                                                                      double.parse(snapshot.data!.docs[index - 1][
                                                                              'JuujituAverage']) <
                                                                          3
                                                                  ? Icons
                                                                      .star_half_outlined
                                                                  : double.parse(snapshot.data!.docs[index - 1]
                                                                              [
                                                                              'JuujituAverage']) >=
                                                                          3
                                                                      ? Icons
                                                                          .star
                                                                      : Icons
                                                                          .star_outline,
                                                              color:
                                                                  Colors.orange,
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              double.parse(snapshot.data!.docs[index - 1]['JuujituAverage']) >=
                                                                          3.5 &&
                                                                      double.parse(snapshot.data!.docs[index - 1][
                                                                              'JuujituAverage']) <
                                                                          4
                                                                  ? Icons
                                                                      .star_half_outlined
                                                                  : double.parse(snapshot.data!.docs[index - 1]
                                                                              [
                                                                              'JuujituAverage']) >=
                                                                          4
                                                                      ? Icons
                                                                          .star
                                                                      : Icons
                                                                          .star_outline,
                                                              color:
                                                                  Colors.orange,
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              double.parse(snapshot.data!.docs[index - 1]['JuujituAverage']) >=
                                                                          4.5 &&
                                                                      double.parse(snapshot.data!.docs[index - 1][
                                                                              'JuujituAverage']) <
                                                                          5
                                                                  ? Icons
                                                                      .star_half_outlined
                                                                  : double.parse(snapshot.data!.docs[index - 1]
                                                                              [
                                                                              'JuujituAverage']) >=
                                                                          5
                                                                      ? Icons
                                                                          .star
                                                                      : Icons
                                                                          .star_outline,
                                                              color:
                                                                  Colors.orange,
                                                              size: 20,
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          snapshot.data!.docs[
                                                                          index -
                                                                              1]
                                                                      [
                                                                      'JuujituAverage'] !=
                                                                  '0'
                                                              ? snapshot
                                                                  .data!
                                                                  .docs[index -
                                                                          1][
                                                                      'JuujituAverage']
                                                                  .toString()
                                                              : 'データなし',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
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
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                            )),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              double.parse(snapshot
                                                                              .data!
                                                                              .docs[index - 1]
                                                                          [
                                                                          'RakutanAverage']) !=
                                                                      0.0
                                                                  ? Icons.star
                                                                  : Icons
                                                                      .star_outline,
                                                              color:
                                                                  Colors.orange,
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              double.parse(snapshot.data!.docs[index - 1]['RakutanAverage']) >=
                                                                          1.5 &&
                                                                      double.parse(snapshot.data!.docs[index - 1][
                                                                              'RakutanAverage']) <
                                                                          2
                                                                  ? Icons
                                                                      .star_half_outlined
                                                                  : double.parse(snapshot.data!.docs[index - 1]
                                                                              [
                                                                              'RakutanAverage']) >=
                                                                          2
                                                                      ? Icons
                                                                          .star
                                                                      : Icons
                                                                          .star_outline,
                                                              color:
                                                                  Colors.orange,
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              double.parse(snapshot.data!.docs[index - 1]['RakutanAverage']) >=
                                                                          2.5 &&
                                                                      double.parse(snapshot.data!.docs[index - 1][
                                                                              'RakutanAverage']) <
                                                                          3
                                                                  ? Icons
                                                                      .star_half_outlined
                                                                  : double.parse(snapshot.data!.docs[index - 1]
                                                                              [
                                                                              'RakutanAverage']) >=
                                                                          3
                                                                      ? Icons
                                                                          .star
                                                                      : Icons
                                                                          .star_outline,
                                                              color:
                                                                  Colors.orange,
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              double.parse(snapshot.data!.docs[index - 1]['RakutanAverage']) >=
                                                                          3.5 &&
                                                                      double.parse(snapshot.data!.docs[index - 1][
                                                                              'RakutanAverage']) <
                                                                          4
                                                                  ? Icons
                                                                      .star_half_outlined
                                                                  : double.parse(snapshot.data!.docs[index - 1]
                                                                              [
                                                                              'RakutanAverage']) >=
                                                                          4
                                                                      ? Icons
                                                                          .star
                                                                      : Icons
                                                                          .star_outline,
                                                              color:
                                                                  Colors.orange,
                                                              size: 20,
                                                            ),
                                                            Icon(
                                                              double.parse(snapshot.data!.docs[index - 1]['RakutanAverage']) >=
                                                                          4.5 &&
                                                                      double.parse(snapshot.data!.docs[index - 1][
                                                                              'RakutanAverage']) <
                                                                          5
                                                                  ? Icons
                                                                      .star_half_outlined
                                                                  : double.parse(snapshot.data!.docs[index - 1]
                                                                              [
                                                                              'RakutanAverage']) >=
                                                                          5
                                                                      ? Icons
                                                                          .star
                                                                      : Icons
                                                                          .star_outline,
                                                              color:
                                                                  Colors.orange,
                                                              size: 20,
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          snapshot.data!.docs[
                                                                          index -
                                                                              1]
                                                                      [
                                                                      'RakutanAverage'] !=
                                                                  '0'
                                                              ? snapshot
                                                                  .data!
                                                                  .docs[index -
                                                                          1][
                                                                      'RakutanAverage']
                                                                  .toString()
                                                              : 'データなし',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
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
                            ),
                            keyboardIsOpened && dore == 0
                                ? InkWell(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  )
                                : Container()
                          ],
                        )
                      : const Center(child: CircularProgressIndicator());
                }),
          ),
        ],
      ),
      floatingActionButton: !keyboardIsOpened 
      ? ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
          color: Colors.black,
          width: 160,
          height: 55,
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
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      )))),
        ),
      ) : Container(),
    );
  }
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({super.key, required this.menuList, required this.icon});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}
