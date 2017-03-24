//
//  Browser.h
//  Twitthat
//
//  Created by Superbil on 2017/3/24.
//  Copyright © 2017年 Superbil. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Link;

@interface Browser : NSObject

+ (instancetype)get;

- (Link *)chrome;

- (Link *)firefox;

- (Link *)safari;

@end
