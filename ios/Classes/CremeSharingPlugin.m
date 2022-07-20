#import "CremeSharingPlugin.h"
#if __has_include(<creme_sharing/creme_sharing-Swift.h>)
#import <creme_sharing/creme_sharing-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "creme_sharing-Swift.h"
#endif

@implementation CremeSharingPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCremeSharingPlugin registerWithRegistrar:registrar];
}
@end
