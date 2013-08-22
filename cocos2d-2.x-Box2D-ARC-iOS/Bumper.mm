//
//  Bumper.m
//  Pinball
//
//  Created by Martin on 13-8-22.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Bumper.h"


@implementation Bumper

-(id) initWithWorld:(b2World*)world position:(CGPoint)pos
{
    if (self = [super initWithShape:@"bumper" inWorld:world]) {
        physicsBody->SetTransform([Helper toMeters:pos], 0.0f);
    }
    return self;
}

+(id) bumperWithWorld:(b2World *)world position:(CGPoint)pos
{
    return [[self alloc] initWithWorld:world position:pos];
}

@end
