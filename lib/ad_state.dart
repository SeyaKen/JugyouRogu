import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get bannerAdUnitId => Platform.isAndroid
    // テストモード
    // ? 'ca-app-pub-3940256099942544/2934735716'
    // : 'ca-app-pub-3940256099942544/2934735716';

    // 本番モード
    ? 'ca-app-pub-2820998332028532/3385090245'
    : 'ca-app-pub-2820998332028532/2526469998';
}