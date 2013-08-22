//
//  TableSetup.mm
//  Pinball
//
//  Created by Martin on 13-8-21.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "TableSetup.h"
#import "Ball.h"
#import "Bumper.h"
#import "Plunger.h"
#import "Flipper.h"
#import "TablePart.h"

@implementation TableSetup

-(id) initTableWithWorld:(b2World*)world
{
    if (self = [super initWithFile:@"pinball.pvr.ccz" capacity:5]) {
        // add the table blocks
        [self addChild:[TablePart tablePartInWorld:world position:ccp(0, 480) name:@"table-top"]];
        [self addChild:[TablePart tablePartInWorld:world position:ccp(0, 0)   name:@"table-bottom"]];
        [self addChild:[TablePart tablePartInWorld:world position:ccp(0, 263) name:@"table-left"]];
        
        // add the ball
        Ball* ball = [Ball ballWithWorld:world];
        [self addChild:ball z:-1];
        
        // add the bumpers
        [self addBumperAt:ccp(76, 405) inWorld:world];
        [self addBumperAt:ccp(158, 415) inWorld:world];
        [self addBumperAt:ccp(239, 375) inWorld:world];
        [self addBumperAt:ccp(83, 341) inWorld:world];
        [self addBumperAt:ccp(157, 294) inWorld:world];
        [self addBumperAt:ccp(260, 286) inWorld:world];
        [self addBumperAt:ccp(67, 228) inWorld:world];
        [self addBumperAt:ccp(183, 186) inWorld:world];
        
        // add the plunger
        Plunger* plunger = [Plunger plungerWithWorld:world];
        [self addChild:plunger z:-1];
        
        // add the flippers
        Flipper* left = [Flipper flipperWithWorld:world flipperType:kFLipperLeft];
        [self addChild:left];
        
        Flipper* right = [Flipper flipperWithWorld:world flipperType:kFlipperRight];
        [self addChild:right];
    }
    return self;
}

+(id) setupTableWithWorld:(b2World *)world
{
    return [[self alloc] initTableWithWorld:world];
}

-(void) addBumperAt:(CGPoint)pos inWorld:(b2World*)world
{
    Bumper* bumper = [Bumper bumperWithWorld:world position:pos];
    [self addChild:bumper];
}

@end
