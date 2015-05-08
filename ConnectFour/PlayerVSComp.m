//
//  PlayerVSComp.m
//  ConnectFour
//
//  Created by Scott McAllister on 3/8/2014.
//  Copyright (c) 2014 Scott McAllister. All rights reserved.
//

#import "PlayerVSComp.h"


@implementation PlayerVSComp : SKScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        b = [[Board alloc] init];
        human = [[Player alloc] init];
        ai = [[Player alloc] init];
        [human setName:@"Human Player"];
        [human setNumber:1];
        [ai setName:@"Computer Player"];
        [ai setNumber:2];
        currentPlayerNum = 1;
        row = 0;
        column = 0;
        gameOver = FALSE;
        winnerLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        currentPlayer = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        SKSpriteNode *board = [SKSpriteNode spriteNodeWithImageNamed:@"Board"];
        board.scale = 1.1;
        board.position = CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMidY(self.frame));
        
        currentPlayer.text = [NSString stringWithFormat:@"%@%@", human.name, @"'s Turn"];
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
        
        // Draw piece
        piece =[SKSpriteNode spriteNodeWithImageNamed:@"Red"];
        currentPlayerNum++;
        currentPlayer.text = [NSString stringWithFormat:@"%@%@", ai.name, @"'s Turn"];
    }
    
    
    
    piece.scale = 1.3;
    
    piece.position = CGPointMake(212 + (99 * column),160 + (88 * row)
                                 );
    
    if([[b winner] intValue] != 0){
        
        if([[b winner] intValue] == 1){
            winnerLabel.text = [NSString stringWithFormat:@"%@%@", human.name, @" Wins"];
            winnerLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                               700);
        }
        else{
            winnerLabel.text = [NSString stringWithFormat:@"%@%@", ai.name, @" Wins"];
            winnerLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                               700);
            
        }
        
        winnerLabel.fontSize = 40;
        currentPlayer.hidden = TRUE;
        [self addChild:winnerLabel];
        gameOver = true;
        
    }
    
    [self addChild:piece];
    
    // Computer player's turn
    if(gameOver == false){
        self->mytimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:self
                                                       selector:@selector(updateLabel)
                                                       userInfo:nil
                                                        repeats:NO];
    }
    
    
}

-(void)updateLabel{
    SKSpriteNode *piece;
    column = [self bestMove:b :2];
    row =[b piecesInColumn:column];
    if(row <= 5){
        piece = [SKSpriteNode spriteNodeWithImageNamed:@"Black"];
        [b addToColumn:column :currentPlayerNum];
        piece.scale = 1.3;
        piece.position = CGPointMake(212 + (99 * column),160 + (88 * row));
        [self addChild:piece];
        currentPlayerNum = 1;
        currentPlayer.text = [NSString stringWithFormat:@"%@%@", human.name, @"'s turn"];
    }
    if([[b winner] intValue] != 0){
        
        if([[b winner] intValue] == 1){
            winnerLabel.text = [NSString stringWithFormat:@"%@%@", human.name, @" Wins"];
            winnerLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                               700);
        }
        else{
            winnerLabel.text = [NSString stringWithFormat:@"%@%@", ai.name, @" Wins"];
            winnerLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                               700);
            
        }
        
        winnerLabel.fontSize = 40;
        currentPlayer.hidden = TRUE;
        [self addChild:winnerLabel];
        gameOver = true;
        
    }
}

- (int) bestMove: (Board*) givenBoard : (int) plr{
    Board* temp = [givenBoard copy];
    move = [[[self alphaBetaMax:temp :1 :2 :-999999999 :999999999 :1] objectAtIndex:0] intValue] ;
    return move;
    
}


/* 
 * Returns an array with the first element representing the column for the best move, and the
 * second representing the heuristic score for that column.
 */

- (NSArray*) alphaBetaMax:(Board *)givenBoard : (int) depth : (int) plr : (int) alpha : (int) beta : (int) bestMove{
    NSMutableArray* values = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:bestMove], @"1",  nil];
    [values insertObject:[NSNumber numberWithInt:bestMove] atIndex:0];
    
    // Check for terminal state
    if(depth == 0 || [[givenBoard winner] intValue] != 0){
        [values insertObject:[NSNumber numberWithInt:[givenBoard score: plr]] atIndex:1];
        return values;
    }
    
    // Max move
        for(int possilbeMove = 0; possilbeMove <= 6; possilbeMove++){
            Board *temp = [givenBoard copy];
            if([temp piecesInColumn:possilbeMove] <=5){
                [temp addToColumn:possilbeMove :1];
                // check highest score
                int score = [[[self alphaBetaMin:temp :(depth-1) :2 : alpha : beta : possilbeMove] objectAtIndex:1] intValue];
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
    
    // Check for terminal state
    if(depth == 0 || [[givenBoard winner] intValue] != 0){
        [values insertObject:[NSNumber numberWithInt:-[givenBoard score: plr]] atIndex:1];
        return values;
    }
    
    // Min move
        for(int possilbeMove = 0; possilbeMove<=6; possilbeMove++){
            Board *temp = [givenBoard copy];
            if([temp piecesInColumn:possilbeMove] <=5){
                [temp addToColumn:possilbeMove :2];
                int score = [[[self alphaBetaMax: temp :(depth-1) :2 : alpha : beta : possilbeMove] objectAtIndex:1] intValue];
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
