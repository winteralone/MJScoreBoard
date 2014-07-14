//
//  MJSelectedScoreElementList.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-13.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJSelectedScoreElementList.h"
#import "MJSelectedScoreElementCell.h"

@implementation MJSelectedScoreElementList

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
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
}

- (void)reloadData
{
    for (UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    NSUInteger count = _delegate.selectedScoreElements.count;
    for (int i=0; i<count; i++)
    {
        CGFloat width = self.bounds.size.width / (count < 5 ? 4 : count);
        CGRect rect = CGRectMake(i*width, 0, width, self.bounds.size.height);
        MJSelectedScoreElementCell * selected = [[MJSelectedScoreElementCell alloc]initWithFrame:rect];
        selected.title = _delegate.selectedScoreElements[i];
        [self addSubview:selected];
    }
}

- (IBAction)clickedCloseButton:(id)sender
{
    UIButton *btn = sender;
    if ([btn.superview isKindOfClass:[MJSelectedScoreElementCell class]])
    {
        MJSelectedScoreElementCell *cell = (MJSelectedScoreElementCell*)btn.superview;
        [_delegate deleteScoreElement:cell.title];
        
    }
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
