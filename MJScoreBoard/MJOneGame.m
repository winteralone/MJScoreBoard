//
//  MJOneGame.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-16.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJOneGame.h"

@implementation MJOneGame

- (id)init
{
    self = [super init];
    _playerNames = [[NSArray alloc]initWithObjects:@"", @"", @"", @"", nil];
    _rawScoreList = [[NSMutableArray alloc]initWithObjects:@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, nil];

    return self;
}

- (id)initWithName:(NSString *)name
{
    self = [self init];
    self.gameName = [name copy];
    return self;
}

- (BOOL)saveToFile
{
    return YES;
}

- (BOOL)loadFromFile
{
    return YES;
}

@end

