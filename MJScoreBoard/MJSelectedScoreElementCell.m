//
//  MJSelectedScoreElement.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-13.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJSelectedScoreElementCell.h"
#import "MJSelectedScoreElementList.h"

@interface MJSelectedScoreElementCell ()

@property UILabel *textLabel;
@property UIButton *closeButton;

@end

@implementation MJSelectedScoreElementCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.layer.backgroundColor = [[UIColor grayColor] CGColor];
        self.layer.cornerRadius = 20;
        _closeButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - 24, 0, 24, frame.size.height)];
        [_closeButton setTitle:@"❎" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self.superview action:@selector(clickedCloseButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width - 24, frame.size.height)];
        _textLabel.adjustsFontSizeToFitWidth = YES;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        _textLabel.textColor = [UIColor whiteColor];
        [self addSubview:_closeButton];
        [self addSubview:_textLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (_textLabel)
    {
        _textLabel.text = title;
    }
}

- (NSString*)title
{
    return _textLabel.text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
