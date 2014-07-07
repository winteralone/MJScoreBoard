//
//  MJSetPenaltyDelegate.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-18.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MJSetPenaltyDelegate <NSObject>

@property (copy, nonatomic) NSArray *playerNames;
@property (strong, nonatomic) NSMutableArray *penaltyScores;

- (void) didSetPenaltyScores;
@end

@protocol MJScoreAdjustControlDelegate <NSObject>

@property (copy, nonatomic) NSNumber *currentScore;
- (void)adjustScore:(NSInteger)offset;
@end

