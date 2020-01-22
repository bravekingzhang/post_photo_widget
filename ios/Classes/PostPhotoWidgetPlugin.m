#import "PostPhotoWidgetPlugin.h"
#if __has_include(<post_photo_widget/post_photo_widget-Swift.h>)
#import <post_photo_widget/post_photo_widget-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "post_photo_widget-Swift.h"
#endif

@implementation PostPhotoWidgetPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPostPhotoWidgetPlugin registerWithRegistrar:registrar];
}
@end
