//
//  GameScene.m
//  MGDProject1
//
//  Created by Brenna Pavlinchak on 7/12/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "GameScene.h"

@interface GameScene ()

@property (nonatomic) SKSpriteNode *brick1;
@property (nonatomic) SKSpriteNode *brick2;
@property (nonatomic) SKSpriteNode *brick3;
@property (nonatomic) SKSpriteNode *brick4;

@end

static const uint32_t brickCategory = 1;
static const uint32_t edgeCategory = 2;
static const uint32_t ballCategory = 4;

@implementation GameScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = edgeCategory;
        self.physicsWorld.contactDelegate = self;
    
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"featherBackground.jpg"];
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
    
        [self addChild:background];
        [self addBricks:size];
        [self addBall:size];
    }
    return self;
}

-(void) addBall:(CGSize) size
{
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"MainBall.png"];
    
    [self addChild:ball];
    
    ball.physicsBody = [SKPhysicsBody bodyWithTexture:ball.texture size:ball.texture.size];
    CGPoint ballPoint = CGPointMake(170,600);
    ball.position = ballPoint;
    
    ball.physicsBody.friction = 0;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.restitution = 1.0f;
    ball.physicsBody.categoryBitMask = brickCategory;
    ball.physicsBody.contactTestBitMask = edgeCategory | brickCategory | ballCategory;
    
}

-(void) addBricks:(CGSize) size
{
    self.brick1 = [SKSpriteNode spriteNodeWithImageNamed:@"brick1.png"];
    self.brick2 = [SKSpriteNode spriteNodeWithImageNamed:@"brick2.png"];
    self.brick3 = [SKSpriteNode spriteNodeWithImageNamed:@"brick3.png"];
    self.brick4 = [SKSpriteNode spriteNodeWithImageNamed:@"brick4.png"];
    
    self.brick1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.brick1.frame.size];
    self.brick1.physicsBody.dynamic =  NO;
    CGPoint brickPoint1 = CGPointMake(115,350); //Gonna try and add the other two bricks for
    self.brick1.position = brickPoint1;         //Sound and contact
    _brick1.physicsBody.categoryBitMask = brickCategory;
    _brick1.physicsBody.contactTestBitMask = edgeCategory | brickCategory | ballCategory;
    
    self.brick2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.brick2.frame.size];
    self.brick2.physicsBody.dynamic =  NO;
    CGPoint brickPoint2 = CGPointMake(300,250);
    self.brick2.position = brickPoint2;
    _brick2.physicsBody.categoryBitMask = brickCategory;
    _brick2.physicsBody.contactTestBitMask = edgeCategory | brickCategory | ballCategory;
    
    self.brick3.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.brick3.frame.size];
    self.brick3.physicsBody.dynamic =  NO;
    CGPoint brickPoint3 = CGPointMake(135,150);
    self.brick3.position = brickPoint3;
    _brick3.physicsBody.categoryBitMask = brickCategory;
    _brick3.physicsBody.contactTestBitMask = edgeCategory | brickCategory | ballCategory;
    
    self.brick4.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.brick4.frame.size];
    self.brick4.physicsBody.dynamic =  NO;
    CGPoint brickPoint4 = CGPointMake(250,450);
    self.brick4.position = brickPoint4;
    _brick4.physicsBody.categoryBitMask = brickCategory;
    _brick4.physicsBody.contactTestBitMask = edgeCategory | brickCategory | ballCategory;
    
    [self addChild:self.brick1];
    [self addChild:self.brick2];
    [self addChild:self.brick3];
    [self addChild:self.brick4];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     /* Called when a touch begins */
     /*for (UITouch *touch in touches)
     {

     }*/
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint location1 = [touch locationInNode:self];
        CGPoint newBPos1 = CGPointMake(location1.x, 350);
        
        if (newBPos1.x < self.brick1.size.width/2)
        {
            newBPos1.x = self.brick1.size.width/2;
        }
        
        if (newBPos1.x > self.size.width - (self.brick1.size.width/2))
        {
            newBPos1.x = self.size.width - (self.brick1.size.width/2);
        }
        
        self.brick1.position = newBPos1;
    }
    
    for (UITouch *touch in touches)
    {
        CGPoint location2 = [touch locationInNode:self];
        CGPoint newBPos2 = CGPointMake(location2.x, 150);
        
        if (newBPos2.x < self.brick3.size.width/2)
        {
            newBPos2.x = self.brick3.size.width/2;
        }
        
        if (newBPos2.x > self.size.width - (self.brick3.size.width/2))
        {
            newBPos2.x = self.size.width - (self.brick3.size.width/2);
        }
        
        self.brick3.position = newBPos2;
    }

}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    //Makes sound when the ball hits wall or two of the bricks
    SKPhysicsBody *notBall;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        notBall = contact.bodyB; //Entity to entity collision, added this last week to make sounds work.
    }
    else
    {
        notBall = contact.bodyA;
    }
    
    if (notBall.categoryBitMask == edgeCategory)
    {
        SKAction *playSFX1 = [SKAction playSoundFileNamed:@"blip.caf" waitForCompletion:NO];
        [self runAction:playSFX1]; //Sound when the ball hits the edge
        NSLog(@"Bang!");
    }
    
    if (notBall.categoryBitMask == brickCategory)
    {
        SKAction *playSFX1 = [SKAction playSoundFileNamed:@"brickhit.caf" waitForCompletion:NO];
        [self runAction:playSFX1]; //Sound when the ball hits two of the bricks
        NSLog(@"Crash!");
    }

}



-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
}

@end
