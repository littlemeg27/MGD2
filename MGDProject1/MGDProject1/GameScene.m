//
//  GameScene.m
//  MGDProject1
//
//  Created by Brenna Pavlinchak on 7/12/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view
{
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Ball Bounce";
    myLabel.fontSize = 20;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"featherBackground.jpg"];
    bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
    
    [self addChild:bgImage];
    [self addChild:myLabel];
}

-(void) addBall:(CGSize) size
{
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"MainBall.png"];
    
    [self addChild:ball];
    
    ball.physicsBody = [SKPhysicsBody bodyWithTexture:ball.texture size:ball.texture.size];
    CGPoint ballPoint = CGPointMake(160,200);
    ball.position = ballPoint;
    
    ball.physicsBody.friction = 0;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.restitution = 1.0f;
    
}

-(void) addStarBricks:(CGSize) size
{
    SKSpriteNode *starBrick1 = [SKSpriteNode spriteNodeWithImageNamed:@"StarBrick1.png"];
    SKSpriteNode *starBrick2 = [SKSpriteNode spriteNodeWithImageNamed:@"StarBrick2.png"];
    SKSpriteNode *starBrick3 = [SKSpriteNode spriteNodeWithImageNamed:@"StarBrick3.png"];
    SKSpriteNode *starBrick4 = [SKSpriteNode spriteNodeWithImageNamed:@"StarBrick4.png"];
    SKSpriteNode *starBrick5 = [SKSpriteNode spriteNodeWithImageNamed:@"StarBrick5.png"];
    SKSpriteNode *starBrick6 = [SKSpriteNode spriteNodeWithImageNamed:@"StarBrick6.png"];
    
    [self addChild:starBrick1];
    [self addChild:starBrick2];
    [self addChild:starBrick3];
    [self addChild:starBrick4];
    [self addChild:starBrick5];
    [self addChild:starBrick6];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    /*for (UITouch *touch in touches)
     {
     CGPoint location = [touch locationInNode:self];
     
     SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
     
     sprite.xScale = 0.5;
     sprite.yScale = 0.5;
     sprite.position = location;
     
     SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
     
     [sprite runAction:[SKAction repeatActionForever:action]];
     
     [self addChild:sprite];
     }*/
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
