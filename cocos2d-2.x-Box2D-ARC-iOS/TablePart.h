//
//  TablePart.h
//  Pinball
//
//  Created by Martin on 13-8-21.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//
#import "BodySprite.h"

@interface TablePart : BodySprite {
    
}
+(id) tablePartInWorld:(b2World*)world position:(CGPoint)pos name:(NSString*)name;
@end
