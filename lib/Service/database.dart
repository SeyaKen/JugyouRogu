import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DatabaseService extends ChangeNotifier {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  File? imageFile;
  Image? imgs;

  // Favorite一覧をうつす関数
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>?> favoriteDataCollect(
      favo, String daigakuMei) async {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(daigakuMei);
    for (var i = 0; i < favo.length; i++) {
      try {
        query = query.where('id', isEqualTo: favo[i]);
      } catch (e) {
        print(e.toString());
      }
      if (i == favo.length - 1) {
        return query.snapshots();
      }
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> dataCollect(String daigakuMei) {
    return FirebaseFirestore.instance
        .collection(daigakuMei)
        .orderBy('Daytime', descending: true)
        .limit(50)
        .snapshots();
  }

  // 口コミ一覧をうつす関数
  Stream<QuerySnapshot<Map<String, dynamic>>> kutikomiCollect(
      String articleId, daigakuMei) {
    return FirebaseFirestore.instance
        .collection(daigakuMei)
        .doc(articleId)
        .collection('reviews')
        .orderBy('Daytime', descending: true)
        .limit(50)
        .snapshots();
  }

  // 追加の質問一欄？をうつす関数
  Future<Stream<QuerySnapshot>> fetchAdditionalData(
      int suuji, String Daigakumei) async {
    return FirebaseFirestore.instance
        .collection(Daigakumei)
        .orderBy('Daytime', descending: true)
        .limit(suuji)
        .snapshots();
  }

  // 検索した質問一覧をうつす関数
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>?> searchDataCollect(
      searchWordsList, String daigakuMei) async {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(daigakuMei);
    for (var i = 0; i < searchWordsList.length; i++) {
      try {
        query =
            query.where('forSearchList.${searchWordsList[i]}', isEqualTo: true);
      } catch (e) {
        print(e.toString());
      }
      if (i == searchWordsList.length - 1) {
        return query.snapshots();
      }
    }

    return null;
  }

  // 検索してかつ、並び替えをした関数
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>?> searchAndNarabikae(
      searchWordsList, String daigakuMei, Jouken) async {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(daigakuMei);
    if (searchWordsList.length <= 1) {
      query = query.orderBy(Jouken, descending: true);
      return query.snapshots();
    } else {
      for (var i = 0; i < searchWordsList.length; i++) {
        try {
          query = query
              .where('forSearchList.${searchWordsList[i]}', isEqualTo: true)
              .orderBy(Jouken, descending: true);
        } catch (e) {
          print(e.toString());
        }
        if (i == searchWordsList.length - 1) {
          return query.snapshots();
        }
      }
    }

    return null;
  }

  // 追加の答えを持ってくる関数
  Future<Stream<QuerySnapshot>> additionalPersonalJugyou(
      int personalJugyouSuuji) async {
    return FirebaseFirestore.instance
        .collection('jugyou')
        .orderBy('Daytime', descending: true)
        .where('asker', isEqualTo: uid)
        .limit(personalJugyouSuuji)
        .snapshots();
  }

  // 追加の答えを持ってくる関数
  Future<Stream<QuerySnapshot>> additionalPersonalAnswers(
      int personalSuuji) async {
    return FirebaseFirestore.instance
        .collection('jugyou')
        .orderBy('Daytime', descending: true)
        .where('answersList', arrayContains: uid)
        .limit(personalSuuji)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> fetchImage() async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Future updateUserName(String name) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'name': name,
    });
  }

  Future updateUserEx(String ex) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'selfIntroduction': ex,
    });
  }

  Future updateUserDaigaku(String daigaku) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'daigaku': daigaku,
    });
  }

  // 質問画面の画像を載せる処理
  Future updateQuestionImage() async {
    await showImagePicker();
    return await uploadQuestionFile();
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<String> uploadQuestionFile() async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child(uid).child(getRandomString(15));

    try {
      final snapshot = await ref.putFile(
        imageFile!,
      );
      final urlDownload = await snapshot.ref.getDownloadURL();

      return urlDownload;
    } catch (e) {
      print(e.toString());
      return '';
    }
  }
  // 質問画面の画像を載せる処理

  Future updateImage() async {
    await showImagePicker();
    await addImage();
    notifyListeners();
  }

  Future showImagePicker() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      imageFile = File(pickedFile!.path);
      notifyListeners();
      return imageFile;
    } catch (e) {
      print(e);
      imageFile = null;
      notifyListeners();
    }
  }

  // ファイルをアップロードする関数
  Future<String> uploadFile() async {
    if (imageFile == null) {
      return '';
    } else {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child(uid).child('ProfilePicture');

      final snapshot = await ref.putFile(
        imageFile!,
      );

      final urlDownload = await snapshot.ref.getDownloadURL();

      return urlDownload;
    }
  }

  Future addImage() async {
    final ProfilePicture = await uploadFile();

    if (ProfilePicture != '') {
      // firebaseに追加
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'ProfilePicture': ProfilePicture,
      });
      fetchImage();
    }
  }

  Future profilePictureUpdate(DocumentSnapshot<Object?>? ds) async {
    if (ds!['ProfilePicture'] != '') {
      await FirebaseStorage.instance.refFromURL(ds['ProfilePicture']).delete();
    }
    showImagePicker().then((valu) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({"ProfilePicture": ds['ProfilePicture']});
    });
  }

  // 授業の重複がないか確認する関数
  Query<Map<String, dynamic>> ChouhukuKakunin(
      jugyoumei, kyoujumei, daigakuMei) {
    return FirebaseFirestore.instance
        .collection(daigakuMei)
        .orderBy('Daytime', descending: true)
        .where('授業名', isEqualTo: jugyoumei)
        .where('教授・講師名', isEqualTo: kyoujumei);
  }
}
