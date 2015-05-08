//
//  Board.h
//  ConnectFour
//
//  Created by Scott McAllister on 2/19/2014.
//  Copyright (c) 2014 Scott McAllister. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Board : NSObject <NSCopying>{
    NSNumber *spaces[6][7];
}
- (void) setSpace: (int) row :(int) col :(NSNumber*) val;
- (NSNumber*) space: (int) row :(int) col;
- (int) piecesInColumn: (int) col;
- (NSNumber*) winner;
- (void) addToColumn: (int) col :(int) plr;
- (void) printBoard;
- (int) score: (int) plr;
- (int) threeOutOfFourLines: (int) plr;
- (int) twoOutOfFourLines: (int) plr;
- (int) oneOutOfFourLines: (int) plr;
- (id) copyWithZone: (NSZone *) zone;
@end
