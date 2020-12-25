import 'package:dream_web/next_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// TODO: 이미지 로드 확인
// TODO: 반응형 이미지 조절 (스크롤 되도록)
// TODO: 이미지 다운로드
// TODO: FireStore 연결
// TODO: 카카오톡 링크 연결

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainBody(),
    );
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 450,
              ),
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [TopBody(), BottomBody()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBody extends StatelessWidget {
  const BottomBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(top: 70),
      color: Colors.cyan,
      child: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      _createRoute(),
                    );
                  },
                  color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Container(
                      width: 230,
                      height: 25,
                      child: Center(
                        child: Text(
                          "랜덤 말씀 뽑기",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ))),
        ),
      ]),
    );
  }
}

class TopBody extends StatelessWidget {
  const TopBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 538,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: Image.network('assets/img/main_light.png'),
              ),
              Container(
                alignment: Alignment.center,
                child: Container(
                  height: 230,
                  child: Column(
                    children: [
                      Container(
                          width: 200,
                          child: Image.network('assets/img/title.png')),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          '지인들과 함께 내게 주신 말씀을 나눠보세요!',
                          style: TextStyle(fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: 300,
                    child: Image.network('assets/img/main_desk.png')),
              )
            ],
          ),
        ),
      ],
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => NextPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
