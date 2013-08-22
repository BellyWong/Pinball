//
//  Ball.mm
//  Pinball
//
//  Created by Martin on 13-8-22.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"


@implementation Ball

-(id) initWithWorld:(b2World*)world
{
    if (self = [super initWithShape:@"ball" inWorld:world]) {
        // set the parameters
        physicsBody->SetType(b2_dynamicBody);
        physicsBody->SetAngularDamping(0.9f);
        
        // set random starting point
        [self setBallStartPosition];
        // enable handling touches
        [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:0 swallowsTouches:NO];
        // schedule updates
        [self scheduleUpdate];
    }
    return self;
}

-(void) cleanup
{
    [super cleanup];
    [[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
}

+(id) ballWithWorld:(b2World *)world
{
    return [[self alloc] initWithWorld:world];
}

-(void) setBallStartPosition
{
    // set the ball's position
    float randomOffset = CCRANDOM_0_1() * 10.0f - 5.0f;
    CGPoint startPos = CGPointMake(305 + randomOffset, 80);
    
    physicsBody->SetTransform([Helper toMeters:startPos], 0.0f);
    physicsBody->SetLinearVelocity(b2Vec2_zero);
    physicsBody->SetAngularVelocity(0.0f);
}

-(void) update:(ccTime)delta
{
    if (moveToFinger == YES)
    {
        [self applyForceTowardsFinger];
    }
    if (self.position.y < -(self.contentSize.height * 10)) {
        [self setBallStartPosition];
    }
    
    // limit spedd of the ball
    const float32 maxSpeed = 6.0f;
    b2Vec2 velocity = physicsBody->GetLinearVelocity();
    float32 speed = velocity.Length();
    if (speed > maxSpeed) {
        velocity.Normalize();
        physicsBody->SetLinearVelocity(maxSpeed * velocity);
    }
    
    // reset rotation of the ball
    physicsBody->SetTransform(physicsBody->GetWorldCenter(), 0.0f);
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    moveToFinger = YES;
    fingerLocation = [Helper locationFromTouch:touch];
    return YES;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    fingerLocation = [Helper locationFromTouch:touch];
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    moveToFinger = NO;
}

-(void) applyForceTowardsFinger
{
    b2Vec2 bodyPos = physicsBody->GetWorldCenter();
    b2Vec2 fingerPos = [Helper toMeters:fingerLocation];
    
    b2Vec2 bodyToFingerDirection = fingerPos - bodyPos;
    bodyToFingerDirection.Normalize();
    
    b2Vec2 force = 2.0f * bodyToFingerDirection;
    physicsBody->ApplyForce(force, physicsBody->GetWorldCenter());
}
@end
