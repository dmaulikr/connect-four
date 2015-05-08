//
//  MyScene.m
//  ConnectFour
//
//  Created by Scott McAllister on 2/19/2014.
//  Copyright (c) 2014 Scott McAllister. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        b = [[Board alloc] init];
        p1 = [[Player alloc] init];
        p2 = [[Player alloc] init];
        [p1 setName:@"Player 1"];
        [p1 setNumber:1];
        [p2 setName:@"Player 2"];
        [p2 setNumber:2];
        currentPlayerNum = 1;
        row = 0;
        column = 0;
        winnerLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        currentPlayer = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        SKSpriteNode *board = [SKSpriteNode spriteNodeWithImageNamed:@"Board"];
        board.scale = 1.1;
        board.position = CGPointMake(CGRectGetMidX(self.frame),
                                    CGRectGetMidY(self.frame));
        
        currentPlayer.text = p1.name;
        currentPlayer.fontSize = 40;
        currentPlayer.position = CGPointMake(CGRectGetMidX(self.frame),
                                             20);
        
        [self addChild:currentPlayer];
        [self addChild:board];
    }
    return self;
}

-(void)mouseDown:(NSEvent *)theEvent {
    SKSpriteNode *piece;

    /* Get click location */
    CGPoint location = [theEvent locationInNode:self];
    if(location.x < 270){
        column = 0;
    }
    else if(location.x < 365){
        column = 1;
    }
    else if(location.x < 460){
        column = 2;
    }
    else if(location.x < 555){
        column = 3;
    }
    else if(location.x < 655){
        column = 4;
    }
    else if(location.x < 750){
        column = 5;
    }
    else{
        column = 6;
    }
    
    row = [b piecesInColumn:column];
    
    if(row <= 5){
        [b addToColumn:column :currentPlayerNum];
        
        // TO DO - take out
        NSString *digit = [NSString stringWithFormat:@"%@%d%@%d%@%d%@%d",
                           @"\n\nCurrent Player: ", currentPlayerNum ,
                           @"\n3 out of 4s: ", [b threeOutOfFourLines: currentPlayerNum],
                           @"\n2 out of 4s: ", [b twoOutOfFourLines:currentPlayerNum],
                           @"\n1 out of 4s: ", [b oneOutOfFourLines: currentPlayerNum]];
        NSLog(@"%@%@", digit, @"\n");
        [b printBoard];
        
        /* Draw Piece */
        if(currentPlayerNum == 1){
            piece =[SKSpriteNode spriteNodeWithImageNamed:@"Red"];
            currentPlayerNum++;
            currentPlayer.text = p2.name;
        }
        else{
            piece = [SKSpriteNode spriteNodeWithImageNamed:@"Black"];
            currentPlayerNum = 1;
            currentPlayer.text = p1.name;
        }
    }
    
    
    
    piece.scale = 1.3;
    
    piece.position = CGPointMake(212 + (99 * column),160 + (88 * row)
                               );
    
    if([[b winner] intValue] != 0){
        
        if([[b winner] intValue] == 1){
            winnerLabel.text = [NSString stringWithFormat:@"%@%@", p1.name, @" Wins"];
            winnerLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                                           700);
        }
        else{
            winnerLabel.text = [NSString stringWithFormat:@"%@%@", p2.name, @" Wins"];
            winnerLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                               700);
            
        }
        
        winnerLabel.fontSize = 40;
        currentPlayer.hidden = TRUE;
        [self addChild:winnerLabel];
       
    }
    
    [self addChild:piece];
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
