//
//  ExampleModule.m
//  ExampleModule
//
//  Created by Danil Kostrov on 05/02/2017.
//  Copyright © 2017 Danil Kostrov. All rights reserved.
//

#import <Foundation/Foundation.h>

// #import "RCTLog.h"
// #import "RCTEventDispatcher.h"

#import "ExampleModule.h"

@implementation ExampleModule

RCT_EXPORT_MODULE ();

RCT_EXPORT_METHOD (callbackMethod: (NSDictionary *)options callback:(RCTResponseSenderBlock)callback)
{
  
  callback (@"hello from callback");
  
}

RCT_EXPORT_METHOD (promiseMethod: (NSDictionary *)options resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
  
  resolve (@"hello from promise");
  
}

RCT_EXPORT_METHOD (eventMethod: (NSDictionary *)options) {
  
}

// @synthesize bridge = _bridge;

// - (void)calendarEventReminderReceived:(NSNotification *)notification
// {
//     NSString *eventName = notification.userInfo[@"name"];
//     [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder" body:@{@"name": eventName}];
// }

@end
