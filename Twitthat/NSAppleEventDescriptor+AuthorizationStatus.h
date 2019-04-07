//
//  NSAppleEventDescriptor+AuthorizationStatus.h
//  Twitthat
//
//  Created by Superbil on 2019/2/12.
//  Copyright © 2019 Superbil. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NSAppleEventAuthorizationStatus) {
    // User has not yet been prompted for permission.
    NSAppleEventAuthorizationStatusNotDetermined,

    // User has explicitely denied permission.
    NSAppleEventAuthorizationStatusDenied,

    // User has explicitely granted permission.
    NSAppleEventAuthorizationStatusAuthorized
};

@interface NSAppleEventDescriptor (AuthorizationStatus)

+ (NSAppleEventAuthorizationStatus)authorizationStatusForTarget:(nullable NSAppleEventDescriptor *)eventDesc;

@end
