import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jugyourogu/main_page.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final _formKey = GlobalKey<FormState>();
  String? ClassName0;
  double _kItemExtent = 32.0;

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 250,
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
      backgroundColor: const Color(0xff131313),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text('授業を作成',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.transparent,
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
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            index == 0 || index == 1 || index == 2
                                ? SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      validator: (val) => val!.isEmpty
                                          ? '正確に${title_value[index]}を入力してください。'
                                          : null,
                                      onChanged: (val) {
                                        setState(
                                            () => title_value[index] = val);
                                      },
                                      decoration: InputDecoration(
                                        fillColor: const Color(0xff333333),
                                        filled: true,
                                        hintText: title_list[index],
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 13),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.9,
                                  
                                  child: TextFormField(
                                    onTap: () {
                                      _showDialog(
                                        CupertinoPicker(
                                          magnification: 1.22,
                                          squeeze: 1.2,
                                          useMagnifier: true,
                                          itemExtent: _kItemExtent,
                                          // This is called when selected item is changed.
                                          onSelectedItemChanged:
                                              (int selectedItem) {
                                            setState(() {
                                              title_list[index] = selectedItem;
                                            });
                                          },
                                          children: List<Widget>.generate(
                                              title_list[index].length,
                                              (int indexx) {
                                            return Center(
                                              child: Text(
                                                title_list[index][indexx],
                                              ),
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                    readOnly: true,
                                    style: const TextStyle(
                                        color: Colors.white),
                                    validator: (val) => val!.isEmpty
                                        ? '正確に${title_value[index]}を入力してください。'
                                        : null,
                                    onChanged: (val) {
                                      setState(
                                          () => title_value[index] = val);
                                    },
                                    decoration: InputDecoration(
                                      fillColor: const Color(0xff333333),
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
                                )
                          ]);
                    }),
              )),
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
                        fontSize: 17,
                      )))),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

List title_list = [
  '授業名',
  '教授/講師名',
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
