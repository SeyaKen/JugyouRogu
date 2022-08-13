import 'package:flutter/material.dart';
import 'package:jugyourogu/main_page.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final _formKey = GlobalKey<FormState>();
  String? ClassName;

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
                child: Column(
                  children: [
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: const [
                          Text(
                            '授業名',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          validator: (val) => val!.isEmpty ? '' : null,
                          onChanged: (val) {
                            setState(() => ClassName = val);
                          },
                          decoration: const InputDecoration(
                            fillColor: Color(0xff333333),
                            filled: true,
                            hintText: '授業名',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 13),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            )),
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
