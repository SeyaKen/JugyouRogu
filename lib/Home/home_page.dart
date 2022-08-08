import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            margin: const EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.95,
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xff333333),
            ),
            child: TextField(
                onChanged: (text) async {},
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
}
