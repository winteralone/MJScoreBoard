//
//  MJScoreAdjustControl.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-7.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJScoreAdjustControlDelegate;


@interface MJScoreAdjustControl : UIControl

-(void)reloadData;
@property (weak, nonatomic) IBOutlet id<MJScoreAdjustControlDelegate> delegate;
@end
