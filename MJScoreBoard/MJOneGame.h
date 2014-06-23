//
//  MJOneGame.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-16.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJOneGame : NSObject

@property (strong, nonatomic) NSString*         gameName;
@property (strong, nonatomic) NSArray*          playerNames;
@property (strong, nonatomic) NSMutableArray*   rawScoreList;

- (id)initWithName:(NSString*)name;
- (BOOL)saveToFile;
- (BOOL)loadFromFile;
@end
