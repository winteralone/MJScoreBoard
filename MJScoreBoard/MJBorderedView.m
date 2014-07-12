//
//  MJBorderedView.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-1.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJBorderedView.h"

@implementation MJBorderedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [[UIColor blueColor] CGColor];
    // Drawing code
}

@end
