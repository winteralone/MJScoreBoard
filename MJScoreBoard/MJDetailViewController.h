//
//  MJDetailViewController.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-2-24.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJScoreDelegates.h"

@class MJScoreController;
@class MJOneRound;
@class MJOneGame;

@interface MJDetailViewController : UIViewController  <UISplitViewControllerDelegate, UIScrollViewDelegate, MJScoreMainTableDelegate>

@property (strong, nonatomic) MJScoreController *childController;
@property (strong, nonatomic) NSMutableArray *oneRoundScoreList;
@property (strong, nonatomic) NSMutableArray *totalScoreList;
@property (strong, nonatomic) NSMutableArray *rawScoreList;
@property (assign, nonatomic) NSInteger currentRound;

- (void)updateRow:(MJOneRound*)result atIndexPath:(NSIndexPath *)indexPath;
- (void)loadFromMJOneGame:(MJOneGame*)game;
- (void)reset;
@end
