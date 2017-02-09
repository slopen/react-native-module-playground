#import "RCTBridge.h"

@interface RCT_EXTERN_MODULE (ExampleModule, NSObject)

RCT_EXTERN_METHOD (
    callbackMethod:(NSDictionary *)options
          callback:(RCTResponseSenderBlock)callback
           errback:(RCTResponseSenderBlock)errback
);

RCT_EXTERN_METHOD (
    promiseMethod:(NSDictionary *)options
         resolver:(RCTPromiseResolveBlock)resolve
         rejecter:(RCTPromiseRejectBlock)reject
);

RCT_EXTERN_METHOD (
    eventMethod:(NSDictionary *)options
);

RCT_EXTERN_METHOD (
    nativeMethod:(NSDictionary *)options
        resolver:(RCTPromiseResolveBlock)resolve
        rejecter:(RCTPromiseRejectBlock)reject
);


@end


// #import "RCTBridgeModule.h"

// @interface RCT_EXTERN_MODULE(ExampleModule, NSObject)

// RCT_EXTERN_METHOD(callbackMethod:(NSString *)name location:(NSString *)location date:(NSNumber *)date)

// @end


//  //
//  //  ExampleModule.m
//  //  ExampleModule
//  //
//  //  Created by Danil Kostrov on 05/02/2017.
//  //  Copyright © 2017 Danil Kostrov. All rights reserved.
//  //
// #import <UIKit/UIKit.h>
// #import <Foundation/Foundation.h>

// #import "RCTLog.h"
// #import "RCTEventDispatcher.h"
// #import "RCTRootView.h"

// #import "ExampleModule.h"

// @implementation ExampleModule

// RCT_EXPORT_MODULE ();


// - (NSDictionary *)constantsToExport
// {
//     return @{
//         @"FILES_DIR_PATH": NSBundle.mainBundle.bundlePath,
//         @"CACHE_DIR_PATH": NSTemporaryDirectory ()
//     };
// }


// RCT_EXPORT_METHOD (
//     callbackMethod:(NSDictionary *)options
//           callback:(RCTResponseSenderBlock)callback
//            errback:(RCTResponseSenderBlock)errback
// ) {
//     @try {
//         callback (@[@"hello from callback"]);
//     }
//     @catch (NSException *exception) {
//         errback ([NSThread callStackSymbols]);
//     }
// }

// RCT_EXPORT_METHOD (
//     promiseMethod:(NSDictionary *)options
//          resolver:(RCTPromiseResolveBlock)resolve
//          rejecter:(RCTPromiseRejectBlock)reject
// ) {
//     @try {
//         resolve (@{
//             @"message": @"hello from promise"
//         });
//     }
//     @catch (NSException *exception) {
//         NSError *error;
//         NSString *code = @"0";

//         reject (code, [NSThread callStackSymbols], error);
//     }
// }

// @synthesize bridge = _bridge;

// RCT_EXPORT_METHOD (
//     eventMethod: (NSDictionary *)options
// ) {
//     [self.bridge.eventDispatcher sendAppEventWithName:@"example-module:event"
//                                                  body:@{@"data": @"hello from event"}];
// }


// RCT_EXPORT_METHOD (
//     nativeMethod:(NSDictionary *)options
//         resolver:(RCTPromiseResolveBlock)resolve
//         rejecter:(RCTPromiseRejectBlock)reject
// ) {

//     dispatch_async (dispatch_get_main_queue (), ^{

//         UIImagePickerController *controller = [[UIImagePickerController alloc] init];

//         controller.delegate = self;
//         controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//         controller.allowsEditing = YES;

//         [[self getRootViewController] presentViewController:controller
//                                                    animated:YES
//                                                  completion:nil];

//         self.imagePickerController = controller;
//         self.activityPromiseResolver = resolve;
//         self.activityPromiseRejecter = reject;

//     });

// }

// - (UIViewController*) getRootViewController {
//     UIViewController *root = UIApplication
//         .sharedApplication
//         .delegate
//         .window
//         .rootViewController;

//     while (root.presentedViewController != nil) {
//         root = root.presentedViewController;
//     }

//     return root;
// }

// - (void) imagePickerController:(UIImagePickerController *)picker
//  didFinishPickingMediaWithInfo:(NSDictionary *)info
// {
//     UIImage *pickedImage = [info objectForKey: UIImagePickerControllerOriginalImage];
//     NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
//     NSURL *imageUrl = [info objectForKey: UIImagePickerControllerReferenceURL];
//     NSString *path = [imageUrl absoluteString];

//     self.activityPromiseResolver (@{
//         @"path": path,
//         @"type": mediaType,
//         @"message": @"hello from activity"
//     });

//     [[self imagePickerController] dismissViewControllerAnimated:YES completion:nil];
// }

// @end
