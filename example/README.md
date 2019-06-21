# loading_view_example

Demonstrates how to use the loading_view plugin.

Example usage
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingView(
          isLoading: isLoading,
          progressIndicator: IndicatorMap[Indicator.defaultIndicator],
          child: OutlineButton(
                                 child: const Text('Default', semanticsLabel: 'Default'),
                                 onPressed: () {
                                   indicatorWidget = IndicatorMap[Indicator.defaultIndicator];
                                   // Perform some action
                                   setState(() {
                                     isLoading = true;
                                   });
                                   closeIndicator();
                                 },
                               )),
    );
  }

## Getting Started

This project is a sample for simple loading indicator.

