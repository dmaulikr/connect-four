//
//  Menu.h
//  ConnectFour
//
//  Created by Scott McAllister on 3/5/2014.
//  Copyright (c) 2014 Scott McAllister. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MyScene.h"
#import "CompVSComp.h"
#import "PlayerVSComp.h"

@interface Menu : SKScene{
    SKLabelNode *welcomeMessage, *selectMessage;
    SKSpriteNode *plrVScpu, *cpuVScpu, *plrVSplr;
}

@end
