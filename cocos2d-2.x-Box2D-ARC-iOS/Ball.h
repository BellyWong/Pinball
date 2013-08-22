//
//  Ball.h
//  Pinball
//
//  Created by Martin on 13-8-22.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodySprite.h"

@interface Ball : BodySprite <CCTargetedTouchDelegate>
{
    BOOL moveToFinger;
    CGPoint fingerLocation;
}
+(id) ballWithWorld:(b2World*)world;
@end
