//
//  Board.m
//  ConnectFour
//
//  Created by Scott McAllister on 2/19/2014.
//  Copyright (c) 2014 Scott McAllister. All rights reserved.
//

#import "Board.h"

@implementation Board

- (void) setSpace: (int) row :(int) col :(NSNumber*) val{
    spaces[row][col] = val;
}
- (NSNumber*) space: (int) row :(int) col{
    return spaces[row][col];
}

- (int) piecesInColumn:(int)col{
    int numPieces = 0;
    for(int i=0; i<6; i++){
        if(spaces[i][col] != 0){
            numPieces++;
        }
    }
    return numPieces;
}

- (NSNumber*) winner{
    // check for vertical 4 in a row
    
    for(int row = 0; row <=2; row++){
        for(int col = 0; col <=6; col++){
            if (spaces[row][col] != 0 &&
                spaces[row][col] == spaces[row+1][col] &&
                spaces[row][col] == spaces[row+2][col] &&
                spaces[row][col] == spaces[row+3][col])
                return spaces[row][col];
        }
    }
            
    
    // check for horizontal 4 in a row
    
    for(int row = 0; row <=5; row++){
        for(int col = 0; col <=3; col++){
            if(spaces[row][col] != 0 &&
               spaces[row][col] == spaces[row][col+1] &&
               spaces[row][col] == spaces[row][col+2] &&
               spaces[row][col] == spaces[row][col+3]){
                return spaces[row][col];
            }
        }
    }
    
    // check for diagonal 4 in a row
    
    for(int col = 0; col <=5; col++){
        for(int row = 0; row <=2; row++){
            if(spaces[row][col] != 0 &&
               spaces[row][col] == spaces[row+1][col+1] &&
               spaces[row][col] == spaces[row+2][col+2] &&
               spaces[row][col] == spaces[row+3][col+3]){
                return spaces[row][col];
            }
        }
        for(int row = 3; row <=5; row++){
            if (spaces[row][col] != 0 &&
                spaces[row][col] == spaces[row-1][col+1] &&
                spaces[row][col] == spaces[row-2][col+2] &&
                spaces[row][col] == spaces[row-3][col+3]){
                    return spaces [row][col];
                }
        }
    }
    
    // return 0 as default
    
    return [NSNumber numberWithInt:0];
}

- (void) addToColumn : (int) col : (int) plr{
    if([self piecesInColumn:col]<6){
        [self setSpace:[self piecesInColumn:col] :col :[NSNumber numberWithInt:plr]];
    }
    
}

- (void) printBoard{
    NSString *output = @"Board \n\n";
    
    for(int row = 5; row >=0; row--){
        for(int col = 0; col <=6; col++){
            if(spaces[row][col] == NULL){
                output = [NSString stringWithFormat:@"%@%@%@", output, @"0", @"\t"];
            }
            else{
                output = [NSString stringWithFormat:@"%@%@%@", output, spaces[row][col], @"\t"];
            }
        }
        output = [NSString stringWithFormat:@"%@%@", output, @"\n"];
    }
    
    //output = [NSString stringWithFormat:@"%@%@%@", output, @"\n", [self threeOutOfFourLines:<#(int)#>]];
    NSLog(@"%@", output);
}

- (int) score: (int) plr {
    if([[self winner] intValue] == plr){
        return 900000000;
    }
    else if([[self winner] intValue] != plr && [[self winner] intValue] !=0){
        return -800000000;
    }
    return (100 * [self threeOutOfFourLines:plr]) + (10 * [self twoOutOfFourLines:plr]) + [self oneOutOfFourLines:plr];
}


- (int) threeOutOfFourLines: (int) plr{
    int val = 0;
    
    // check for 3 in a row vertically
    for(int row = 0; row <=2; row++){
        for(int col = 0; col <=6; col++){
            if ([spaces[row][col] intValue] == plr &&
                plr == [spaces[row+1][col] intValue] &&
                plr == [spaces[row+2][col] intValue] &&
                [spaces[row+3][col] intValue] == 0)
                val++;
        }
    }
    
    // check for 3 in a row horizontally
    for(int row = 0; row <=5; row++){
        for(int col = 0; col <=3; col++){
            if(       ([spaces[row][col] intValue] == plr &&
                       spaces[row][col] == spaces[row][col+1] &&
                       spaces[row][col] == spaces[row][col+2] &&
                       0 == [spaces[row][col+3] intValue])
               
               ||     ([spaces[row][col] intValue] == 0 &&
                       plr == [spaces[row][col+1] intValue] &&
                       plr == [spaces[row][col+2] intValue] &&
                       plr == [spaces[row][col+3] intValue])
               ){
                val++;
            }
        }
    }
    
    
    
    // check for 3 out of 4 diagonally
    for(int col = 0; col <=3; col++){
        for(int row = 0; row<=2; row++){
            if(       ([spaces[row][col] intValue] == plr &&
                       plr == [spaces[row+1][col+1] intValue] &&
                       plr ==[spaces[row+2][col+2] intValue] &&
                       0 == [spaces[row+3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == plr &&
                         plr == [spaces[row+1][col+1] intValue] &&
                         0 ==[spaces[row+2][col+2] intValue] &&
                         plr == [spaces[row+3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         plr == [spaces[row+1][col+1] intValue] &&
                         plr ==[spaces[row+2][col+2] intValue] &&
                         plr == [spaces[row+3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == plr &&
                         0 == [spaces[row+1][col+1] intValue] &&
                         plr ==[spaces[row+2][col+2] intValue] &&
                         plr == [spaces[row+3][col+3] intValue])){
                   val++;
               }
        }
        for(int row = 3; row<=5; row++){
            if(       ([spaces[row][col] intValue] == plr &&
                       plr == [spaces[row-1][col+1] intValue] &&
                       plr ==[spaces[row-2][col+2] intValue] &&
                       0 == [spaces[row-3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == plr &&
                         plr == [spaces[row-1][col+1] intValue] &&
                         0 ==[spaces[row-2][col+2] intValue] &&
                         plr == [spaces[row-3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         plr == [spaces[row-1][col+1] intValue] &&
                         plr ==[spaces[row-2][col+2] intValue] &&
                         plr == [spaces[row-3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == plr &&
                         0 == [spaces[row-1][col+1] intValue] &&
                         plr ==[spaces[row-2][col+2] intValue] &&
                         plr == [spaces[row-3][col+3] intValue])){
                   val++;
               }
        }
        
    }
    
    
    
    return val;
}

- (int) twoOutOfFourLines:(int)plr{
    int val = 0;
    
    // check for 2 in a row vertically
    for(int row = 0; row <=2; row++){
        for(int col = 0; col <=6; col++){
            if ([spaces[row][col] intValue] == plr &&
                plr == [spaces[row+1][col] intValue] &&
                0 == [spaces[row+2][col] intValue] &&
                [spaces[row+3][col] intValue] == 0)
                val++;
        }
    }
    
    // check for 2 out of 4 horizontally
    for(int row = 0; row <=5; row++){
        for(int col = 0; col <=3; col++){
            if(       ([spaces[row][col] intValue] == plr &&
                       spaces[row][col] == spaces[row][col+1] &&
                       0 == [spaces[row][col+2] intValue] &&
                       0 == [spaces[row][col+3] intValue])
               
               ||     ([spaces[row][col] intValue] == 0 &&
                       0 == [spaces[row][col+1] intValue] &&
                       plr == [spaces[row][col+2] intValue] &&
                       plr == [spaces[row][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         plr == [spaces[row][col+1] intValue] &&
                         0 == [spaces[row][col+2] intValue] &&
                         plr == [spaces[row][col+3] intValue])
               
               ||     ([spaces[row][col] intValue] == plr &&
                       0 == [spaces[row][col+1] intValue] &&
                       plr == [spaces[row][col+2] intValue] &&
                       0 == [spaces[row][col+3] intValue])
               
               ||     ([spaces[row][col] intValue] == plr &&
                       0 == [spaces[row][col+1] intValue] &&
                       0 == [spaces[row][col+2] intValue] &&
                       plr == [spaces[row][col+3] intValue])
               
               ||     ([spaces[row][col] intValue] == 0 &&
                       plr == [spaces[row][col+1] intValue] &&
                       plr == [spaces[row][col+2] intValue] &&
                       0 == [spaces[row][col+3] intValue])
               ){
                val++;
            }
        }
    }
    
    // check for 2 out of four diagonally
    for(int col = 0; col <=3; col++){
        for(int row = 0; row<=2; row++){
            if(       ([spaces[row][col] intValue] == plr &&
                       0 == [spaces[row+1][col+1] intValue] &&
                       plr ==[spaces[row+2][col+2] intValue] &&
                       0 == [spaces[row+3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         plr == [spaces[row+1][col+1] intValue] &&
                         0 ==[spaces[row+2][col+2] intValue] &&
                         plr == [spaces[row+3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         plr == [spaces[row+1][col+1] intValue] &&
                         plr ==[spaces[row+2][col+2] intValue] &&
                         0 == [spaces[row+3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == plr &&
                         0 == [spaces[row+1][col+1] intValue] &&
                         0 ==[spaces[row+2][col+2] intValue] &&
                         plr == [spaces[row+3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == plr &&
                         plr == [spaces[row+1][col+1] intValue] &&
                         0 ==[spaces[row+2][col+2] intValue] &&
                         0 == [spaces[row+3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         0 == [spaces[row+1][col+1] intValue] &&
                         plr ==[spaces[row+2][col+2] intValue] &&
                         plr == [spaces[row+3][col+3] intValue])){
                   val++;
               }
        }
        for(int row = 3; row<=5; row++){
            if(       ([spaces[row][col] intValue] == plr &&
                       0 == [spaces[row-1][col+1] intValue] &&
                       plr ==[spaces[row-2][col+2] intValue] &&
                       0 == [spaces[row-3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         plr == [spaces[row-1][col+1] intValue] &&
                         0 ==[spaces[row-2][col+2] intValue] &&
                         plr == [spaces[row-3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         plr == [spaces[row-1][col+1] intValue] &&
                         plr ==[spaces[row-2][col+2] intValue] &&
                         0 == [spaces[row-3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == plr &&
                         0 == [spaces[row-1][col+1] intValue] &&
                         0 ==[spaces[row-2][col+2] intValue] &&
                         plr == [spaces[row-3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == plr &&
                         plr == [spaces[row-1][col+1] intValue] &&
                         0 ==[spaces[row-2][col+2] intValue] &&
                         0 == [spaces[row-3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         0 == [spaces[row-1][col+1] intValue] &&
                         plr ==[spaces[row-2][col+2] intValue] &&
                         plr == [spaces[row-3][col+3] intValue])){
                   val++;
               }
        }
    
    }
    
    return val;
}

- (int) oneOutOfFourLines: (int) plr{
    int val = 0;
    
    // check for 1 out of 4 vertically
    for(int row = 0; row <=2; row++){
        for(int col = 0; col <=6; col++){
            if ([spaces[row][col] intValue] == plr &&
                0 == [spaces[row+1][col] intValue] &&
                0 == [spaces[row+2][col] intValue] &&
                [spaces[row+3][col] intValue] == 0)
                val++;
        }
    }
    
    // check for 1 out of 4 horizontally
    for(int row = 0; row <=5; row++){
        for(int col = 0; col <=3; col++){
            if(       ([spaces[row][col] intValue] == plr &&
                       0 == [spaces[row][col+1] intValue] &&
                       0 ==[spaces[row][col+2] intValue] &&
                       0 == [spaces[row][col+3] intValue])
               
               ||     ([spaces[row][col] intValue] == 0 &&
                       plr == [spaces[row][col+1] intValue] &&
                       0 ==[spaces[row][col+2] intValue] &&
                       0 == [spaces[row][col+3] intValue])
               
               ||     ([spaces[row][col] intValue] == 0 &&
                       0 == [spaces[row][col+1] intValue] &&
                       plr ==[spaces[row][col+2] intValue] &&
                       0 == [spaces[row][col+3] intValue])
               
               ||     ([spaces[row][col] intValue] == 0 &&
                       0 == [spaces[row][col+1] intValue] &&
                       0 ==[spaces[row][col+2] intValue] &&
                       plr == [spaces[row][col+3] intValue])
               ){
                val++;
            }
        }
    }
    
    // check for 1 out of four diagonally
    for(int col = 0; col <=3; col++){
        for(int row = 0; row<=2; row++){
            if(       ([spaces[row][col] intValue] == plr &&
                       0 == [spaces[row+1][col+1] intValue] &&
                       0 ==[spaces[row+2][col+2] intValue] &&
                       0 == [spaces[row+3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         plr == [spaces[row+1][col+1] intValue] &&
                         0 ==[spaces[row+2][col+2] intValue] &&
                         0 == [spaces[row+3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         0 == [spaces[row+1][col+1] intValue] &&
                         plr ==[spaces[row+2][col+2] intValue] &&
                         0 == [spaces[row+3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         0 == [spaces[row+1][col+1] intValue] &&
                         0 ==[spaces[row+2][col+2] intValue] &&
                         plr == [spaces[row+3][col+3] intValue])){
                val++;
            }
        }
        for(int row = 3; row<=5; row++){
            if(       ([spaces[row][col] intValue] == plr &&
                       0 == [spaces[row-1][col+1] intValue] &&
                       0 ==[spaces[row-2][col+2] intValue] &&
                       0 == [spaces[row-3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         plr == [spaces[row-1][col+1] intValue] &&
                         0 ==[spaces[row-2][col+2] intValue] &&
                         0 == [spaces[row-3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         0 == [spaces[row-1][col+1] intValue] &&
                         plr ==[spaces[row-2][col+2] intValue] &&
                         0 == [spaces[row-3][col+3] intValue])
               
               ||       ([spaces[row][col] intValue] == 0 &&
                         0 == [spaces[row-1][col+1] intValue] &&
                         0 ==[spaces[row-2][col+2] intValue] &&
                         plr == [spaces[row-3][col+3] intValue])){
                   val++;
               }
        }
    }
    
    return val;
}

-(id) copyWithZone: (NSZone *) zone
{
    Board *boardCopy = [[Board allocWithZone: zone] init];
    for(int row = 0; row<6; row++){
        for(int col = 0; col<7; col++){
            [boardCopy setSpace:row :col :spaces[row][col]];
        }
    }
    
    return boardCopy;
}

@end
