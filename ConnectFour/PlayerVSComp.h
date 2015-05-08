//
//  PlayerVSComp.h
//  ConnectFour
//
//  Created by Scott McAllister on 3/8/2014.
//  Copyright (c) 2014 Scott McAllister. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Board.h"
#import "Player.h"

@interface PlayerVSComp : SKScene{
    Board *b;
    Player *human, *ai;
    int row, column, currentPlayerNum, move;
    SKLabelNode *currentPlayer;         //label
    SKLabelNode *winnerLabel;
    NSTimer *mytimer;
    BOOL gameOver;
}
- (NSArray*) alphaBetaMax:(Board *)givenBoard : (int) depth : (int) plr : (int) alpha : (int) beta : (int) bestMove;
- (NSArray*) alphaBetaMin:(Board *)givenBoard : (int) depth : (int) plr : (int) alpha : (int) beta : (int) bestMove;
- (int) bestMove: (Board*) givenBoard : (int) plr;

@end
