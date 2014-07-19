//
//  MJScoreMainTableCell.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-14.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJScoreMainTableCell.h"
#import "MJScoreMainTable.h"

@interface MJScoreMainTableCell ()



@end

@implementation MJScoreMainTableCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        if (!_scoreLabels)
        {
            _scoreLabels = [[NSMutableArray alloc] init];
        }
        CGFloat cellWidth = (self.bounds.size.width - TABLE_LEFT_BOUNDARY - SCORE_ELEMENT_LABEL_WIDTH - INFO_BUTTON_WIDTH) / 8;
        for (int i=0; i<8; i++)
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth*i, 0, cellWidth, CELL_HEIGHT)];
            [label setTextAlignment:NSTextAlignmentCenter];
            if (i%2 == 1)
            {
                [label setFont:[UIFont boldSystemFontOfSize:28]];
                [label setTextColor:[UIColor blueColor]];
            }
            else
            {
                [label setFont:[UIFont systemFontOfSize:28]];
                
            }
            [label setAdjustsFontSizeToFitWidth:YES];
            [_scoreLabels addObject:label];
            [self addSubview:label];
        }
        _scoreElementLabel = [[UILabel alloc]initWithFrame:CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth*8, 0, SCORE_ELEMENT_LABEL_WIDTH, CELL_HEIGHT)];
        [_scoreElementLabel setFont:[UIFont systemFontOfSize:28]];
        [_scoreElementLabel setAdjustsFontSizeToFitWidth:YES];
        _infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        _infoButton.frame = CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth*8 + SCORE_ELEMENT_LABEL_WIDTH, 0, INFO_BUTTON_WIDTH, CELL_HEIGHT);
        [_infoButton addTarget:self.superview action:@selector(clickedInfoButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_scoreElementLabel];
        [self addSubview:_infoButton];
    }
    return self;
}

- (void)setMode:(NSInteger)mode
{
    if (mode == 0)
    {
        CGFloat cellWidth = (self.bounds.size.width - TABLE_LEFT_BOUNDARY - SCORE_ELEMENT_LABEL_WIDTH - INFO_BUTTON_WIDTH) / 8;
        for (int i=0; i<8; i++)
        {
            UILabel *label = _scoreLabels[i];
            if (i %2 == 0)
            {
                label.frame = CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth * i , 0, cellWidth * 2, CELL_HEIGHT);

            }
            else
            {
                label.hidden = YES;
            }
        }
        _scoreElementLabel.hidden = NO;
    }
    else // mode == 1
    {
        CGFloat cellWidth = (self.bounds.size.width - TABLE_LEFT_BOUNDARY - INFO_BUTTON_WIDTH ) / 8;
        for (int i=0; i<8; i++)
        {
            UILabel *label = _scoreLabels[i];
            label.frame = CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth *i, 0, cellWidth, CELL_HEIGHT);
            label.hidden = NO;
        }
        _scoreElementLabel.hidden = YES;
    }
    _mode = mode;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    return;
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    [path closePath];
    [[UIColor blackColor]setStroke];
    [path stroke];
    // Drawing code
}
 */



@end
