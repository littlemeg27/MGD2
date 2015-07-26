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
@property (nonatomic) SKShapeNode *hole1;
@property (nonatomic) SKShapeNode *hole2;
@property (nonatomic) SKShapeNode *hole3;
@property (nonatomic) SKShapeNode *hole4;
@property (nonatomic) SKShapeNode *hole5;
@property (nonatomic) SKShapeNode *hole6;
@property (nonatomic) SKShapeNode *hole7;
@property (nonatomic) SKShapeNode *hole8;
@property (nonatomic) SKLabelNode *countDown;
@property (nonatomic) BOOL startGamePlay;
@property (nonatomic) NSTimeInterval startTime;

//@property (SK_NONATOMIC_IOSONLY, getter = isPaused) BOOL paused;

@end

static const uint32_t holeCategory = 0;
static const uint32_t wallCategory = 1;
static const uint32_t edgeCategory = 2;
static const uint32_t ballCategory = 4;

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
        self.physicsBody.categoryBitMask = edgeCategory;
        self.physicsWorld.contactDelegate = self; //Might need for later
    
        motion = [[CMMotionManager alloc] init];
        
        SKLabelNode *startLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        startLabel.text = @"Start";
        startLabel.fontSize = 20;
        startLabel.position = CGPointMake(70, 900);
        
        SKLabelNode *endLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        endLabel.text = @"End";
        endLabel.fontSize = 20;
        endLabel.position = CGPointMake(70, 50);
        
        self.countDown = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.countDown.fontSize = 70;
        self.countDown.position = CGPointMake(CGRectGetMidX(self.frame),
                                         CGRectGetMaxY(self.frame)*0.85);
        //self.countDown.verticalAlignment = SKVerticalAlignmentCenter;
        self.countDown.fontColor = [SKColor whiteColor ];
        self.countDown.name = @"countDown";
        self.countDown.zPosition = 100;
        [self addChild:self.countDown];
        
        [self addChild:self.countDown];
        [self addChild:startLabel];
        [self addChild:endLabel];
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
    self.ball.strokeColor = [SKColor blackColor];
    self.ball.physicsBody.categoryBitMask = ballCategory;
    self.ball.physicsBody.contactTestBitMask = edgeCategory | wallCategory | holeCategory;
    [self addChild:self.ball];
}

-(void) addWalls:(CGSize) size
{
    SKSpriteNode *topWall = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(765, 8)];
    [topWall setPosition:CGPointMake(384, 950)];
    topWall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topWall.frame.size];
    topWall.physicsBody.dynamic =  NO;
    topWall.physicsBody.categoryBitMask = wallCategory;
    topWall.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:topWall];
    
    SKSpriteNode *middleLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(435, 8)];
    [middleLeft setPosition:CGPointMake(55, 470)]; //Horizontal middle left line
    middleLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleLeft.frame.size];
    middleLeft.physicsBody.dynamic =  NO;
    middleLeft.physicsBody.categoryBitMask = wallCategory;
    middleLeft.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:middleLeft];
    
    SKSpriteNode *bottomLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 350)];
    [bottomLeft setPosition:CGPointMake(140, 175)]; //Vertical bottom left line
    bottomLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomLeft.frame.size];
    bottomLeft.physicsBody.dynamic =  NO;
    bottomLeft.physicsBody.categoryBitMask = wallCategory;
    bottomLeft.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:bottomLeft];
    
    SKSpriteNode *topLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 350)];
    [topLeft setPosition:CGPointMake(140, 775)]; //Vertical top left line
    topLeft.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topLeft.frame.size];
    topLeft.physicsBody.dynamic =  NO;
    topLeft.physicsBody.categoryBitMask = wallCategory;
    topLeft.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:topLeft];
    
    SKSpriteNode *bottomRight = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 700)];
    [bottomRight setPosition:CGPointMake(630, 150)]; //Vertical bottom right line
    bottomRight.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomRight.frame.size];
    bottomRight.physicsBody.dynamic =  NO;
    bottomRight.physicsBody.categoryBitMask = wallCategory;
    bottomRight.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:bottomRight];
    
    SKSpriteNode *bottomMiddle2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(330, 8)];
    [bottomMiddle2 setPosition:CGPointMake(305, 230)]; //Horizontal middle bottom 2 line
    bottomMiddle2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomMiddle2.frame.size];
    bottomMiddle2.physicsBody.dynamic =  NO;
    bottomMiddle2.physicsBody.categoryBitMask = wallCategory;
    bottomMiddle2.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:bottomMiddle2];
    
    SKSpriteNode *bottomMiddle1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(330, 8)];
    [bottomMiddle1 setPosition:CGPointMake(465, 110)]; //Horizontal middle bottom 1 line
    bottomMiddle1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomMiddle1.frame.size];
    bottomMiddle1.physicsBody.dynamic =  NO;
    bottomMiddle1.physicsBody.categoryBitMask = wallCategory;
    bottomMiddle1.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:bottomMiddle1];
    
    SKSpriteNode *leftMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 500)];
    [leftMiddle setPosition:CGPointMake(270, 600)]; //Vertical middle left line
    leftMiddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:leftMiddle.frame.size];
    leftMiddle.physicsBody.dynamic =  NO;
    leftMiddle.physicsBody.categoryBitMask = wallCategory;
    leftMiddle.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:leftMiddle];
    
    SKSpriteNode *topMiddle1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(380, 8)];
    [topMiddle1 setPosition:CGPointMake(456, 847)]; //Horizontal top middle line
    topMiddle1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topMiddle1.frame.size];
    topMiddle1.physicsBody.dynamic =  NO;
    topMiddle1.physicsBody.categoryBitMask = wallCategory;
    topMiddle1.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:topMiddle1];
    
    SKSpriteNode *topMiddle2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(8, 250)];
    [topMiddle2 setPosition:CGPointMake(385, 620)]; //Vertical top middle line
    topMiddle2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:topMiddle2.frame.size];
    topMiddle2.physicsBody.dynamic =  NO;
    topMiddle2.physicsBody.categoryBitMask = wallCategory;
    topMiddle2.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:topMiddle2];
    
    SKSpriteNode *middleRight1 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [middleRight1 setPosition:CGPointMake(506, 745)]; //Horizontal middle right line
    middleRight1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleRight1.frame.size];
    middleRight1.physicsBody.dynamic =  NO;
    middleRight1.physicsBody.categoryBitMask = wallCategory;
    middleRight1.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:middleRight1];
    
    SKSpriteNode *middleRight2 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [middleRight2 setPosition:CGPointMake(505, 496)]; //Horizontal middle lower right line
    middleRight2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:middleRight2.frame.size];
    middleRight2.physicsBody.dynamic =  NO;
    middleRight2.physicsBody.categoryBitMask = wallCategory;
    middleRight2.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:middleRight2];
    
    SKSpriteNode *rightMiddle = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [rightMiddle setPosition:CGPointMake(645, 620)]; //Horizontal middle lower right line
    rightMiddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rightMiddle.frame.size];
    rightMiddle.physicsBody.dynamic =  NO;
    rightMiddle.physicsBody.categoryBitMask = wallCategory;
    rightMiddle.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:rightMiddle];
    
    SKSpriteNode *bottomMiddle3 = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(250, 8)];
    [bottomMiddle3 setPosition:CGPointMake(391, 350)]; //Horizontal right middle line
    bottomMiddle3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bottomMiddle3.frame.size];
    bottomMiddle3.physicsBody.dynamic =  NO;
    bottomMiddle3.physicsBody.categoryBitMask = wallCategory;
    bottomMiddle3.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:bottomMiddle3];
}


-(void) addHoles:(CGSize) size
{
    float radius = 32;
    self.hole1 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint1 = CGPointMake(35,510);
    self.hole1.position = ballPoint1;
    self.hole1.fillColor = [SKColor grayColor]; //Right after start left corner
    self.hole1.strokeColor = [SKColor blackColor]; //Hole 1
    self.hole1.physicsBody.categoryBitMask = holeCategory;
    self.hole1.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:self.hole1];
    
    self.hole2 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint2 = CGPointMake(230,510);
    self.hole2.position = ballPoint2;
    self.hole2.fillColor = [SKColor grayColor]; //Right after start right corner
    self.hole2.strokeColor = [SKColor blackColor]; //Hole 2
    self.hole2.physicsBody.categoryBitMask = holeCategory;
    self.hole2.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:self.hole2];
    
    self.hole3 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint3 = CGPointMake(180,910);
    self.hole3.position = ballPoint3;
    self.hole3.fillColor = [SKColor grayColor]; //Upper left corner third turn
    self.hole3.strokeColor = [SKColor blackColor]; //Hole 3
    self.hole3.physicsBody.categoryBitMask = holeCategory;
    self.hole3.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:self.hole3];
    
    self.hole4 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint4 = CGPointMake(730,910);
    self.hole4.position = ballPoint4;
    self.hole4.fillColor = [SKColor grayColor]; //Upper right corner
    self.hole4.strokeColor = [SKColor blackColor]; //Hole 4
    self.hole4.physicsBody.categoryBitMask = holeCategory;
    self.hole4.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:self.hole4];
    
    self.hole5 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint5 = CGPointMake(310,390);
    self.hole5.position = ballPoint5;
    self.hole5.fillColor = [SKColor grayColor]; //Middle left corner
    self.hole5.strokeColor = [SKColor blackColor]; //Hole 5
    self.hole5.physicsBody.categoryBitMask = holeCategory;
    self.hole5.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:self.hole5];
    
    self.hole6 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint6 = CGPointMake(590,455);
    self.hole6.position = ballPoint6;
    self.hole6.fillColor = [SKColor grayColor]; //Middle right corner
    self.hole6.strokeColor = [SKColor blackColor]; //Hole 6
    self.hole6.physicsBody.categoryBitMask = holeCategory;
    self.hole6.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:self.hole6];
    
    self.hole7 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint7 = CGPointMake(590,150);
    self.hole7.position = ballPoint7;
    self.hole7.fillColor = [SKColor grayColor];
    self.hole7.strokeColor = [SKColor blackColor]; //Hole 7
    self.hole7.physicsBody.categoryBitMask = holeCategory;
    self.hole7.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:self.hole7];
    
    self.hole8 = [SKShapeNode shapeNodeWithCircleOfRadius:radius];
    CGPoint ballPoint8 = CGPointMake(180,190);
    self.hole8.position = ballPoint8;
    self.hole8.fillColor = [SKColor grayColor];
    self.hole8.strokeColor = [SKColor blackColor]; //Hole 8
    self.hole8.physicsBody.categoryBitMask = holeCategory;
    self.hole8.physicsBody.contactTestBitMask = edgeCategory | wallCategory | ballCategory;
    [self addChild:self.hole8];
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
    self.ball.physicsBody.categoryBitMask = ballCategory;
    self.ball.physicsBody.contactTestBitMask = edgeCategory | wallCategory | holeCategory;
    
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

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    //Makes sound when the ball hits the wall or hits a hole
    SKPhysicsBody *notBall;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        notBall = contact.bodyB;
    }
    else
    {
        notBall = contact.bodyA;
    }
    
    if (notBall.categoryBitMask == holeCategory)
    {
        SKAction *playSFX1 = [SKAction playSoundFileNamed:@"explosion_small.caf" waitForCompletion:NO];
        [self runAction:playSFX1];
        NSLog(@"Ball has hit a hole"); //Makes sound when the ball hits the edge
    }
    
    if (notBall.categoryBitMask == wallCategory)
    {
        SKAction *playSFX1 = [SKAction playSoundFileNamed:@"shake.caf" waitForCompletion:NO];
        [self runAction:playSFX1];
        NSLog(@"Ball has hit the wall or edge"); //Makes sound when the ball hits the bricks
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        if (CGRectContainsPoint(self.countDown.frame, location))
        {
            self.startGamePlay = YES;
        }
    }
}

-(void)update:(NSTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    
    //Update the ball position
    [self updateBallPosition];
    
    //reset counter if starting
    if (self.startGamePlay)
    {
        self.startTime = currentTime;
        self.startGamePlay = NO;
    }
    self.countDown.text = [NSString stringWithFormat:@"%i", (int)(currentTime-self.startTime)];
}

@end
