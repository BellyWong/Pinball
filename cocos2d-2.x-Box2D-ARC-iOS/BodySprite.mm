//
//  BodySprite.mm
//  PinBall
//
//  Created by Martin on 13-8-21.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "BodySprite.h"


@implementation BodySprite

-(id) initWithShape:(NSString *)shapeName inWorld:(b2World *)world
{
    NSAssert(world != NULL, @"world is null!");
    NSAssert(shapeName != nil, @"name is nil!");
    
    // init the sprite itself with the given shape name
    if (self = [super initWithSpriteFrameName:shapeName]) {
        // create the body
        b2BodyDef bodyDef;
        physicsBody = world->CreateBody(&bodyDef);
        physicsBody->SetUserData((__bridge void*)self);
        
        // set the shape
        [self setBodyShape:shapeName];
    }
    return self;
}

-(void) setBodyShape:(NSString *)shapeName
{
    // remove any existing fixtures from the body
    b2Fixture* fixture;
    while ((fixture = physicsBody->GetFixtureList())) {
        physicsBody->DestroyFixture(fixture);
    }
    
    // attach a new shape from the shape cache
    if (shapeName) {
        GB2ShapeCache* shapeCache = [GB2ShapeCache sharedShapeCache];
        [shapeCache addFixturesToBody:physicsBody forShapeName:shapeName];
        
        // Assign the shape's anchorPoint (the blue + in a circle in PhysicsEditor)
        // as the BodySprite's anchorPoint. Otherwise image and shape would be offset.
        self.anchorPoint = [shapeCache anchorPointForShape:shapeName];
    }
}

-(void) dealloc
{
    // remove the body from the world
    physicsBody->GetWorld()->DestroyBody(physicsBody);
}

@end
