//
//  Flipper.mm
//  Pinball
//
//  Created by Martin on 13-8-22.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "Flipper.h"


@implementation Flipper

-(id) initWithWorld:(b2World*)world flipperType:(EFlipperType)flipperType
{
    NSString* name = (flipperType == kFLipperLeft) ? @"flipper-left" : @"flipper-right";
    if (self = [super initWithShape:name inWorld:world]) {
        type = flipperType;
        
        // set the position depending on the left or right side
        CGPoint flipperPos = (type == kFlipperRight) ? ccp(210, 65) : ccp(90, 65);
        
        // attach the flipper to a static body with a revolute joint
        [self attachFlipperAt:[Helper toMeters:flipperPos]];
        
        // receive touch events
        [[CCDirector sharedDirector].touchDispatcher addTargetedDelegate:self priority:0 swallowsTouches:NO];
    }
    return self;
}

+(id) flipperWithWorld:(b2World *)world flipperType:(EFlipperType)flipperType
{
    return [[self alloc] initWithWorld:world flipperType:flipperType];
}

-(void) cleanup
{
    [super cleanup];
    
    // stop listening to touches
    [[CCDirector sharedDirector].touchDispatcher removeDelegate:self];
}

-(void) attachFlipperAt:(b2Vec2)pos
{
    physicsBody->SetTransform(pos, 0);
    physicsBody->SetType(b2_dynamicBody);
    
    // turn on continous collision detection to prevent tunneling
    physicsBody->SetBullet(true);
    
    // create an invisible static body to attach to
    b2BodyDef bodyDef;
    bodyDef.position = pos;
    b2Body* staticBody = physicsBody->GetWorld()->CreateBody(&bodyDef);
    
    // setup joint parameters
    b2RevoluteJointDef jointDef;
    jointDef.Initialize(staticBody, physicsBody, staticBody->GetWorldCenter());
    jointDef.lowerAngle = 0.0f;
    jointDef.upperAngle = CC_DEGREES_TO_RADIANS(70);
    jointDef.enableLimit = true;
    jointDef.maxMotorTorque = 100.0f;
    jointDef.motorSpeed = -40.0f;
    jointDef.enableMotor = true;
    
    if (type == kFlipperRight) {
        // mirror speed and angle for the right flipper
        jointDef.motorSpeed *= -1;
        jointDef.lowerAngle = -jointDef.upperAngle;
        jointDef.upperAngle = 0.0f;
    }
    // create the joint
    joint = (b2RevoluteJoint*)physicsBody->GetWorld()->CreateJoint(&jointDef);

}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    BOOL touchHandled = NO;
    
    CGPoint location = [Helper locationFromTouch:touch];
    if ([self isTouchForMe:location]) {
        touchHandled = YES;
        [self reverseMotor];
    }
    
    return touchHandled;
}

-(BOOL) isTouchForMe:(CGPoint)location
{
    if (type == kFLipperLeft && location.x < [Helper screenCenter].x) {
        return YES;
    }
    else if (type == kFlipperRight && location.x > [Helper screenCenter].x)
    {
        return YES;
    }
    return NO;
}

-(void) reverseMotor
{
    joint->SetMotorSpeed(joint->GetMotorSpeed() * -1);
}
@end
