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

    CMMotionManager *motion; //Gets in the four types of motion

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        self.backgroundColor = [SKColor brownColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        //self.physicsBody.categoryBitMask = edgeCategory;
        self.physicsWorld.contactDelegate = self; //Might need for later
    
        motion = [[CMMotionManager alloc] init];
        
        [self addBall:size];
        [self addWalls:size];
        [self addHoles:size];
        [self startGame];
    }
    return self;
}

-(void) addBall:(CGSize) size
{
    self.ball = [SKSpriteNode spriteNodeWithImageNamed:@"MazeBall.png"];
    [self addChild:self.ball];
}

-(void) addWalls:(CGSize) size
{
    SKSpriteNode *topWall = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(765, 8)];
    [topWall setPosition:CGPointMake(384, 950)];
    [self addChild:topWall];
    
    SKSpriteNode *middleLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(435, 8)];
    [middleLeft setPosition:CGPointMake(55, 470)]; //Horizontal middle left line
    [self addChild:middleLeft];
    
    SKSpriteNode *bottomLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 350)];
    [bottomLeft setPosition:CGPointMake(140, 175)]; //Vertical bottom left line
    [self addChild:bottomLeft];
    
    SKSpriteNode *topLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 350)];
    [topLeft setPosition:CGPointMake(140, 775)]; //Vertical top left line
    [self addChild:topLeft];
    
    SKSpriteNode *bottomRight = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 700)];
    [bottomRight setPosition:CGPointMake(630, 150)]; //Vertical bottom right line
    [self addChild:bottomRight];
    
    SKSpriteNode *bottomMiddle2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(330, 8)];
    [bottomMiddle2 setPosition:CGPointMake(305, 230)]; //Horizontal middle bottom 2 line
    [self addChild:bottomMiddle2];
    
    SKSpriteNode *bottomMiddle1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(330, 8)];
    [bottomMiddle1 setPosition:CGPointMake(465, 110)]; //Horizontal middle bottom 1 line
    [self addChild:bottomMiddle1];
    
    SKSpriteNode *leftMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 500)];
    [leftMiddle setPosition:CGPointMake(270, 600)]; //Vertical middle left line
    [self addChild:leftMiddle];
    
    SKSpriteNode *topMiddle1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(380, 8)];
    [topMiddle1 setPosition:CGPointMake(456, 847)]; //Horizontal top middle line
    [self addChild:topMiddle1];
    
    SKSpriteNode *topMiddle2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 250)];
    [topMiddle2 setPosition:CGPointMake(385, 620)]; //Vertical top middle line
    [self addChild:topMiddle2];
    
    SKSpriteNode *middleRight1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [middleRight1 setPosition:CGPointMake(506, 745)]; //Horizontal middle right line
    [self addChild:middleRight1];
    
    SKSpriteNode *middleRight2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [middleRight2 setPosition:CGPointMake(505, 496)]; //Horizontal middle lower right line
    [self addChild:middleRight2];
    
    SKSpriteNode *rightMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [rightMiddle setPosition:CGPointMake(645, 620)]; //Horizontal middle lower right line
    [self addChild:rightMiddle];
    
    SKSpriteNode *bottomMiddle3 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [bottomMiddle3 setPosition:CGPointMake(391, 350)]; //Horizontal right middle line
    [self addChild:bottomMiddle3];
    

}


-(void) addHoles:(CGSize) size
{
    //self.ball = [SKSpriteNode spriteNodeWithImageNamed:@"MazeBall.png"];
    //[self addChild:self.ball];
}


- (void)startGame
{
    self.ball.hidden = NO;   //reset ball position for new game
    self.ball.physicsBody = [SKPhysicsBody bodyWithTexture:self.ball.texture size:self.ball.texture.size];
    CGPoint ballPoint = CGPointMake(170,400);
    self.ball.position = ballPoint; 
    self.ball.physicsBody.dynamic = YES; //Not sitting still
    self.ball.physicsBody.affectedByGravity = NO; //Not affected
    self.ball.physicsBody.mass = 0.02; //Give mass
    
    //setup to handle accelerometer readings using CoreMotion Framework
    [self startAccelerationOn]; //Yeah not sure
    
}

- (void)startAccelerationOn
{
    if (motion.accelerometerAvailable)
    {
        [motion startAccelerometerUpdates];
        NSLog(@"on");
    }
}

- (void)stopAccelerationOff
{
    if (motion.accelerometerAvailable && motion.accelerometerActive)
    {
        [motion stopAccelerometerUpdates];
        NSLog(@"off");
    }
}

- (void)updateBallPosition
{
    CMAccelerometerData* data = motion.accelerometerData;
    if (fabs(data.acceleration.x) > 0.2)
    {
        NSLog(@"acceleration value = %f", data.acceleration.x);
        [self.ball.physicsBody applyForce:CGVectorMake(50.0 * data.acceleration.x, 50.0 * data.acceleration.y)];
    }
}

-(void)update:(NSTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    
    //Update the ball position
    [self updateBallPosition];
}

@end
