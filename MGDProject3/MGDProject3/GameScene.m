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
        [self startMovement];
    }
    return self;
}

-(void) addBall:(CGSize) size
{
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"MainBall.png"];
}

- (void)startMovement
{
    ball.hidden = NO;
    //reset ship position for new game
    ball.position = CGPointMake(self.frame.size.width * 0.1, CGRectGetMidY(self.frame));
    
    //setup to handle accelerometer readings using CoreMotion Framework
    [self startMonitoringAcceleration];
    
}

- (void)startMonitoringAcceleration
{
    if (_motionManager.accelerometerAvailable) {
        [_motionManager startAccelerometerUpdates];
        NSLog(@"accelerometer updates on...");
    }
}

- (void)stopMonitoringAcceleration
{
    if (_motionManager.accelerometerAvailable && _motionManager.accelerometerActive) {
        [_motionManager stopAccelerometerUpdates];
        NSLog(@"accelerometer updates off...");
    }
}

- (void)updateShipPositionFromMotionManager
{
    CMAccelerometerData* data = _motionManager.accelerometerData;
    if (fabs(data.acceleration.x) > 0.2) {
        NSLog(@"acceleration value = %f",data.acceleration.x);
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
