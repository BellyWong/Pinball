//
//  Plunger.h
//  Pinball
//
//  Created by Martin on 13-8-22.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodySprite.h"

@interface Plunger : BodySprite {
    b2PrismaticJoint* joint;
}

+(id) plungerWithWorld:(b2World*)world;

@end
