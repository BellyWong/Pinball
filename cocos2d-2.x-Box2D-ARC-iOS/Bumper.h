//
//  Bumper.h
//  Pinball
//
//  Created by Martin on 13-8-22.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BodySprite.h"

@interface Bumper : BodySprite {
    
}
+(id) bumperWithWorld:(b2World*)world position:(CGPoint)pos;
@end
