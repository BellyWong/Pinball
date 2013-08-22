//
//  TableSetup.mm
//  Pinball
//
//  Created by Martin on 13-8-21.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "TableSetup.h"
#import "Ball.h"
#import "TablePart.h"


@implementation TableSetup

-(id) initTableWithWorld:(b2World*)world
{
    if (self = [super initWithFile:@"pinball.pvr.ccz" capacity:5]) {
        // add the table blocks
        [self addChild:[TablePart tablePartInWorld:world position:ccp(0, 480) name:@"table-top"]];
        [self addChild:[TablePart tablePartInWorld:world position:ccp(0, 0)   name:@"table-bottom"]];
        [self addChild:[TablePart tablePartInWorld:world position:ccp(0, 263) name:@"table-left"]];
        
        Ball* ball = [Ball ballWithWorld:world];
        [self addChild:ball z:-1];
    }
    return self;
}

+(id) setupTableWithWorld:(b2World *)world
{
    return [[self alloc] initTableWithWorld:world];
}

@end
