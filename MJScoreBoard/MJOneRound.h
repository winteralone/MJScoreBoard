//
//  MJOneRound.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-2-27.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJOneRound : NSObject <NSCopying, NSCoding>
@property (strong, nonatomic) NSNumber *nWinner;
@property (strong, nonatomic) NSNumber *nLoser;
@property (strong, nonatomic) NSNumber *nScore;
@property (strong, nonatomic) NSMutableArray *penaltyScores;    //罚分
@property (strong, nonatomic) NSMutableArray *scoreElements;    //番种

- (id)init;
- (void)reset;
- (NSArray*)getScore;
- (NSArray*)getRawScore;
- (BOOL)isValid;
- (BOOL)isEqual:(id)object;
@end
