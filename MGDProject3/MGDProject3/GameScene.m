//
//  GameScene.m
//  MGDProject3
//
//  Created by Brenna Pavlinchak on 7/20/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

@import CoreMotion;

#import "GameScene.h"

@implementation GameScene

    CMMotionManager *motionManager; //Gets in the four types of motion

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        self.backgroundColor = [SKColor brownColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        //self.physicsBody.categoryBitMask = edgeCategory;
        self.physicsWorld.contactDelegate = self; //Might need for later
    
        motionManager = [[CMMotionManager alloc] init];
        
        [self addBall:size];
    }
    return self;
}

-(void) addBall:(CGSize) size
{
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"MainBall.png"];
    [self addChild:ball];
}


-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
}

@end
