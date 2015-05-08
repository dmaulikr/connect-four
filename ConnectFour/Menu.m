//
//  Menu.m
//  ConnectFour
//
//  Created by Scott McAllister on 3/5/2014.
//  Copyright (c) 2014 Scott McAllister. All rights reserved.
//

#import "Menu.h"


@implementation Menu
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        welcomeMessage = [SKLabelNode labelNodeWithFontNamed:@"American Typewriter Bold"];
        welcomeMessage.text = @"Welcome to Connect Four!!";
        welcomeMessage.fontSize = 40;
        welcomeMessage.position = CGPointMake(CGRectGetMidX(self.frame),
                                             700);
        
        selectMessage = [SKLabelNode labelNodeWithFontNamed:@"American Typewriter"];
        selectMessage.text = @"Please select a game type";
        selectMessage.fontSize = 26;
        selectMessage.position = CGPointMake(CGRectGetMidX(self.frame),
                                              600);
        
        plrVScpu = [SKSpriteNode spriteNodeWithImageNamed:@"Player_v_AI"];
        plrVScpu.name = @"plrVScpu";
        plrVScpu.position = CGPointMake(CGRectGetMidX(self.frame),
                                              500);
        
        cpuVScpu = [SKSpriteNode spriteNodeWithImageNamed:@"AI_v_Dummy"];
        cpuVScpu.name = @"cpuVScpu";
        cpuVScpu.position = CGPointMake(CGRectGetMidX(self.frame),
                                        400);
        
        plrVSplr = [SKSpriteNode spriteNodeWithImageNamed:@"Player_v_Player"];
        plrVSplr.name = @"plrVSplr";
        plrVSplr.position = CGPointMake(CGRectGetMidX(self.frame),
                                        300);
       
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        [self addChild:welcomeMessage];
        [self addChild:selectMessage];
        [self addChild:plrVScpu];
        [self addChild:cpuVScpu];
        [self addChild:plrVSplr];
        
    }
    
    
    return self;
}

-(void)mouseDown:(NSEvent *)theEvent {
    
    CGPoint location = [theEvent locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    //if fire button touched, bring the rain
    if ([node.name isEqualToString:@"plrVSplr"]) {
        SKTransition *reveal = [SKTransition fadeWithColor:[SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0] duration:1.0];
        MyScene *newScene = [[MyScene alloc] initWithSize: CGSizeMake(1024,768)];
        //  Optionally, insert code to configure the new scene.
        [self.scene.view presentScene: newScene transition: reveal];
    }
    else if ([node.name isEqualToString:@"cpuVScpu"]){
        SKTransition *reveal = [SKTransition fadeWithColor:[SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0] duration:1.0];
        CompVSComp *newScene = [[CompVSComp alloc] initWithSize: CGSizeMake(1024,768)];
        //  Optionally, insert code to configure the new scene.
        [self.scene.view presentScene: newScene transition: reveal];
    }
    else if ([node.name isEqualToString:@"plrVScpu"]){
        SKTransition *reveal = [SKTransition fadeWithColor:[SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0] duration:1.0];
        PlayerVSComp *newScene = [[PlayerVSComp alloc] initWithSize: CGSizeMake(1024,768)];
        //  Optionally, insert code to configure the new scene.
        [self.scene.view presentScene: newScene transition: reveal];
    }
        
}


@end
