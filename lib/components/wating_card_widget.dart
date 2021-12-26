import 'package:flutter/material.dart';

class WatingCardWidget extends StatelessWidget {
  WatingCardWidget({
    Key key,
    @required this.size,
    @required this.bellImage,
    @required this.titleImage,
  }) : super(key: key);

  final Size size;
  var bellImage;
  var titleImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      height: (size.width * 0.8) * 1.67,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: Container(
                  width: 80,
                  child: bellImage,
                ),
              ),
              Container(
                width: 270,
                height: 2,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30)),
              ),
              SizedBox(
                height: 30,
              ),
              Container(width: 200, child: titleImage),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "말씀을 찾는 중입니다...",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                    width: 180,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff33311f)),
                    child: Center(
                      child: Text(
                        "AMEN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ))),
          )
        ],
      ),
    );
  }
}
