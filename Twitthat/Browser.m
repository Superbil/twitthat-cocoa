//
//  Browser.m
//  Twitthat
//
//  Created by Superbil on 2017/3/24.
//  Copyright © 2017年 Superbil. All rights reserved.
//

#import "Browser.h"

#import <AppleScriptObjC/AppleScriptObjC.h>

#import "Link.h"

@interface Browser ()
@property NSAppleScript *chromeScript;
@property NSAppleScript *firefoxScript;
@property NSAppleScript *safariScript;
@end

@implementation Browser

+ (instancetype)get {
    static dispatch_once_t onceToken;
    static Browser *staticInstance;
    dispatch_once(&onceToken, ^{
        staticInstance = [[Browser alloc] init];
    });
    return staticInstance;
}

- (Link *)chrome {
    if (!self.chromeScript) {
      NSString *s =
@"set frontmostApplication to path to frontmost application\n \
tell application \"Google Chrome\"\n \
        set theUrl to get URL of active tab of first window\n \
        set theResult to (get theUrl) & \"::superbil::\" & (get name of window 1)\n \
end tell\n \
activate application (frontmostApplication as text)\n \
set links to {}\n \
copy theResult to the end of links\n \
return links as string\n";
        self.chromeScript = [[NSAppleScript alloc] initWithSource:s];
    }
    return [self linkWithScript:self.chromeScript];
}

- (Link *)firefox {
    if (!self.firefoxScript) {
        NSString *s =
@"set oldClipboard to the clipboard\n \
set frontmostApplication to path to frontmost application\n \
tell application \"Firefox\"\n \
    activate\n \
    delay 0.15\n \
    tell application \"System Events\"\n \
            keystroke \"l\" using {command down}\n \
            keystroke \"a\" using {command down}\n \
            keystroke \"c\" using {command down}\n \
    end tell\n \
    delay 0.15\n \
    set theUrl to the clipboard\n \
    set the clipboard to oldClipboard\n \
    set theResult to (get theUrl) & \"::superbil::\" & (get name of window 1)\n \
end tell\n \
activate application (frontmostApplication as text)\n \
set links to {}\n \
copy theResult to the end of links\n \
return links as string\n";
        self.firefoxScript = [[NSAppleScript alloc] initWithSource:s];
    }
    return [self linkWithScript:self.firefoxScript];
}

- (Link *)safari {
    if (!self.safariScript) {
      NSString *s =
@"tell application \"Safari\"\n \
        set theUrl to URL of document 1\n \
        set theName to the name of the document 1\n \
        return theUrl & \"::superbil::\" & theName & \"\n\"\n \
end tell\n";
        self.safariScript = [[NSAppleScript alloc] initWithSource:s];
    }
    return [self linkWithScript:self.safariScript];
}

- (Link *)linkWithScript:(NSAppleScript *)script {
    if (!script) return nil;

    NSDictionary *errorDict;
    NSAppleEventDescriptor *rd = [script executeAndReturnError:&errorDict];

    if (rd != NULL) {
        // successful execution
        if (kAENullEvent != [rd descriptorType]) {
            // script returned an AppleScript result
            if (cAEList == [rd descriptorType]) {
                // result is a list of other descriptors
            } else {
                return [[Link alloc] initWithString:rd.stringValue];
            }
        }
    } else {
        // no script result, handle error here
        NSLog(@"script error(%@): %@", errorDict[NSAppleScriptErrorNumber], errorDict[NSAppleScriptErrorMessage]);
    }

    return nil;
}

@end
