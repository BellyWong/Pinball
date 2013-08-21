//
//  TablePart.m
//  Pinball
//
//  Created by Martin on 13-8-21.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "TablePart.h"
#import "Helper.h"

@implementation TablePart

-(id) initWithWorld:(b2World*)world position:(CGPoint)pos name:(NSString*)name
{
    if (self = [super initWithShape:name inWorld:world]) {
        // Set the body position
        physicsBody->SetTransform([Helper toMeters:pos], 0.0f);
        
        // Make the body static
        physicsBody->SetType(b2_staticBody);
    }
    return self;
}

+(id) tablePartInWorld:(b2World *)world position:(CGPoint)pos name:(NSString *)name
{
    return [[self alloc] initWithWorld:world position:pos name:name];
}
@end
