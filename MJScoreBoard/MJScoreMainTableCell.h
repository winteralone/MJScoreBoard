//
//  MJScoreMainTableCell.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-14.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJScoreMainTableCell : UIView

@property (nonatomic) NSMutableArray *scoreLabels;
@property (nonatomic) UILabel *scoreElementLabel;
@property (nonatomic) UIButton *infoButton;

@property (nonatomic) NSInteger mode;

@end
