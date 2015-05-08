//
//  CompVSComp.m
//  ConnectFour
//
//  Created by Scott McAllister on 3/7/2014.
//  Copyright (c) 2014 Scott McAllister. All rights reserved.
//

#import "CompVSComp.h"

@implementation CompVSComp

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        b = [[Board alloc] init];
        ai = [[Player alloc] init];
        dummy = [[Player alloc] init];
        [ai setName:@"Intelligent Player"];
        [ai setNumber:1];
        [dummy setName:@"Dummy Player"];
        [dummy setNumber:2];
        currentPlayerNum = 1;
        row = 0;
        move = 0;
        column = 0;
        winnerLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        gameOver = false;
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        currentPlayer = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        SKSpriteNode *board = [SKSpriteNode spriteNodeWithImageNamed:@"Board"];
        board.scale = 1.1;
        board.position = CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMidY(self.frame));
        
        currentPlayer.text = [NSString stringWithFormat:@"%@%@", ai.name, @"'s turn"];
        currentPlayer.fontSize = 40;
        currentPlayer.position = CGPointMake(CGRectGetMidX(self.frame),
                                             20);
        
        [self addChild:currentPlayer];
        [self addChild:board];
    }
    return self;
}

-(void)playGame{
    if(gameOver == false){
        self->mytimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:self
                                                       selector:@selector(updateLabel)
                                                       userInfo:nil
                                                        repeats:YES];
    }
}

-(void)updateLabel{
    SKSpriteNode *piece;
    if(currentPlayerNum == 2){
        column = arc4random() %(7)-0;
        //column = 0;
        row =[b piecesInColumn:column];
        if(row <= 5){
            piece = [SKSpriteNode spriteNodeWithImageNamed:@"Black"];
            [b addToColumn:column :currentPlayerNum];
            currentPlayerNum = 1;
            currentPlayer.text = [NSString stringWithFormat:@"%@%@", ai.name, @"'s turn"];
            piece.scale = 1.3;
            piece.position = CGPointMake(212 + (99 * column),160 + (88 * row));
            [self addChild:piece];
        }
        
    }
    else{
        column = [self bestMove:b :1];
        row =[b piecesInColumn:column];
        if(row <= 5){
            piece = [SKSpriteNode spriteNodeWithImageNamed:@"Red"];
            [b addToColumn:column :currentPlayerNum];
            currentPlayerNum = 2;
            currentPlayer.text = [NSString stringWithFormat:@"%@%@", dummy.name, @"'s turn"];
            piece.scale = 1.3;
            piece.position = CGPointMake(212 + (99 * column),160 + (88 * row));
            [self addChild:piece];
        }
    }
    
    if([[b winner] intValue] != 0){
        [self stopGame];
        if([[b winner] intValue] == 1){
            winnerLabel.text = [NSString stringWithFormat:@"%@%@", ai.name, @" Wins"];
            winnerLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                               700);
        }
        else{
            winnerLabel.text = [NSString stringWithFormat:@"%@%@", dummy.name, @" Wins"];
            winnerLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                               700);
            
        }
        
        winnerLabel.fontSize = 40;
        currentPlayer.hidden = TRUE;
        [self addChild:winnerLabel];
        
    }
}



-(void)stopGame{
    [self->mytimer invalidate];
    gameOver = true;
}

- (void)didMoveToView:(SKView *)view {
    [self playGame];
}

- (int) bestMove: (Board*) givenBoard : (int) plr{
    Board* temp = [givenBoard copy];
    move = [[[self alphaBetaMax:temp :1 :1 :-999999999 :999999999 :2] objectAtIndex:0] intValue] ;
    return move;
    
}


/*
 * Returns an array with the first element representing the column for the best move, and the
 * second representing the heuristic score for that column.
 */

- (NSArray*) alphaBetaMax:(Board *)givenBoard : (int) depth : (int) plr : (int) alpha : (int) beta : (int) bestMove{

    NSMutableArray* values = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:bestMove], @"1",  nil];
    [values insertObject:[NSNumber numberWithInt:bestMove] atIndex:0];
    
    // check for terminal state
    if(depth == 0 || [[givenBoard winner] intValue] != 0){
        [values insertObject:[NSNumber numberWithInt:bestMove] atIndex:0];
        [values insertObject:[NSNumber numberWithInt:[givenBoard score: plr]] atIndex:1];
        return values;
    }
    
    // Max move
    for(int possilbeMove = 0; possilbeMove <= 6; possilbeMove++){
        Board *temp = [givenBoard copy];
        if([temp piecesInColumn:possilbeMove] <=5){
            [temp addToColumn:possilbeMove :2];
            // check highest score
            int score = [[[self alphaBetaMin:temp :(depth-1) :plr : alpha : beta : possilbeMove] objectAtIndex:1] intValue];
            if(score >= beta){
                // beta cut-off
                [values insertObject:[NSNumber numberWithInt:possilbeMove] atIndex:0];
                [values insertObject:[NSNumber numberWithInt:beta] atIndex:1];
                return values;
            }
            if(score > alpha){
                // replace alpha if score is bigger
                alpha = score;
                [values insertObject:[NSNumber numberWithInt:possilbeMove] atIndex:0];
                [values insertObject:[NSNumber numberWithInt:alpha] atIndex:1];
            }
            
        }
    }
    [values insertObject:[NSNumber numberWithInt:alpha] atIndex:1];
    return values;
    
}

- (NSArray*) alphaBetaMin:(Board *)givenBoard : (int) depth : (int) plr : (int) alpha : (int) beta : (int) bestMove{
    NSMutableArray* values = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:bestMove], @"1",  nil];
    [values insertObject:[NSNumber numberWithInt:bestMove] atIndex:0];
    if(depth == 0 || [[givenBoard winner] intValue] != 0){
        [values insertObject:[NSNumber numberWithInt:-[givenBoard score: plr]] atIndex:1];
        return values;
    }
    
    // Min move
    for(int possilbeMove = 0; possilbeMove<=6; possilbeMove++){
        Board *temp = [givenBoard copy];
        if([temp piecesInColumn:possilbeMove] <=5){
            [temp addToColumn:possilbeMove :1];
            int score = [[[self alphaBetaMax: temp :(depth-1) :plr : alpha : beta : possilbeMove] objectAtIndex:1] intValue];
            if(score <= alpha){
                // alpha cut-off
                [values insertObject:[NSNumber numberWithInt:possilbeMove] atIndex:0];
                [values insertObject:[NSNumber numberWithInt:alpha] atIndex:1];
                return values;
            }
            if(score < beta){
                // replace beta if score is smaller
                beta = score;
                [values insertObject:[NSNumber numberWithInt:possilbeMove] atIndex:0];
                [values insertObject:[NSNumber numberWithInt:beta] atIndex:1];
            }
        }
    }
    [values insertObject:[NSNumber numberWithInt:beta] atIndex:1];
    return values;
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
