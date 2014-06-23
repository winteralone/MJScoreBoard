//
//  MJCustomButton.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-17.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJCustomButton.h"

@implementation MJCustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor =[[self tintColor] CGColor];
    self.layer.cornerRadius = 5;
}



@end
