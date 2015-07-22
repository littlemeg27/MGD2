//
//  GameScene.m
//  MGDProject3
//
//  Created by Brenna Pavlinchak on 7/20/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "GameScene.h"

@interface GameScene ()

@property (nonatomic) SKSpriteNode *ball;

@end

@import CoreMotion;

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
        [self startGame];
    }
    return self;
}

-(void) addBall:(CGSize) size
{
    self.ball = [SKSpriteNode spriteNodeWithImageNamed:@"MainBall.png"];
    [self addChild:self.ball];
}

- (void)startGame
{
    self.ball.hidden = NO;   //reset ball position for new game
    self.ball.physicsBody = [SKPhysicsBody bodyWithTexture:self.ball.texture size:self.ball.texture.size];
    CGPoint ballPoint = CGPointMake(170,600);
    self.ball.position = ballPoint;
    
    //setup to handle accelerometer readings using CoreMotion Framework
    //[self startMonitoringAcceleration]; //Yeah not sure
    
}


-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
}

@end
