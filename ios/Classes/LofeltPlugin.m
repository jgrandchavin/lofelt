#import "LofeltPlugin.h"
#if __has_include(<lofelt/lofelt-Swift.h>)
#import <lofelt/lofelt-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "lofelt-Swift.h"
#endif

@implementation LofeltPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLofeltPlugin registerWithRegistrar:registrar];
}
@end
