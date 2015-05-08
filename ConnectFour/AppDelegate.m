//
//  AppDelegate.m
//  ConnectFour
//
//  Created by Scott McAllister on 2/19/2014.
//  Copyright (c) 2014 Scott McAllister. All rights reserved.
//

#import "AppDelegate.h"
#import "MyScene.h"
#import "Menu.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    /* Pick a size for the scene */
    SKScene *scene = [Menu sceneWithSize:CGSizeMake(1024, 768)];

    /* Set the scale mode to scale to fit the window */
    scene.scaleMode = SKSceneScaleModeAspectFit;

    [self.skView presentScene:scene];

    self.skView.showsFPS = NO;
    self.skView.showsNodeCount = NO;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
