//
//  GameOverScene.m
//  MGDProject4
//
//  Created by Brenna Pavlinchak on 7/28/15.
//  Copyright (c) 2015 Brenna Pavlinchak. All rights reserved.
//

#import "GameOverScene.h"

@implementation GameOverScene

-(instancetype)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor blackColor];
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = @"Game Over!";
        label.fontColor = [SKColor whiteColor];
        label.fontSize = 50;
        label.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:label];
    }
    return self;
}

@end
