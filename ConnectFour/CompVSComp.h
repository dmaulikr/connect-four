//
//  CompVSComp.h
//  ConnectFour
//
//  Created by Scott McAllister on 3/7/2014.
//  Copyright (c) 2014 Scott McAllister. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Board.h"
#import "Player.h"

@interface CompVSComp : SKScene{
    Board *b;
    Player *ai, *dummy;
    int row, column, currentPlayerNum, move;
    SKLabelNode *currentPlayer;         //label
    SKLabelNode *winnerLabel;
    NSTimer *mytimer;
    BOOL gameOver;
    
}
-(void)playGame;
- (NSArray*) alphaBetaMax:(Board *)givenBoard : (int) depth : (int) plr : (int) alpha : (int) beta : (int) bestMove;
- (NSArray*) alphaBetaMin:(Board *)givenBoard : (int) depth : (int) plr : (int) alpha : (int) beta : (int) bestMove;
- (int) bestMove: (Board*) givenBoard : (int) plr;

@end
