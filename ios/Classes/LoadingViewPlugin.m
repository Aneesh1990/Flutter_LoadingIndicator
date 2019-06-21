#import "LoadingViewPlugin.h"
#import <loading_view/loading_view-Swift.h>

@implementation LoadingViewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLoadingViewPlugin registerWithRegistrar:registrar];
}
@end
