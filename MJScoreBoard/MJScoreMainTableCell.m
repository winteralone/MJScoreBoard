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

- (void)addSectionHeaderLabel:(NSString *)title
{
    CGFloat border = self.bounds.size.height - 8;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 4, border, border)];
    label.backgroundColor = [UIColor colorWithRed:0 green:60/255.f blue:45/255.f alpha:1];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:border*0.8];
    label.textColor = [UIColor colorWithRed:38/255.f green:134/255.f blue:86/255.f alpha:1];
    [self addSubview:label];
}

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
                [label setFont:[UIFont boldSystemFontOfSize:self.bounds.size.height*0.5 ]];
                [label setTextColor:[UIColor colorWithRed:205/255.f green:1.f blue:205/255.f alpha:1]];
            }
            else
            {
                [label setFont:[UIFont systemFontOfSize:self.bounds.size.height*0.5]];
                [label setTextColor:[UIColor whiteColor]];
                
            }
            [label setAdjustsFontSizeToFitWidth:YES];
            [_scoreLabels addObject:label];
            [self addSubview:label];
        }
        _scoreElementLabel = [[UILabel alloc]initWithFrame:CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth*8, 0, SCORE_ELEMENT_LABEL_WIDTH, CELL_HEIGHT)];
        [_scoreElementLabel setFont:[UIFont boldSystemFontOfSize:self.bounds.size.height*0.5]];
        [_scoreElementLabel setTextColor:[UIColor whiteColor]];
        [_scoreElementLabel setAdjustsFontSizeToFitWidth:YES];
        _infoButton = [[UIButton alloc]initWithFrame:CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth*8 + SCORE_ELEMENT_LABEL_WIDTH, 0, 20, 20)];
        UIImage *image = [UIImage imageNamed:@"Pencil.png"];
        [_infoButton setImage: image forState:UIControlStateNormal];
        [_infoButton addTarget:self.superview action:@selector(clickedInfoButton:) forControlEvents:UIControlEventTouchUpInside];
        _infoButton.tintColor = [UIColor colorWithRed:205/255.f green:1.f blue:205/255.f alpha:1];
        [self addSubview:_scoreElementLabel];
        [self addSubview:_infoButton];
    }
    return self;
}

- (void)setMode:(NSInteger)mode
{
    if (mode == 0)
    {
        CGFloat cellWidth = (self.bounds.size.width - TABLE_LEFT_BOUNDARY - self.bounds.size.width * 0.3 - INFO_BUTTON_WIDTH) / 8;
        for (int i=0; i<8; i++)
        {
            UILabel *label = _scoreLabels[i];
            if (i %2 == 0)
            {
                label.frame = CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth * i , 0, cellWidth*2, self.bounds.size.height);

            }
            else
            {
                label.hidden = YES;
            }
        }
        _scoreElementLabel.frame = CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth * 8, 0, self.bounds.size.width*0.3, self.bounds.size.height);
        _scoreElementLabel.hidden = NO;
        _infoButton.frame = CGRectMake(self.bounds.size.width - INFO_BUTTON_WIDTH + 10, 12, 20, 20);
    }
    else // mode == 1
    {
        CGFloat cellWidth = (self.bounds.size.width - TABLE_LEFT_BOUNDARY - INFO_BUTTON_WIDTH ) / 8;
        for (int i=0; i<8; i++)
        {
            UILabel *label = _scoreLabels[i];
            label.frame = CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth *i, 0, cellWidth, self.bounds.size.height);
            label.hidden = NO;
        }
        _scoreElementLabel.hidden = YES;
        _infoButton.frame = CGRectMake(self.bounds.size.width - INFO_BUTTON_WIDTH + 10, 12, 20, 20);
    }
    _mode = mode;
}




@end
