import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(
      {@required this.onPressed,
      @required this.width,
      @required this.height,
      @required this.text});

  final Function onPressed;
  final double width;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.white.withOpacity(0.5), width: 1)),
        onPressed: onPressed,
        color: Color(0xB5B5B3).withAlpha(70),
        child: Padding(
            padding: const EdgeInsets.all(13),
            child: Container(
              width: width,
              height: height,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            )));
  }
}
