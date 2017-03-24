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
        if (aString) {
            NSString *split = @"::superbil::";
            NSRange r = [aString rangeOfString:split];
            if (r.location != NSNotFound) {
                NSString *link = [aString substringWithRange:NSMakeRange(0, r.location)];
                self.url = [NSURL URLWithString:link];
                self.title = [aString substringWithRange:NSMakeRange(r.location + split.length, aString.length - (r.location + split.length))];
            }
        }
    }
    return self;
}

- (NSString *)description {
    NSMutableString *d = [[NSMutableString alloc] init];
    [d appendFormat:@"<%@>\n", NSStringFromClass([self class])];
    [d appendFormat:@"  title: %@\n", self.title];
    [d appendFormat:@"  url: %@", self.url];
    return d;
}

@end
