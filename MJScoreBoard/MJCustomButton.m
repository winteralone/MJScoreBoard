//
//  MJCustomButton.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-17.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJCustomButton.h"

@implementation MJCustomButton

- (void)setCGFormat
{
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor =[[self tintColor] CGColor];
    self.layer.cornerRadius = 5;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setCGFormat];
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setCGFormat];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

//    self.layer.cornerRadius = 5;
}
 */



@end
