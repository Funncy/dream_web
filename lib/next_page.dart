import 'dart:convert';
import 'dart:math';
import 'dart:js' as js;
import 'dart:html' as html;

import 'package:cached_network_image/cached_network_image.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    var rng_num = new Random().nextInt(5 - 1) + 1;
    var image_num = rng_num.toString();
    if (rng_num < 10) {
      image_num = "0" + rng_num.toString();
    }
    // image = Image.network('assets/img/card_$image_num.jpeg');
    image = FutureBuilder(
        future: get('assets/img/card_$image_num.jpeg'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return FlipCard(
                frontWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 10,
                        width: 100,
                        child: LinearProgressIndicator()),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text("말씀을 뽑는 중이에요~"),
                    )
                  ],
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
                  Container(
                      height: 10, width: 100, child: LinearProgressIndicator()),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text("말씀을 뽑는 중이에요~"),
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
    image_url = 'assets/img/card_$image_num.jpeg';

    super.initState();
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
                // decoration: BoxDecoration(color: Colors.blueAccent),
                constraints: BoxConstraints(
                  maxWidth: 450,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              top: 50, left: 50, right: 50, bottom: 10),
                          // color: Colors.white,
                          constraints:
                              BoxConstraints(maxWidth: 400, maxHeight: 669),
                          width: size.width * 0.8,
                          height: (size.width * 0.8) * 1.67,
                          child: image),
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
  void _saveImage(imageUrl) async {
    var response = await get(imageUrl);
    final DateTime now = DateTime.now();
    print(now);
    // js.context.callMethod("webSaveAs", [
    //   html.Blob([response.bodyBytes]),
    //   "$now.jpg"
    // ]);

    // prepare

    final blob = html.Blob([response.bodyBytes]);
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
                ))),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: SpeechBubble(
              color: Colors.amber,
              nipLocation: NipLocation.TOP,
              child: Container(
                child: Text("이미지가 뜨면 화면을 꾹 눌러주세요. 이미지 저장이 가능합니다."),
              )),
        )
      ],
    );
  }
}
