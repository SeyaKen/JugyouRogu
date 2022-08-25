import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jugyourogu/Service/database.dart';
import 'package:jugyourogu/main_page.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final _formKey = GlobalKey<FormState>();
  double _kItemExtent = 32.0;
  var forSearchList = {};
  var allString = '';
  String uid = FirebaseAuth.instance.currentUser!.uid;

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 200,
              padding: const EdgeInsets.only(top: 0),
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                ClassName1 = null;
                ClassName2 = null;
                ClassName0 = null;
                ClassName1 = null;
                ClassName2 = null;
                ClassName3 = null;
                ClassName4 = null;
                txt0.text = '';
                txt1.text = '';
                txt2.text = '';
              },
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 30,
                color: Colors.black,
              ),
            ),
            const Text('授業を作成',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
            const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30,
              color: Colors.transparent,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: title_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Text(
                                  title_list[index],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                index == 0 || index == 1 
                                ? const SizedBox(
                                  width: 5,
                                ): Container(),
                                index == 0 || index == 1 ? const Text(
                                  '※必須',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ) : Container(),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            index == 0 || index == 1
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        validator: (val) => val!.isEmpty
                                            ? '正確に${title_value[index]}を入力してください。'
                                            : null,
                                        onChanged: (val) {
                                          setState(() => index == 0
                                              ? ClassName0 = val
                                              : index == 1
                                                  ? ClassName1 = val
                                                  : ClassName2 = val);
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Colors.grey[300],
                                          filled: true,
                                          hintText: title_list[index],
                                          hintStyle: const TextStyle(
                                              color: Colors.grey),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 13),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : index != 2
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: TextFormField(
                                            controller:
                                                index == 3 ? txt0 : txt1,
                                            onTap: () {
                                              index == 3
                                                  ? txt0.text = ''
                                                  : txt1.text = '';
                                              _showDialog(
                                                CupertinoPicker(
                                                  magnification: 1.22,
                                                  squeeze: 1.2,
                                                  useMagnifier: true,
                                                  itemExtent: _kItemExtent,
                                                  onSelectedItemChanged:
                                                      (int selectedItem) {
                                                    setState(() {
                                                      index == 3
                                                          ? ClassName3 = youbi[
                                                              selectedItem]
                                                          : ClassName4 = youbi[
                                                              selectedItem];
                                                      index == 3
                                                          ? txt0.text = youbi[
                                                              selectedItem]
                                                          : txt1.text = youbi[
                                                              selectedItem];
                                                    });
                                                  },
                                                  children:
                                                      List<Widget>.generate(
                                                          youbi.length,
                                                          (int indexx) {
                                                    return Center(
                                                      child: Text(
                                                        youbi[indexx],
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              );
                                            },
                                            readOnly: true,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            validator: (val) => val!.isEmpty
                                                ? '正確に${title_value[index]}を入力してください。'
                                                : null,
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey[300],
                                              filled: true,
                                              hintText: title_list[index],
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 13),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ))
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          child: TextFormField(
                                            controller: txt2,
                                            onTap: () {
                                              txt2.text = '';
                                              _showDialog(
                                                CupertinoPicker(
                                                  magnification: 1.22,
                                                  squeeze: 1.2,
                                                  useMagnifier: true,
                                                  itemExtent: _kItemExtent,
                                                  onSelectedItemChanged:
                                                      (int selectedItem) {
                                                    setState(() {
                                                      ClassName2 =
                                                          gakubu[selectedItem];
                                                      txt2.text =
                                                          gakubu[selectedItem];
                                                    });
                                                  },
                                                  children:
                                                      List<Widget>.generate(
                                                          gakubu.length,
                                                          (int indexxx) {
                                                    return Center(
                                                      child: Text(
                                                        gakubu[indexxx],
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              );
                                            },
                                            readOnly: true,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            validator: (val) => val!.isEmpty
                                                ? '正確に${title_value[index]}を入力してください。'
                                                : null,
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey[300],
                                              filled: true,
                                              hintText: title_list[index],
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 13),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        )),
                          ]);
                    }),
              )),
        ),
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
          color: ClassName0 != null &&
                  ClassName1 != null &&
                  ClassName0 != '' &&
                  ClassName1 != ''
              ? Colors.orange
              : Colors.orange.withOpacity(0.5),
          width: MediaQuery.of(context).size.width * 0.95,
          height: 50,
          child: InkWell(
              onTap: () async {
                var dataLengthsource = DatabaseService(uid).ChouhukuKakunin(
                    ClassName0, ClassName1!.replaceAll(RegExp(r'\s'), ''));
                var querySnapshot = await dataLengthsource.get();
                var totalEquals = querySnapshot.docs.length;
                allString =
                    '$ClassName0$ClassName1$ClassName2$ClassName3$ClassName4';
                if (ClassName0 != null &&
                    ClassName1 != null &&
                    ClassName0 != '' &&
                    ClassName1 != '') {
                  // 授業が重複していない場合
                  if (totalEquals == 0) {
                    for (int i = 0; i < allString.length - 1; i++) {
                      forSearchList[allString.substring(i, i + 2)] = true;
                      if (i == allString.length - 2) {
                        // 全ての処理が終わったら、データベースに格納する関数。
                        FirebaseFirestore.instance
                            .collection('classes')
                            .doc()
                            .set({
                          '授業名': ClassName0 ?? '',
                          '教授・講師名':
                              ClassName1?.replaceAll(RegExp(r'\s'), '') ?? '',
                          '学部': ClassName2 ?? '',
                          '曜日・時限1': ClassName3 ?? '',
                          '曜日・時限2': ClassName4 ?? '',
                          'JuujituAverage': '0',
                          'RakutanAverage': '0',
                          'Daytime': DateTime.now(),
                          'forSearchList': forSearchList,
                        });
                        ClassName0 = null;
                        ClassName1 = null;
                        ClassName2 = null;
                        ClassName3 = null;
                        ClassName4 = null;
                        txt0.text = '';
                        txt1.text = '';
                        txt2.text = '';
                        forSearchList = {};
                        allString = '';
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  MainPage(currenttab: 0),
                              transitionDuration: const Duration(seconds: 0),
                            ));
                      }
                    }
                  } else {
                    // 授業が元々入っている場合のアラート？
                    // ここで授業名を追加してくださいの警告？を出す
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text('この授業は既に存在します'),
                          content: const Text('ホーム画面から検索してください'),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('閉じる'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              child: const Center(
                  child: Text('授業を作成する',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white,
                      )))),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

var txt0 = TextEditingController();
var txt1 = TextEditingController();
var txt2 = TextEditingController();

List title_list = [
  '授業名',
  '教授・講師名',
  '学部',
  '曜日・時限1',
  '曜日・時限2',
];

String? ClassName0;
String? ClassName1;
String? ClassName2;
String? ClassName3;
String? ClassName4;

List title_value = [
  ClassName0,
  ClassName1,
  ClassName2,
  ClassName3,
  ClassName4,
];

List gakubu = [
  '法学部',
  '経済学部',
  '商学部',
  '文学部',
  '総合政策学部',
  '国際経営学部',
  '国際情報学部',
  '理工学部',
];

List youbi = [
  '月1',
  '月2',
  '月3',
  '月4',
  '月5',
  '月6',
  '火1',
  '火2',
  '火3',
  '火4',
  '火5',
  '火6',
  '水1',
  '水2',
  '水3',
  '水4',
  '水5',
  '水6',
  '木1',
  '木2',
  '木3',
  '木4',
  '木5',
  '木6',
  '金1',
  '金2',
  '金3',
  '金4',
  '金5',
  '金6',
  '土1',
  '土2',
  '土3',
  '土4',
  '土5',
  '土6',
];
