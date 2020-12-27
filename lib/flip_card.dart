import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  FlipCard({Key key, this.frontWidget, this.backWidget}) : super(key: key);

  final Widget frontWidget;
  final Widget backWidget;
  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  Timer _timer;
  var isLoading = false;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    startAni();
    super.initState();
  }

  void startAni() async {
    _timer = new Timer(const Duration(milliseconds: 1000), () {
      // print("startAni");
      controller.forward();
      // print('forward');
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: WidgetFlipper(
          controller: controller,
          frontWidget: widget.frontWidget,
          backWidget: widget.backWidget,
        ),
      ),
    );
  }
}

class WidgetFlipper extends StatefulWidget {
  WidgetFlipper({Key key, this.frontWidget, this.backWidget, this.controller})
      : super(key: key);

  final Widget frontWidget;
  final Widget backWidget;
  final AnimationController controller;

  @override
  _WidgetFlipperState createState() => _WidgetFlipperState();
}

class _WidgetFlipperState extends State<WidgetFlipper>
    with SingleTickerProviderStateMixin {
  Animation<double> _frontRotation;
  Animation<double> _backRotation;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();

    _frontRotation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
      ],
    ).animate(widget.controller);
    _backRotation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 50.0,
        ),
      ],
    ).animate(widget.controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedCard(
          animation: _backRotation,
          child: widget.backWidget,
        ),
        AnimatedCard(
          animation: _frontRotation,
          child: widget.frontWidget,
        ),
      ],
    );
  }
}

class AnimatedCard extends StatelessWidget {
  AnimatedCard({
    this.child,
    this.animation,
  });

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        var transform = Matrix4.identity();
        transform.setEntry(3, 2, 0.001);
        transform.rotateY(animation.value);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }
}
