//
//  NSAppleEventDescriptor+AuthorizationStatus.m
//  Twitthat
//
//  Created by Superbil on 2019/2/12.
//  Copyright © 2019 Superbil. All rights reserved.
//

#import "NSAppleEventDescriptor+AuthorizationStatus.h"

@implementation NSAppleEventDescriptor (AuthorizationStatus)

+ (NSAppleEventAuthorizationStatus)authorizationStatusForTarget:(nullable NSAppleEventDescriptor *)eventDesc {

    NSAppleEventAuthorizationStatus status = NSAppleEventAuthorizationStatusNotDetermined;

    NSDictionary *options = @{(__bridge NSString *)kAXTrustedCheckOptionPrompt : @""};

    BOOL trusted = AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)options);

    if (trusted) {
        status = NSAppleEventAuthorizationStatusAuthorized;
    } else {
        status = NSAppleEventAuthorizationStatusNotDetermined;
    }

    return status;
}

@end
