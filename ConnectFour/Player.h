//
//  Player.h
//  ConnectFour
//
//  Created by Scott McAllister on 2/19/2014.
//  Copyright (c) 2014 Scott McAllister. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject{
    NSString *name;
    int number;
}

- (NSString*) name;
- (int) number;
- (void) setName: (NSString*) newName;
- (void) setNumber: (int) newNumber;


@end
