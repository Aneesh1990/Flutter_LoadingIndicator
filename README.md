
# loading_view_example

A simple widget wrapper to enable modal progress HUD (a modal progress indicator, HUD = Heads Up Display)

## Demo

![Demo](https://lh3.googleusercontent.com/-UlFFunjsAKA/XQyhBtwEKNI/AAAAAAAAQkw/Qv84ROg8qAc2iNgoAtuqJdTomvZKWFyPACK8BGAs/s0/2019-06-21.jpg)

*See example for details*


## Usage

Add the package to your `pubspec.yml` file.

```yml
dependencies:
  simple_loading_view: ^0.0.1
```

Next, import the library into your widget.

```dart
import 'package:simple_loading_view/simple_loading_view.dart';
```

How to implement LoadingView ? 

```dart
...
bool _isLoading = false
...

@override
Widget build(BuildContext context) {
  return Scaffold(
     body: LoadingView(
              isLoading: isLoading,
              // you can use your own widget here, more example please refer example project.
              progressIndicator: IndicatorMap[Indicator.defaultIndicator],
              // Current page UI implement here as child, Here i'm implemented a button for showing the indicator.
              child: OutlineButton(
                       child: const Text('Default', semanticsLabel: 'Default'),
                       onPressed: () {
                         indicatorWidget = IndicatorMap[Indicator.defaultIndicator];
                           setState(() {
                             isLoading = true;
                           });
                           // For testing Purpose i used a function for Hiding the Indicator.
                           closeIndicator();
                           },
                           )),
  );
}
```


## Options in the Indicator view 

The parameters are customizable
```dart
LoadingOverlay({
    @required this.isLoading,
    @required this.child,
    this.opacity = 0.7,
    this.progressIndicator = IndicatorMap[Indicator.defaultIndicator],
});
```




### Issues and feedback

Please file [issues](https://github.com/Aneesh1990/Flutter_LoadingIndicator/issues/new)
to send feedback or report a bug. Thank you!



