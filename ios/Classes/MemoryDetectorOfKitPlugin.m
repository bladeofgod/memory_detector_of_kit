#import "MemoryDetectorOfKitPlugin.h"
#if __has_include(<memory_detector_of_kit/memory_detector_of_kit-Swift.h>)
#import <memory_detector_of_kit/memory_detector_of_kit-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "memory_detector_of_kit-Swift.h"
#endif

@implementation MemoryDetectorOfKitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMemoryDetectorOfKitPlugin registerWithRegistrar:registrar];
}
@end
