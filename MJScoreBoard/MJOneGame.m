//
//  MJOneGame.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-16.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJOneGame.h"

#define PlayerNamesKey      @"PlayerNames"
#define ScoreListKey        @"ScoreList"
#define VersionKey          @"Version"
#define DATA_VERSION        0

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

- (NSURL*)getFileURL:(NSString*)fileName;
{
    NSURL *path = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    NSURL *filePath = [path URLByAppendingPathComponent:fileName];
    return filePath;
}

- (BOOL)saveToFile
{
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeInteger:DATA_VERSION forKey:VersionKey];
    [archiver encodeObject:_playerNames forKey:PlayerNamesKey];
    [archiver encodeObject:_rawScoreList forKey:ScoreListKey];
    [archiver finishEncoding];
    
    NSURL* filePath = [self getFileURL:_gameName];

    return [data writeToFile:filePath.path atomically:NO];
}

- (BOOL)loadFromFile
{

    NSURL* filePath = [self getFileURL:_gameName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath.path])
    {
        NSData* data = [[NSData alloc]initWithContentsOfURL:filePath];
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        _playerNames = [unArchiver decodeObjectForKey:PlayerNamesKey];
        _rawScoreList = [unArchiver decodeObjectForKey:ScoreListKey];
        _nVersion = [unArchiver decodeIntegerForKey:VersionKey];
        return YES;
    };
    
    return NO;
}

@end

