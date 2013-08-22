//
//  PinballTable.m
//  Pinball
//
//  Created by Martin on 13-8-21.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PinballTable.h"
#import "BodySprite.h"
#import "Constants.h"
#import "Helper.h"
#import "GB2ShapeCache.h"
#import "TableSetup.h"

@implementation PinballTable : CCLayer

-(id) init
{
    if (self = [super init]) {
        // pre load the sprite frames from the texttur atlas
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pinball.plist"];
    }
}

@end
