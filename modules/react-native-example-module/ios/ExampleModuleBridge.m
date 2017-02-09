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
