//
//  MJScoreAdjustControl.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-7.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJScoreAdjustControl.h"
#import "MJScoreDelegates.h"
#import "MJCustomButton.h"

@interface MJScoreAdjustControl ()

@property UILabel *scoreLabel;
@property NSArray* buttons;
@end

@implementation MJScoreAdjustControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIButton*)createButton:(NSInteger)xPos title:(NSString*)title
{
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width / 8;

    UIButton* button = [[MJCustomButton alloc]initWithFrame:CGRectMake(width*xPos+0.5, 0, width-1, height)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[self tintColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button addTarget:self action:@selector(addScore:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)awakeFromNib
{
    UIButton* button1 = [self createButton:0 title:@"-20"];
    UIButton* button2 = [self createButton:1 title:@"-5"];
    UIButton* button3 = [self createButton:2 title:@"-1"];
    UIButton* button4 = [self createButton:5 title:@"+1"];
    UIButton* button5 = [self createButton:6 title:@"+5"];
    UIButton* button6 = [self createButton:7 title:@"+20"];
    _buttons = [NSArray arrayWithObjects:button1, button2, button3, button4, button5, button6, nil];
    for (UIButton *button in _buttons)
    {
        [self addSubview:button];
    }
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width / 8;

    _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(width*3 , 0, width*2, height)];
    _scoreLabel.textColor = [UIColor blackColor];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.font = [UIFont systemFontOfSize:30];
    [self reloadData];
    [self addSubview:_scoreLabel];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)reloadData
{
    _scoreLabel.text = [NSString stringWithFormat:@"%@番" , [self.delegate.currentScore stringValue] ];
}

- (IBAction)addScore:(UIButton*)sender
{
    NSInteger nAdd = [[sender titleForState:UIControlStateNormal]integerValue];
    [self.delegate adjustScore:nAdd];
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
