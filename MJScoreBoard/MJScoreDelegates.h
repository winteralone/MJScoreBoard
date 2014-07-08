//
//  MJSetPenaltyDelegate.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-18.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol MJScoreAdjustControlDelegate <NSObject>

@property (copy, nonatomic) NSNumber *currentScore;
- (void)adjustScore:(NSInteger)offset;
@end

@class MJOneRound;

@protocol MJMiniSummaryTableDelegate <NSObject>

@property (copy, nonatomic)NSArray *playerNames;
- (MJOneRound*) getCurrentRound;

@end
