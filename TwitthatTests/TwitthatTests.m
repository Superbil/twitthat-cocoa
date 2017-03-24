//
//  TwitthatTests.m
//  TwitthatTests
//
//  Created by Superbil on 2017/3/25.
//  Copyright © 2017年 Superbil. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Link.h"

@interface TwitthatTests : XCTestCase

@end

@implementation TwitthatTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLink {
    Link *l = [[Link alloc] initWithString:@"https://superbil.org::superbil::Hello I am back"];
    XCTAssertNotNil(l);
    XCTAssertEqualObjects(l.title, @"Hello I am back");
    XCTAssertEqualObjects(l.url.host, @"superbil.org");

    Link *nl = [[Link alloc] initWithString:@""];
    XCTAssertNotNil(nl);
    XCTAssertNil(nl.title);
    XCTAssertNil(nl.url);
}

@end
