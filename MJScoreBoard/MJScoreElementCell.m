//
//  MJScoreElementCell.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-27.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJScoreElementCell.h"

@interface MJScoreElementCell ()
@property UILabel* label;
@end

@implementation MJScoreElementCell

- (void)awakeFromNib
{
    if (!_label)
    {
        _label = [[UILabel alloc]initWithFrame:self.bounds];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_label];
        
    }
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [[UIColor blackColor]CGColor];
    self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    if (!self.selectedBackgroundView)
    {
        UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
        bgView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:1 alpha:1];
        bgView.layer.cornerRadius = 5;
        self.selectedBackgroundView = bgView;
    }
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSString*)title
{
    if (_label) {
        return _label.text;
    }
    return @"";
}

- (void)setTitle:(NSString *)title
{
    if(_label)
    {
        _label.text = title;
        _label.font = [UIFont boldSystemFontOfSize:18];
        _label.textColor = [UIColor blackColor];

    }
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
