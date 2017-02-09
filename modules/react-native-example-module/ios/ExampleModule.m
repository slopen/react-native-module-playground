#import <Foundation/Foundation.h>

#import "RCTEventDispatcher.h"

#import "ExampleModule.h"

@implementation ExampleModule

RCT_EXPORT_MODULE ();


- (NSDictionary *)constantsToExport
{
    return @{
        @"FILES_DIR_PATH": NSBundle.mainBundle.bundlePath,
        @"CACHE_DIR_PATH": NSTemporaryDirectory ()
    };
}


RCT_EXPORT_METHOD (
    callbackMethod:(NSDictionary *)options
          callback:(RCTResponseSenderBlock)callback
           errback:(RCTResponseSenderBlock)errback
) {
    @try {
        callback (@[@"hello from callback"]);
    }
    @catch (NSException *exception) {
        errback ([NSThread callStackSymbols]);
    }
}

RCT_EXPORT_METHOD (
    promiseMethod:(NSDictionary *)options
         resolver:(RCTPromiseResolveBlock)resolve
         rejecter:(RCTPromiseRejectBlock)reject
) {
    @try {
        resolve (@{
            @"message": @"hello from promise"
        });
    }
    @catch (NSException *exception) {
        NSError *error;
        NSString *code = @"0";

        reject (code, [NSThread callStackSymbols], error);
    }
}

@synthesize bridge = _bridge;

RCT_EXPORT_METHOD (
    eventMethod: (NSDictionary *)options
) {
    [self.bridge.eventDispatcher sendAppEventWithName:@"example-module:event"
                                                 body:@{@"data": @"hello from event"}];
}


RCT_EXPORT_METHOD (
    nativeMethod:(NSDictionary *)options
        resolver:(RCTPromiseResolveBlock)resolve
        rejecter:(RCTPromiseRejectBlock)reject
) {

    dispatch_async (dispatch_get_main_queue (), ^{

        UIImagePickerController *controller = [[UIImagePickerController alloc] init];

        controller.delegate = self;
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.allowsEditing = NO;

        [[self getRootViewController] presentViewController:controller
                                                   animated:YES
                                                 completion:nil];

        self.nativeMethodPromiseResolver = resolve;
        self.nativeMethodPromiseRejecter = reject;

    });

}

- (UIViewController*) getRootViewController {
    UIViewController *root = UIApplication
        .sharedApplication
        .delegate
        .window
        .rootViewController;

    while (root.presentedViewController != nil) {
        root = root.presentedViewController;
    }

    return root;
}

- (void) imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *pickedImage = [info objectForKey: UIImagePickerControllerOriginalImage];
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    NSURL *imageUrl = [info objectForKey: UIImagePickerControllerReferenceURL];
    NSString *path = [imageUrl absoluteString];

    self.nativeMethodPromiseResolver (@{
        @"path": path,
        @"type": mediaType,
        @"message": @"hello from activity"
    });

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSError *error;
    NSString *code = @"0";

    self.nativeMethodPromiseRejecter (code, @"CANCELLED", error);

    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
