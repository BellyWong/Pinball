//
//  TableSetup.h
//  Pinball
//
//  Created by Martin on 13-8-21.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"

@interface TableSetup : CCSpriteBatchNode {
    
}
+(id) setupTableWithWorld:(b2World*)world;
@end
