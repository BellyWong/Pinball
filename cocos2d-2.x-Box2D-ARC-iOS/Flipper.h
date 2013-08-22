//
//  Flipper.h
//  Pinball
//
//  Created by Martin on 13-8-22.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodySprite.h"

typedef enum {
    kFLipperLeft,
    kFlipperRight,
} EFlipperType;

@interface Flipper : BodySprite <CCTargetedTouchDelegate>
{
    EFlipperType type;
    b2RevoluteJoint* joint;
    float totalTime;
}

+(id) flipperWithWorld:(b2World*)world flipperType:(EFlipperType)flipperType;

@end
