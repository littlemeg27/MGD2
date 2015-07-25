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
@property (nonatomic) SKSpriteNode *topWall;
@property (nonatomic) SKSpriteNode *topLeft;
@property (nonatomic) SKSpriteNode *bottomLeft;
@property (nonatomic) SKSpriteNode *middleLeft;
@property (nonatomic) SKSpriteNode *bottomRight;
@property (nonatomic) SKSpriteNode *bottomMiddle2;
@property (nonatomic) SKSpriteNode *bottomMiddle1;
@property (nonatomic) SKSpriteNode *leftMiddle;
@property (nonatomic) SKSpriteNode *topRight;
@property (nonatomic) SKSpriteNode *topMiddle;

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
    self.topWall = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(765, 8)];
    [self.topWall setPosition:CGPointMake(384, 950)];
    [self addChild:self.topWall];
    
    self.middleLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(435, 8)];
    [self.middleLeft setPosition:CGPointMake(50, 470)]; //Horizontal middle left line
    [self addChild:self.middleLeft];
    
    self.bottomLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 350)];
    [self.bottomLeft setPosition:CGPointMake(140, 150)]; //Vertical bottom left line
    [self addChild:self.bottomLeft];
    
    self.topLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 350)];
    [self.topLeft setPosition:CGPointMake(140, 775)]; //Vertical top left line
    [self addChild:self.topLeft];
    
    self.bottomRight = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 700)];
    [self.bottomRight setPosition:CGPointMake(630, 150)]; //Vertical bottom right line
    [self addChild:self.bottomRight];
    
    self.bottomMiddle2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(300, 8)];
    [self.bottomMiddle2 setPosition:CGPointMake(290, 230)]; //Horizontal middle bottom 2 line
    [self addChild:self.bottomMiddle2];
    
    self.bottomMiddle1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(300, 8)];
    [self.bottomMiddle1 setPosition:CGPointMake(480, 110)]; //Horizontal middle bottom 1 line
    [self addChild:self.bottomMiddle1];
    
    self.leftMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 500)];
    [self.leftMiddle setPosition:CGPointMake(270, 600)]; //Vertical middle left line
    [self addChild:self.leftMiddle];
    
    self.topRight = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(380, 8)];
    [self.topRight setPosition:CGPointMake(462, 846)]; //Horizontal top middle line 1
    [self addChild:self.topRight];
    
    self.topMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 250)];
    [self.topMiddle setPosition:CGPointMake(385, 590)]; //Vertical top middle line 2
    [self addChild:self.topMiddle];
    
    /*self.topLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 250)];
    [self.topLeft setPosition:CGPointMake(650, 728)]; //Vertical top right line
    [self addChild:self.topLeft];*/
    

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
