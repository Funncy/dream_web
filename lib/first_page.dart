import 'package:dream_web/next_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var lightImage;
  var titleImage;
  var logoImage;

  @override
  void initState() {
    // TODO: implement initState
    lightImage = Image.network('assets/img/main_light.png');
    titleImage = Image.network('assets/img/title.png');
    logoImage = Image.network('assets/img/dream_logo.jpg');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          constraints:
              BoxConstraints(maxWidth: 450, maxHeight: 900, minHeight: 550),
          decoration: BoxDecoration(color: Colors.amber),
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 400,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Container(width: 300, child: logoImage),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: lightImage,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        height: 200,
                        child: Column(
                          children: [
                            Container(width: 200, child: titleImage),
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
                  ],
                ),
              ),
              Center(child: BottomButton())
            ],
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            )));
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
