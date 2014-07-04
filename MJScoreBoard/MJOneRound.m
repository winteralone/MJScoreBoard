//
//  MJOneRound.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-2-27.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJOneRound.h"

@implementation MJOneRound
- (void)reset
{
    _nWinner = [NSNumber numberWithInt:-1];
    _nLoser =  [NSNumber numberWithInt:-1];
    _nScore =  [NSNumber numberWithInt:0];
    _penaltyScores = [[NSMutableArray alloc] initWithObjects:@0, @0, @0, @0, nil];
}
- (id)init
{
    [self reset];
    return [super init];
}

- (BOOL)isValid
{
    if( [_nWinner isEqualToNumber:@-1])
        return NO;
    
    if([ _nWinner isEqualToNumber: @4])
    {
        //荒牌，无人点炮，得分置0
        return ([_nLoser isEqualToNumber:@-1]) && ( [_nScore isEqualToNumber:@0] );
    }
    else
    {
        return ![_nLoser isEqualToNumber:@-1];
    }
    
}

- (BOOL)isEqual:(id)object
{
    if ( [object class] != [MJOneRound class])
        return NO;
    MJOneRound *oneRound = (MJOneRound*)object;
    if (![oneRound.nWinner isEqualToNumber:_nWinner])
        return NO;
    if (![oneRound.nLoser isEqualToNumber:_nLoser])
        return NO;
    if (![oneRound.nScore isEqualToNumber:_nScore])
        return NO;
    if (oneRound.penaltyScores == nil && _penaltyScores == nil)
        return YES;
    if (![oneRound.penaltyScores isEqualToArray:_penaltyScores])
        return NO;
    if (oneRound.scoreElements == nil && _scoreElements == nil)
        return YES;
    if (![oneRound.scoreElements isEqualToArray:_scoreElements])
        return NO;
    return YES;
    
}


- (NSArray *)getScore
{
    NSInteger s[4] = {0, 0, 0, 0};
    if (![self isValid])
    {
        return nil;
    }
    
    //点炮
    if( ([_nWinner intValue] != -1)
       && ([_nWinner intValue] !=4 )
       && ([_nLoser intValue] != -1 )
       && ([_nLoser intValue] != 4))
    {
        for (int i=0; i<4; i++)
        {
            if ([_nWinner intValue] == i)
            {
                s[i] = [_nScore intValue]+ 24;
            }
            else if ([_nLoser intValue] == i)
            {
                s[i] = - [_nScore intValue] - 8;
            }
            else
            {
                s[i] = -8;
            }
        }
    }
    //自摸
    if ( ([_nWinner intValue] != -1) && ([_nWinner intValue] != 4) && ([_nLoser intValue] == 4))
    {
        for (int i=0; i<4; i++)
        {
            if ([_nWinner intValue] == i)
            {
                s[i] = ([_nScore intValue] + 8) *3 ;
            }
            else
            {
                s[i] =  - [_nScore intValue] - 8 ;
            }
        }
        
    }
    for (int i=0; i<4; i++)
    {
        s[i] += [ [_penaltyScores objectAtIndex:i] intValue];
    }
    return [[NSArray alloc]initWithObjects:[NSNumber numberWithInteger:s[0]], [NSNumber numberWithInteger:s[1]], [NSNumber numberWithInteger:s[2]], [NSNumber numberWithInteger:s[3]], nil ];
}

#pragma mark NSCoding Delegate
#define     WinnerKey   @"Winner"
#define     LoserKey    @"Loser"
#define     ScoreKey    @"Score"
#define     PenaltyKey  @"Penalty"
#define     ElementKey  @"Element"
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_nWinner forKey:WinnerKey];
    [aCoder encodeObject:_nLoser forKey:LoserKey];
    [aCoder encodeObject:_nScore forKey:ScoreKey];
    [aCoder encodeObject:_penaltyScores forKey:PenaltyKey];
    [aCoder encodeObject:_scoreElements forKey:ElementKey];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [[MJOneRound alloc] init];
    _nWinner = [aDecoder decodeObjectForKey:WinnerKey];
    _nLoser = [aDecoder decodeObjectForKey:LoserKey];
    _nScore = [aDecoder decodeObjectForKey:ScoreKey];
    _penaltyScores = [aDecoder decodeObjectForKey:PenaltyKey];
    _scoreElements = [aDecoder decodeObjectForKey:ElementKey];
    return self;
}

#pragma mark NSCopying delegate
-(id)copyWithZone:(NSZone *)zone
{
    MJOneRound* newRound = [[MJOneRound alloc] init];
    newRound.nWinner = [_nWinner copy];
    newRound.nLoser = [_nLoser copy];
    newRound.nScore = [_nScore copy];
    newRound.penaltyScores = [[NSMutableArray alloc]initWithArray:_penaltyScores copyItems:YES];
    newRound.scoreElements = [[NSMutableArray alloc]initWithArray:_scoreElements copyItems:YES];
    return newRound;
}
@end
