import 'dart:math';
import 'dart:js' as js;
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  var image;
  var image_url;
  @override
  void initState() {
    // TODO: implement initState
    var rng_num = new Random().nextInt(5);
    var image_num = rng_num.toString();
    if (rng_num < 10) {
      image_num = "0" + rng_num.toString();
    }
    image = Image.network('assets/img/card_$image_num.jpeg');
    image_url = 'assets/img/card_$image_num.jpeg';
    // image =
    //     Image.network('https://dream-web-97613.web.app/assets/img/card_1.jpeg');

    super.initState();
  }

  void _saveImage(url) async {
    var response = await get(url);
    print(response);
  }

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
                      image,
                      // 카카오톡 공유하기
                      // 다시 뽑기
                      // 이미지 저장하기
                      Buttons(
                        image_url: image_url,
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

class Buttons extends StatefulWidget {
  final String image_url;

  const Buttons({Key key, @required this.image_url}) : super(key: key);

  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  void _saveImage(url) async {
    var response = await get(url);
    final DateTime now = DateTime.now();
    print(now);
    js.context.callMethod("webSaveAs", [
      html.Blob([response.bodyBytes]),
      "$now.jpg"
    ]);
  }

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
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () async {
                  _saveImage(widget.image_url);
                },
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
