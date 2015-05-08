//
//  MyScene.h
//  ConnectFour
//

//  Copyright (c) 2014 Scott McAllister. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Board.h"
#import "Player.h"


@interface MyScene : SKScene{
    Board *b;
    Player *p1, *p2;
    int row, column, currentPlayerNum;
    SKLabelNode *currentPlayer;         //label
    SKLabelNode *winnerLabel;
}

@end
