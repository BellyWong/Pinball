//
//  PinballTable.m
//  Pinball
//
//  Created by Martin on 13-8-21.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "PinballTableLayer.h"
#import "BodySprite.h"
#import "Constants.h"
#import "Helper.h"
#import "GB2ShapeCache.h"
#import "TableSetup.h"

@implementation PinballTableLayer

-(id) init
{
    if (self = [super init]) {
        // pre load the sprite frames from the texttur atlas
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"pinball.plist"];
        
        // load physics definitions
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"pinball-shapes.plist"];
        
        // init the box2d world
        [self initPhysics];
        
        // load the background from the texture atlas
        CCSprite* background = [CCSprite spriteWithSpriteFrameName:@"background"];
        background.anchorPoint = ccp(0, 0);
        background.position = ccp(0, 0);
        [self addChild:background z:-3];
        
        // Set up table elements
        TableSetup* tableSetup = [TableSetup setupTableWithWorld:world];
        [self addChild:tableSetup z:-1];
        [self scheduleUpdate];
    }
    return self;
}

+(CCScene*) scene
{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [PinballTableLayer node];
    [scene addChild:layer];
    return scene;
}

-(void) initPhysics
{
    b2Vec2 gravity;
    gravity.Set(0.0f, -10.0f);
    world = new b2World(gravity);
    world->SetAllowSleeping(true);
    world->SetContinuousPhysics(true);
    
    contactListener = new ContactListener();
    world->SetContactListener(contactListener);
    
    debugDraw = new GLESDebugDraw();
    world->SetDebugDraw(debugDraw);
    
    uint32 flags = 0;
    flags += b2Draw::e_shapeBit;
    flags += b2Draw::e_jointBit;
    //flags += b2Draw::e_aabbBit;
    //flags += b2Draw::e_pairBit;
    //flags += b2Draw::e_centerOfMassBit;
    debugDraw->SetFlags(flags);
    
    // Define the ground body.
    b2BodyDef groundBodyDef;
    
    // Call the body factory which allocates memory for the ground body
    // from a pool and creates the ground box shape (also from a pool).
    // The body is also added to the world.
    b2Body* groundBody = world->CreateBody(&groundBodyDef);
    
    // Define the ground box shape.
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    float boxWidth = screenSize.width / PTM_RATIO;
    float boxHeight = screenSize.height / PTM_RATIO;
    b2EdgeShape groundBox;
    int density = 0;
    
    // left
    groundBox.Set(b2Vec2(0, boxHeight), b2Vec2(0, 0));
    b2Fixture* left = groundBody->CreateFixture(&groundBox, density);
    // right
    groundBox.Set(b2Vec2(boxWidth, boxHeight), b2Vec2(boxWidth, 0));
    b2Fixture* right = groundBody->CreateFixture(&groundBox, density);
    
    // set the collision flags: category and mask
    b2Filter collisionFilter;
    collisionFilter.groupIndex = 0;
    collisionFilter.categoryBits = 0x0010; // category = Wall
    collisionFilter.maskBits = 0x0001;     // mask = Ball
    left->SetFilterData(collisionFilter);
    right->SetFilterData(collisionFilter);
}

#if DEBUG
-(void) draw
{
    [super draw];
    ccGLEnableVertexAttribs(kCCVertexAttribFlag_Position);
    kmGLPushMatrix();
    world->DrawDebugData();
    kmGLPopMatrix();
}
#endif

-(void) update:(ccTime)delta
{
    //It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(delta, velocityIterations, positionIterations);
}
@end
