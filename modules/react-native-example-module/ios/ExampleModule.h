#import "RCTBridgeModule.h"

@interface ExampleModule: NSObject <
    RCTBridgeModule,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
>

@property (nonatomic) RCTPromiseResolveBlock nativeMethodPromiseResolver;
@property (nonatomic) RCTPromiseRejectBlock nativeMethodPromiseRejecter;

@end
