import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_loading_view/simple_loading_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Loading(),
      );
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool isLoading = false;
  Widget indicatorWidget = IndicatorMap[Indicator.defaultIndicator];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingView(
          isLoading: isLoading,
          progressIndicator: indicatorWidget,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                child: const Text('Default', semanticsLabel: 'Default'),
                onPressed: () {
                  indicatorWidget = IndicatorMap[Indicator.defaultIndicator];
                  // Perform some action
                  setState(() {
                    isLoading = true;
                  });
                  closeIndicator();
                },
              ),
              OutlineButton(
                  child: const Text('Custom', semanticsLabel: 'Custom'),
                  onPressed: () {
                    indicatorWidget = new BounceWidget();
                    setState(() {
                      isLoading = true;
                    });
                    closeIndicator();
                  })
            ],
          )),
    );
  }

  // this is for just testing purpose. You can change the value of isLoading can make the indicator hide.
  void closeIndicator() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
        indicatorWidget = null;
      });
    });
  }
}

class BounceWidget extends StatelessWidget {
  const BounceWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BounceAnimation();
  }
}

class BounceAnimation extends StatefulWidget {
  @override
  _BounceAnimationState createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1 - _animationController.value;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: CircleAvatar(
            backgroundColor: Colors.red,
          ),
        ));
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }
}
