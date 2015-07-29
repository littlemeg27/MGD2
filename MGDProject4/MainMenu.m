//
//  MainMenu.m
//  MGDProject4
//
//  Created by Brenna Pavlinchak on 7/28/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "MainMenu.h"
#import "GameScene.h"

@implementation MainMenu

-(instancetype)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor brownColor];
        
        SKLabelNode *nameLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        nameLabel.text = @"Labyrinth";
        nameLabel.fontColor = [SKColor whiteColor];
        nameLabel.fontSize = 60;
        nameLabel.position = CGPointMake(CGRectGetMidX(self.frame),800);
        [self addChild:nameLabel];
        
        SKLabelNode *playLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        playLabel.text = @"Play";
        playLabel.fontColor = [SKColor whiteColor];
        playLabel.fontSize = 30;
        playLabel.position = CGPointMake(CGRectGetMidX(self.frame),600);
        [self addChild:playLabel];
        
        SKLabelNode *creditsLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        creditsLabel.text = @"Credits";
        creditsLabel.fontColor = [SKColor whiteColor];
        creditsLabel.fontSize = 30;
        creditsLabel.position = CGPointMake(CGRectGetMidX(self.frame),500);
        [self addChild:creditsLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        //CGPoint location1 = [touch locationInNode:self];
        //CGPoint newBPos1 = CGPointMake(location1.x, 350);
        GameScene *gameScene = [GameScene sceneWithSize:self.size];
        [self.view presentScene:gameScene transition:[SKTransition fadeWithDuration:1.0]];
        
    }
}

@end
