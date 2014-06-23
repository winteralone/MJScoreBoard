//
//  MJMasterViewController.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-2-24.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJDetailViewController;
@class MJOneGame;
@interface MJMasterViewController : UITableViewController

@property (strong, nonatomic) MJDetailViewController *detailViewController;
- (void)addGame:(MJOneGame*)game;
- (NSInteger)containsGame:(NSString *)gameName;
@end
