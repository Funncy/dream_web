import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:js' as js;
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui';

import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_web/components/button.dart';
import 'package:dream_web/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:speech_bubble/speech_bubble.dart';

import 'components/wating_card_widget.dart';

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  var image;
  var image_url;
  var backgroundImage;
  var titleImage;
  var bellImage;

  var image_num;

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    backgroundImage = NetworkImage('assets/img/background.png');
    titleImage = Image.network('assets/img/title_2.png');
    bellImage = Image.network('assets/img/bell.png');

    int cardNum = 155;

    var rng_num = new Random().nextInt(cardNum - 1) + 1;
    image_num = rng_num.toString();
    if (rng_num < 10) {
      // image_num = "0" + rng_num.toString();
    }

    print('image num = $image_num');

    image_url = 'assets/img/card/$image_num.jpg';

    print('image url = $image_url');
    super.initState();
  }

  Future<dynamic> _fetchData(var imageUrl) {
    return this._memoizer.runOnce(() async {
      return get(imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
          child: Center(
        child: Container(
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: backgroundImage, fit: BoxFit.cover)),
            // decoration: BoxDecoration(color: Colors.blueAccent),
            constraints:
                BoxConstraints(maxWidth: 450, minHeight: size.height + 100),
            child: Stack(
              children: [
                new BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
                FutureBuilder(
                    future: _fetchData('assets/img/card/$image_num.jpg'),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.done:
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 50, left: 50, right: 50, bottom: 10),
                                constraints: BoxConstraints(
                                    maxWidth: 400, maxHeight: 669),
                                width: size.width * 0.8,
                                height: (size.width * 0.8) * 1.67,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(15)),
                                child: FlipCard(
                                  frontWidget: WatingCardWidget(
                                      size: size,
                                      bellImage: bellImage,
                                      titleImage: titleImage),
                                  backWidget: Image.network(
                                    image_url,
                                    fit: BoxFit.cover,
                                    width: size.width * 0.8,
                                    height: (size.width * 0.8) * 1.67,
                                  ),
                                ),
                              ),
                              Buttons(
                                image_url: image_url,
                              )
                            ],
                          );
                        // case ConnectionState.done:
                        case ConnectionState.none:
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Container(
                            margin: const EdgeInsets.only(
                                top: 50, left: 50, right: 50, bottom: 10),
                            constraints:
                                BoxConstraints(maxWidth: 400, maxHeight: 669),
                            width: size.width * 0.8,
                            height: (size.width * 0.8) * 1.67,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(15)),
                            child: WatingCardWidget(
                                size: size,
                                bellImage: bellImage,
                                titleImage: titleImage),
                          );
                      }
                      return null;
                    }),
              ],
            )),
      )),
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
  void _saveImage(imageUrl) async {
    // var response = await get(imageUrl);
    // final DateTime now = DateTime.now();
    // print(now);
    // js.context.callMethod("webSaveAs", [
    //   html.Blob([response.bodyBytes]),
    //   "$now.jpg"
    // ]);

    // prepare

    // final blob = html.Blob([response.bodyBytes]);
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // final url = '/assets/img/card_01.jpeg';
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = imageUrl
      ..style.display = 'none';
    // ..download = '$now.jpg';
    html.document.body.children.add(anchor);

    // download
    anchor.click();

    // cleanup
    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: SpeechBubble(
              color: Color(0x3F2A1E).withOpacity(1),
              nipLocation: NipLocation.BOTTOM,
              borderRadius: 8,
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 250,
                child: Center(
                  child: Text(
                    "이미지가 뜨면 화면을 꾹 눌러주세요.\n 이미지 저장이 가능합니다.",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white.withOpacity(0.5)),
                  ),
                ),
              )),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Button(
            text: "이미지 저장하기",
            onPressed: () {
              _saveImage(widget.image_url);
            },
            width: 170,
            height: 25,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Button(
            text: "말씀 다시 뽑기",
            onPressed: () {
              Navigator.of(context).pop();
            },
            width: 170,
            height: 25,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          child: Button(
            text: "꿈의교회 유튜브 바로가기",
            onPressed: () async {
              // 꿈교 유튜브 보내기
              var youtubeUrl =
                  'https://www.youtube.com/channel/UCaNoaz05HCffa_61Jf_9Qng';

              final anchor =
                  html.document.createElement('a') as html.AnchorElement
                    ..href = youtubeUrl
                    ..style.display = 'none';
              // ..download = '$now.jpg';
              html.document.body.children.add(anchor);

              // download
              anchor.click();

              // cleanup
              html.document.body.children.remove(anchor);
              html.Url.revokeObjectUrl(youtubeUrl);
            },
            width: 170,
            height: 25,
          ),
        ),
      ],
    );
  }
}
