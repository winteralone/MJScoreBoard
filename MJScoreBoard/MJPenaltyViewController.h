//
//  MJPenaltyViewController.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-17.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJScoreDelegates.h"

@interface MJPenaltyViewController : UIViewController
@property (weak, nonatomic) UIViewController<MJSetPenaltyDelegate> *delegate;
@end
