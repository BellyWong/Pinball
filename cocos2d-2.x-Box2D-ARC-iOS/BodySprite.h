//
//  BodySprite.h
//  PinBall
//
//  Created by Martin on 13-8-21.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PhysicsSprite.h"
#import "GB2ShapeCache.h"
#import "Helper.h"
#import "Constants.h"

@interface BodySprite : PhysicsSprite {
    
}

/**
 * Creates a new shape
 * @param inWorld: Pointer to the world object to add the sprite to
 * @return BodySprite object
 */
-(id) initWithShape:(NSString*)shapeName inWorld:(b2World*)world;

/**
 * Changes the body's shape
 * Removes the fixtures of the body replacing them
 * with the new ones
 * @param shapeName name of t he shape to set
 */
-(void) setBodyShape:(NSString*)shapeName;

@end
