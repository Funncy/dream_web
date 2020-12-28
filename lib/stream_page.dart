import 'dart:convert';
import 'dart:math';
import 'dart:js' as js;
import 'dart:html' as html;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dream_web/components/button.dart';
import 'package:dream_web/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:speech_bubble/speech_bubble.dart';

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  var image;
  var image_url;
  var backgroundImage;
  var titleImage;
  var bibleImage;

  var image_num;
  @override
  void initState() {
    // TODO: implement initState

    backgroundImage = NetworkImage('assets/img/2_background.jpg');
    titleImage = Image.network('assets/img/2_title.png');
    bibleImage = Image.network('assets/img/2_bible.png');

    var rng_num = new Random().nextInt(112 - 1) + 1;
    image_num = rng_num.toString();
    if (rng_num < 10) {
      image_num = "0" + rng_num.toString();
    }

    print('image num = $image_num');

    // image = Image.network('assets/img/card_$image_num.jpeg');
    image = FutureBuilder(
        future: get('assets/img/card_$image_num.jpg'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return FlipCard(
                frontWidget: Container(
                  color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 80),
                        child: Container(
                          width: 280,
                          child: titleImage,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(width: 150, child: bibleImage),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text("말씀을 찾는 중입니다"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                backWidget: Image.memory(snapshot.data.bodyBytes),
              );
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 80),
                    child: Container(
                      width: 280,
                      child: titleImage,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(width: 150, child: bibleImage),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text("말씀을 찾는 중입니다"),
                      )
                    ],
                  )
                ],
              );
          }
          return null;
        });

    // image = CachedNetworkImage(
    //   imageUrl: 'assets/img/card_$image_num.jpeg',
    //   placeholder: (context, url) => Center(
    //     child: FlipCard(
    //       frontWidget: Container(
    //         color: Colors.green[200],
    //         child: Center(
    //           child: Text(
    //             "FRONT side.",
    //           ),
    //         ),
    //       ),
    //       backWidget: Container(
    //         color: Colors.yellow[200],
    //         child: Center(
    //           child: Text(
    //             "BACK side.",
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),

    //     Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Container(
    //         height: 100, width: 100, child: CircularProgressIndicator()),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 10),
    //       child: Text("말씀을 뽑는 중이에요~"),
    //     )
    //   ],
    // )),
    //   errorWidget: (context, url, error) => Icon(Icons.error),
    // );
    image_url = 'assets/img/card_$image_num.jpg';

    super.initState();
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
            child: FutureBuilder(
                future: get('assets/img/card_$image_num.jpg'),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 50, left: 50, right: 50, bottom: 10),
                            // color: Colors.white,
                            constraints:
                                BoxConstraints(maxWidth: 400, maxHeight: 669),
                            width: size.width * 0.8,
                            height: (size.width * 0.8) * 1.67,
                            child: FlipCard(
                              frontWidget: Container(
                                color: Colors.white.withOpacity(0.7),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, bottom: 80),
                                      child: Container(
                                        width: 280,
                                        child: titleImage,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 150, child: bibleImage),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text("말씀을 찾는 중입니다"),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              backWidget: Image.memory(snapshot.data.bodyBytes),
                            ),
                          ),
                          Buttons(
                            image_url: image_url,
                          )
                        ],
                      );
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 50, left: 50, right: 50, bottom: 10),
                            color: Colors.white.withOpacity(0.7),
                            constraints:
                                BoxConstraints(maxWidth: 400, maxHeight: 669),
                            width: size.width * 0.8,
                            height: (size.width * 0.8) * 1.67,
                            child: Container(
                              color: Colors.white.withOpacity(0.7),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, bottom: 80),
                                    child: Container(
                                      width: 280,
                                      child: titleImage,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(width: 150, child: bibleImage),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text("말씀을 찾는 중입니다"),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                  }
                  return null;
                })),
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
            height: 20,
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
            height: 20,
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
            height: 20,
          ),
        ),
      ],
    );
  }
}
