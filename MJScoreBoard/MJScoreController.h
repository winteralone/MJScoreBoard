//
//  MJScoreController.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-2-26.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJScoreDelegates.h"

@class MJOneRound;
@class MJDetailViewController;

@interface MJScoreController : UIViewController <UIAlertViewDelegate, MJSetPenaltyDelegate>


@property (weak, nonatomic) MJDetailViewController *parentController;
@property (copy, nonatomic) NSMutableArray *playerNames;
@property (strong, nonatomic) MJOneRound *originalResult;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end
