//
//  MJScoreMainTableTotalScoreCell.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-19.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJScoreMainTableTotalScoreCell.h"
#import "MJScoreMainTable.h"
#import "MJCustomButton.h"

@interface MJScoreMainTableTotalScoreCell ()
@property MJCustomButton *dummyLabel;
@end

@implementation MJScoreMainTableTotalScoreCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        _labels = [[NSMutableArray alloc] init];
        UIColor *textColor = [UIColor colorWithRed:205/255.f green:1 blue:205/255.f alpha:1];
        UIFont *font = [UIFont boldSystemFontOfSize:28];
        CGFloat cellWidth = (frame.size.width - TABLE_LEFT_BOUNDARY - SCORE_ELEMENT_LABEL_WIDTH - INFO_BUTTON_WIDTH) / 4;
        for (int i=0; i<4; i++)
        {
            UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth * i, 0, cellWidth, CELL_HEIGHT)];
            label.text = @"0";
            label.textColor = textColor;
            label.font = font;
            label.textAlignment = NSTextAlignmentCenter;
            [_labels addObject:label];
            [self addSubview:label];
        }
        _dummyLabel = [[MJCustomButton alloc]initWithFrame:CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth * 4, 0, SCORE_ELEMENT_LABEL_WIDTH, CELL_HEIGHT)];
        [_dummyLabel setTitle:@"追分计算器" forState:UIControlStateNormal];
        [_dummyLabel setTitleColor:textColor forState:UIControlStateNormal];
        [_dummyLabel addTarget:self.superview action:@selector(clickedViewTargetScoreButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_dummyLabel];
    }
    return self;
}

- (void)setMode:(NSInteger)mode
{
    CGFloat cellWidth = (self.bounds.size.width - TABLE_LEFT_BOUNDARY - (mode?0:SCORE_ELEMENT_LABEL_WIDTH) - INFO_BUTTON_WIDTH) / 4;
    for (int i=0; i<4; i++)
    {
        UILabel *label = _labels[i];
        label.frame = CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth * i, 0, cellWidth, self.bounds.size.height);
    }
    _dummyLabel.frame = CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth * 4, 0, SCORE_ELEMENT_LABEL_WIDTH, self.bounds.size.height);
    _dummyLabel.hidden = (mode == 1);

    _mode = mode;
}

@end
