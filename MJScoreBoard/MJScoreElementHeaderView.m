//
//  MJScoreElementHeaderView.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-30.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJScoreElementHeaderView.h"

@interface MJScoreElementHeaderView ()

@property UILabel* label;

@end

@implementation MJScoreElementHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    if (!_label)
    {
        _label = [[UILabel alloc]initWithFrame:self.frame];
        _label.textColor = [UIColor blackColor];
        [self addSubview:_label];
    }
}

- (void)setTitle:(NSString *)title
{
    _label.text = title;
}

- (NSString*)title
{
    return _label.text;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect
{
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[self tintColor] CGColor];
    // Drawing code
}
 */


@end
