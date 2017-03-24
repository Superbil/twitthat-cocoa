//
//  AppDelegate.m
//  Twitthat
//
//  Created by Superbil on 2017/3/24.
//  Copyright © 2017年 Superbil. All rights reserved.
//

#import "AppDelegate.h"

#import "Browser.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSMenu *statusMenu;
@property (strong) NSStatusItem *statusBar;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusBar.title = @"TT";
    self.statusBar.menu = self.statusMenu;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - Actions

- (IBAction)chromeAction:(id)sender {
    NSLog(@"%@", [[Browser get] chrome]);
}

- (IBAction)firefoxAction:(id)sender {
    NSLog(@"%@", [[Browser get] firefox]);
}

- (IBAction)safariAction:(id)sender {
    NSLog(@"%@", [[Browser get] safari]);
}

@end
