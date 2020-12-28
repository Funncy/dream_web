import 'package:dream_web/first_page.dart';
import 'package:dream_web/flip_card.dart';
import 'package:dream_web/next_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// TODO: 카카오톡 링크 연결
// TODO : 이미지 저장 문구 추가
// TODO : 말씀카드 리사이징

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}
