//
//  MJScoreAdjustControl.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-7.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJScoreAdjustControl.h"
#import "MJScoreDelegates.h"

#define OFFSET 5

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
    CGFloat width = self.bounds.size.width / 7;

    UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake(width*xPos+OFFSET, 0, width-OFFSET*2, height)];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    button.titleLabel.font = [UIFont systemFontOfSize:24];
    [button addTarget:self action:@selector(addScore:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)awakeFromNib
{
    UIButton* button1 = [self createButton:0 title:@"-10"];
    UIButton* button2 = [self createButton:1 title:@"-5"];
    UIButton* button3 = [self createButton:2 title:@"-1"];
    UIButton* button4 = [self createButton:4 title:@"+1"];
    UIButton* button5 = [self createButton:5 title:@"+5"];
    UIButton* button6 = [self createButton:6 title:@"+10"];
    _buttons = [NSArray arrayWithObjects:button1, button2, button3, button4, button5, button6, nil];
    for (UIButton *button in _buttons)
    {
        [self addSubview:button];
    }
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width / 7;

    _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(width*3 , 0, width, height)];
    _scoreLabel.textColor = [UIColor blackColor];
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.font = [UIFont systemFontOfSize:30];
    _scoreLabel.adjustsFontSizeToFitWidth = YES;
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

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //画顶线
    for (UIButton *button in _buttons)
    {
        UIBezierPath *arrowPath = [[UIBezierPath alloc]init];
        CGRect rc = button.frame;
        CGFloat fOffSet = OFFSET;
        [[UIColor colorWithRed:0 green:0.8 blue:0 alpha:1]setFill];
        if ([_buttons indexOfObject:button] > 2)
        {
            fOffSet *= -1;
            [[UIColor colorWithRed:0.8 green:0 blue:0 alpha:1]setFill];
        }
        [arrowPath moveToPoint: CGPointMake(rc.origin.x + fOffSet,  rc.origin.y) ];
        [arrowPath addLineToPoint:CGPointMake(rc.origin.x - fOffSet, rc.size.height/2)];
        [arrowPath addLineToPoint:CGPointMake(rc.origin.x + fOffSet, rc.size.height)];
        [arrowPath addLineToPoint:CGPointMake(rc.origin.x + rc.size.width+fOffSet, rc.size.height)];
        [arrowPath addLineToPoint:CGPointMake(rc.origin.x + rc.size.width-fOffSet, rc.size.height/2)];
        [arrowPath addLineToPoint:CGPointMake(rc.origin.x + rc.size.width+fOffSet, rc.origin.y)];
        [arrowPath closePath];
        [arrowPath fill];
                                              
    }
    // Drawing code
}


@end
