//
//  Link.m
//  Twitthat
//
//  Created by Superbil on 2017/3/25.
//  Copyright © 2017年 Superbil. All rights reserved.
//

#import "Link.h"

@interface Link ()
@property (strong, readwrite) NSString *title;
@property (strong, readwrite) NSURL *url;
@end

@implementation Link

- (instancetype)initWithString:(NSString *)aString {
    if (self = [super init]) {

    }
    return self;
}

@end
