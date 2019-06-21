import 'package:flutter/material.dart';

/// Our custom fork of https://pub.dev/packages/modal_progress_hud adding a fading effect
///
/// wrapper around any widget that makes an async call to show a modal progress
/// indicator while the async call is in progress.
///
/// The progress indicator can be turned on or off using [isLoading]
///
/// The progress indicator defaults to a [CircularProgressIndicator] but can be
/// any kind of widget
///
/// The color of the modal barrier can be set using [color]
///
/// The opacity of the modal barrier can be set using [opacity]
///
/// HUD=Heads Up Display
///
class LoadingView extends StatefulWidget {
  final bool isLoading;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Widget child;

  LoadingView({
    @required this.isLoading,
    @required this.child,
    this.opacity = 0.5,
    this.progressIndicator = const CircularProgressIndicator(),
    this.color,
  });

  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  bool showBackgroundView;

  _LoadingViewState();

  @override
  void initState() {
    super.initState();
    showBackgroundView = false;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      // ignore: unnecessary_statements
      status == AnimationStatus.forward
          ? setState(() => {showBackgroundView = true})
          : null;
      // ignore: unnecessary_statements
      status == AnimationStatus.dismissed
          ? setState(() => {showBackgroundView = false})
          : null;
    });
  }

  @override
  void didUpdateWidget(LoadingView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    widgets.add(widget.child);

    if (showBackgroundView == true) {
      final modal = FadeTransition(
        opacity: _animation,
        child: Stack(
          children: <Widget>[
            Opacity(
              child: ModalBarrier(
                dismissible: false,
                color: widget.color ?? Colors.black54,
              ),
              opacity: widget.opacity,
            ),
            Center(child: widget.progressIndicator),
          ],
        ),
      );
      widgets.add(modal);
    }

    return Stack(children: widgets);
  }
}

enum Indicator {
  defaultIndicator,
}

const Map<Indicator, Widget> IndicatorMap = {
  Indicator.defaultIndicator: CircularProgressIndicator(),
};
