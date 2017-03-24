//
//  Link.h
//  Twitthat
//
//  Created by Superbil on 2017/3/25.
//  Copyright © 2017年 Superbil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Link : NSObject

- (instancetype)initWithString:(NSString *)aString;

@property (strong, readonly) NSString *title;

@property (strong, readonly) NSURL *url;

@property (strong) NSArray *images;

@end
