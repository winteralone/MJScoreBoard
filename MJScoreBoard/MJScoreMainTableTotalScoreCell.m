//
//  MJScoreMainTableTotalScoreCell.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-19.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJScoreMainTableTotalScoreCell.h"
#import "MJScoreMainTable.h"

@interface MJScoreMainTableTotalScoreCell ()

@end

@implementation MJScoreMainTableTotalScoreCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        _labels = [[NSMutableArray alloc] init];
        CGFloat cellWidth = (frame.size.width - TABLE_LEFT_BOUNDARY - SCORE_ELEMENT_LABEL_WIDTH - INFO_BUTTON_WIDTH) / 4;
        for (int i=0; i<4; i++)
        {
            UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth * i, 0, cellWidth, CELL_HEIGHT)];
            label.text = @"0";
            label.textColor = [UIColor colorWithRed:205/255.f green:1 blue:205/255.f alpha:1];
            label.font = [UIFont boldSystemFontOfSize:30];
            label.textAlignment = NSTextAlignmentCenter;
            [_labels addObject:label];
            [self addSubview:label];
        }
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
    _mode = mode;
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
