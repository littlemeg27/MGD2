//
//  GameScene.m
//  MGDProject3
//
//  Created by Brenna Pavlinchak on 7/20/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "GameScene.h"

@interface GameScene ()

@property (nonatomic) SKShapeNode *ball;

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
    float radius = 28;
    self.ball = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint = CGPointMake(size.width/2,size.height/2);
    self.ball.position = ballPoint;
    self.ball.fillColor = [SKColor redColor];
    self.ball.strokeColor = [SKColor redColor];
    [self addChild:self.ball];
}

-(void) addWalls:(CGSize) size
{
    SKSpriteNode *topWall = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(765, 8)];
    [topWall setPosition:CGPointMake(384, 950)];
    topWall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topWall.frame.size];
    topWall.physicsBody.dynamic =  NO;
    [self addChild:topWall];
    
    SKSpriteNode *middleLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(435, 8)];
    [middleLeft setPosition:CGPointMake(55, 470)]; //Horizontal middle left line
    middleLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleLeft.frame.size];
    middleLeft.physicsBody.dynamic =  NO;
    [self addChild:middleLeft];
    
    SKSpriteNode *bottomLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 350)];
    [bottomLeft setPosition:CGPointMake(140, 175)]; //Vertical bottom left line
    bottomLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomLeft.frame.size];
    bottomLeft.physicsBody.dynamic =  NO;
    [self addChild:bottomLeft];
    
    SKSpriteNode *topLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 350)];
    [topLeft setPosition:CGPointMake(140, 775)]; //Vertical top left line
    topLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topLeft.frame.size];
    topLeft.physicsBody.dynamic =  NO;
    [self addChild:topLeft];
    
    SKSpriteNode *bottomRight = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 700)];
    [bottomRight setPosition:CGPointMake(630, 150)]; //Vertical bottom right line
    bottomRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRight.frame.size];
    bottomRight.physicsBody.dynamic =  NO;
    [self addChild:bottomRight];
    
    SKSpriteNode *bottomMiddle2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(330, 8)];
    [bottomMiddle2 setPosition:CGPointMake(305, 230)]; //Horizontal middle bottom 2 line
    bottomMiddle2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomMiddle2.frame.size];
    bottomMiddle2.physicsBody.dynamic =  NO;
    [self addChild:bottomMiddle2];
    
    SKSpriteNode *bottomMiddle1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(330, 8)];
    [bottomMiddle1 setPosition:CGPointMake(465, 110)]; //Horizontal middle bottom 1 line
    bottomMiddle1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomMiddle1.frame.size];
    bottomMiddle1.physicsBody.dynamic =  NO;
    [self addChild:bottomMiddle1];
    
    SKSpriteNode *leftMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 500)];
    [leftMiddle setPosition:CGPointMake(270, 600)]; //Vertical middle left line
    leftMiddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftMiddle.frame.size];
    leftMiddle.physicsBody.dynamic =  NO;
    [self addChild:leftMiddle];
    
    SKSpriteNode *topMiddle1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(380, 8)];
    [topMiddle1 setPosition:CGPointMake(456, 847)]; //Horizontal top middle line
    topMiddle1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topMiddle1.frame.size];
    topMiddle1.physicsBody.dynamic =  NO;
    [self addChild:topMiddle1];
    
    SKSpriteNode *topMiddle2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 250)];
    [topMiddle2 setPosition:CGPointMake(385, 620)]; //Vertical top middle line
    topMiddle2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topMiddle2.frame.size];
    topMiddle2.physicsBody.dynamic =  NO;
    [self addChild:topMiddle2];
    
    SKSpriteNode *middleRight1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [middleRight1 setPosition:CGPointMake(506, 745)]; //Horizontal middle right line
    middleRight1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleRight1.frame.size];
    middleRight1.physicsBody.dynamic =  NO;
    [self addChild:middleRight1];
    
    SKSpriteNode *middleRight2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [middleRight2 setPosition:CGPointMake(505, 496)]; //Horizontal middle lower right line
    middleRight2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleRight2.frame.size];
    middleRight2.physicsBody.dynamic =  NO;
    [self addChild:middleRight2];
    
    SKSpriteNode *rightMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [rightMiddle setPosition:CGPointMake(645, 620)]; //Horizontal middle lower right line
    rightMiddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightMiddle.frame.size];
    rightMiddle.physicsBody.dynamic =  NO;
    [self addChild:rightMiddle];
    
    SKSpriteNode *bottomMiddle3 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [bottomMiddle3 setPosition:CGPointMake(391, 350)]; //Horizontal right middle line
    bottomMiddle3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomMiddle3.frame.size];
    bottomMiddle3.physicsBody.dynamic =  NO;
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
    self.ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.ball.frame.size.width/2];
    CGPoint ballPoint = CGPointMake(75,875);
    self.ball.position = ballPoint; 
    self.ball.physicsBody.dynamic = YES; //Not sitting still
    self.ball.physicsBody.affectedByGravity = NO; //Not affected
    self.ball.physicsBody.mass = 0.05; //Give mass
    
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
