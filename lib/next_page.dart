import 'dart:io';

import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(color: Colors.blueAccent),
                constraints: BoxConstraints(
                  maxWidth: 450,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network('assets/img/card_1.jpeg'),
                      // 카카오톡 공유하기
                      // 다시 뽑기
                      // 이미지 저장하기
                      Buttons()
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 20),
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {},
                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Container(
                    width: 230,
                    height: 25,
                    child: Center(
                      child: Text(
                        "카카오톡 공유하기",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ))),
        Container(
            margin: const EdgeInsets.only(top: 20),
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Container(
                    width: 230,
                    height: 25,
                    child: Center(
                      child: Text(
                        "다시 뽑기",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ))),
        Container(
            margin: const EdgeInsets.only(top: 20),
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {},
                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Container(
                    width: 230,
                    height: 25,
                    child: Center(
                      child: Text(
                        "이미지 저장하기",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                )))
      ],
    );
  }
}
