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

    //FMMParallaxNode *_parallaxNodeBackgrounds;
    //FMMParallaxNode *_parallaxSpaceDust;
    
    CMMotionManager *_motionManager;
    
    /*
    NSMutableArray *_asteroids;
    int _nextAsteroid;
    double _nextAsteroidSpawn;
    
    NSMutableArray *_shipLasers;
    int _nextShipLaser;
    
    int _lives;
    double _gameOverTime;
    bool _gameOver;
    
    AVAudioPlayer *_backgroundAudioPlayer;*/


-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        //self.physicsBody.categoryBitMask = edgeCategory;
        self.physicsWorld.contactDelegate = self; //Might need for later
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"featherBackground.jpg"];
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        
        [self addChild:background];
        [self addBall:size];
        [self startTheGame];
    }
    return self;
}

-(void) addBall:(CGSize) size
{
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"MainBall.png"];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.xScale = 0.5;
        sprite.yScale = 0.5;
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
