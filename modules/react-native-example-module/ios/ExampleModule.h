// //
// //  ExampleModule.h
// //  ExampleModule
// //
// //  Created by Danil Kostrov on 05/02/2017.
// //  Copyright © 2017 Danil Kostrov. All rights reserved.
// //

#import <UIKit/UIKit.h>
#import "RCTBridgeModule.h"

@interface ExampleModule : NSObject <RCTBridgeModule, UINavigationControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) RCTPromiseResolveBlock activityPromiseResolver;
@property (nonatomic) RCTPromiseRejectBlock activityPromiseRejecter;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end
