import 'package:dream_web/components/button.dart';
import 'package:dream_web/next_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  var backgroundImage;
  var titleImage;
  var logoImage;

  @override
  void initState() {
    // TODO: implement initState
    backgroundImage = NetworkImage('assets/img/1_background.jpg');
    titleImage = Image.network('assets/img/1_title.png');
    logoImage = Image.network('assets/img/1_logo.png');
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
            constraints:
                BoxConstraints(maxWidth: 450, maxHeight: 900, minHeight: 550),
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: backgroundImage, fit: BoxFit.cover)),
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  margin: const EdgeInsets.only(top: 50),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        child: Container(width: 100, child: logoImage),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 200,
                          child: Column(
                            children: [
                              Container(width: 330, child: titleImage),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  '지인들과 함께 내게 주신 말씀을 나눠보세요!',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
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
        child: Button(
          onPressed: () {
            Navigator.push(
              context,
              _createRoute(),
            );
          },
          width: 170,
          height: 20,
          text: "새해 말씀 뽑기",
        ));
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
