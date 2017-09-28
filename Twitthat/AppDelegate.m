//
//  AppDelegate.m
//  Twitthat
//
//  Created by Superbil on 2017/3/24.
//  Copyright © 2017年 Superbil. All rights reserved.
//

#import "AppDelegate.h"

#import <Social/Social.h>

#import "Browser.h"
#import "Link.h"

typedef NS_ENUM(NSUInteger, BrowserSource) {
    BrowserSourceChrome = 1,
    BrowserSourceFirefox,
    BrowserSourceSafari,
};

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSMenu *statusMenu;
@property (strong) NSStatusItem *statusBar;
@property (strong) NSArray<NSString *> *browserTitles;
@property (strong) NSArray<NSString *> *actionTitles;
@property (assign) BrowserSource currentSource;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusBar.title = @"TT";
    self.statusBar.menu = self.statusMenu;
    NSMenuItem *quitItem = self.statusMenu.itemArray.lastObject;
    quitItem.target = NSApp;
    quitItem.action = @selector(terminate:);

    self.browserTitles = @[NSLocalizedString(@"{{SM_Get_Chrome}}", nil),
                           NSLocalizedString(@"{{SM_Get_Firefox}}", nil),
                           NSLocalizedString(@"{{SM_Get_Safari}}", nil)];

    NSArray *titles = [[NSUserDefaults standardUserDefaults] objectForKey:@"Action titles"];
    if (titles == nil) {
        titles = @[@"Reading:",
                   @"Looking at:",
                   @"Watching:",
                   @"Listening to:",
                   @"Laughing at:",
                   @"Curious about:",
                   @"Crying for:",
                   @"Orz at:",
                   @"Disappointed at:",
                   @"Responding to:",
                   @"Waiting for:",
                   @"Looking forward to:",
                   @"→_→",
                   @"@",
                   ];
    }
    self.actionTitles = titles;

    self.actionTitles = [self.actionTitles arrayByAddingObjectsFromArray:@[@"[好奇]", @"[大笑]", @"[觀看]", @"[讀]"]];

    [self initMenu];

}

- (void)initMenu {
    NSInteger s = [[NSUserDefaults standardUserDefaults] integerForKey:@"Current Browser"];
    self.currentSource = s;

    NSMenu *browserMenu = [[NSMenu alloc] initWithTitle:@"Browser"];
    [self.browserTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull t, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:t
                                                      action:@selector(browserChange:)
                                               keyEquivalent:@""];
        [browserMenu addItem:item];
        if (s > 0 && idx == (s - 1)) {
            // show checkmark
            [item setState:NSOnState];
        }
    }];
    NSMenuItem *p = [self.statusMenu itemAtIndex:1];
    p.submenu = browserMenu;

    NSUInteger insertIndex = 0;
    [self.actionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull t, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:t action:@selector(itemAction:) keyEquivalent:@""];
        [self.statusMenu insertItem:item atIndex:insertIndex + idx];
    }];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - Actions

- (IBAction)browserChange:(id)sender {
    NSMenuItem *menuItem = sender;
    if ([menuItem.title isEqualToString:NSLocalizedString(@"{{SM_Get_Chrome}}", nil)]) {
        self.currentSource = BrowserSourceChrome;
    } else if ([menuItem.title isEqualToString:NSLocalizedString(@"{{SM_Get_Firefox}}", nil)]) {
        self.currentSource = BrowserSourceFirefox;
    } else if ([menuItem.title isEqualToString:NSLocalizedString(@"{{SM_Get_Safari}}", nil)]) {
        self.currentSource = BrowserSourceSafari;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:self.currentSource forKey:@"Current Browser"];
}

- (IBAction)itemAction:(id)sender {
    NSMenuItem *menuItem = sender;

    Link *l = nil;
    switch (self.currentSource) {
        case BrowserSourceChrome:
            l = [[Browser get] chrome];
            break;
        case BrowserSourceFirefox:
            l = [[Browser get] firefox];
            break;
        case BrowserSourceSafari:
            l =  [[Browser get] safari];
            break;

        default:
            break;
    }

    if (l) {
        NSString *outputString = [NSString stringWithFormat:@"%@ %@ %@", menuItem.title, l.title, l.url];
        NSLog(@"%@", outputString);
        NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
        NSInteger countOfClear = [pasteboard clearContents];
        [pasteboard writeObjects:@[outputString]];
        NSLog(@"write to pasteboard, clearContents %ld", countOfClear);
    }
}

@end
