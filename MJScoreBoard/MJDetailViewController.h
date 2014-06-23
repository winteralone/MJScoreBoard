//
//  MJDetailViewController.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-2-24.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJScoreController;
@class MJOneRound;
@class MJOneGame;

@interface MJDetailViewController : UIViewController  <UISplitViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MJScoreController *childController;
@property (strong, nonatomic) NSMutableArray *oneRoundScoreList;
@property (strong, nonatomic) NSMutableArray *totalScoreList;
@property (strong, nonatomic) NSMutableArray *rawScoreList;
@property (assign, nonatomic) NSInteger currentRound;

- (void)updateRow:(MJOneRound*)result atIndexPath:(NSIndexPath *)indexPath;
- (IBAction)PlayerNameChanged:(UITextField *)sender;
- (void)loadFromMJOneGame:(MJOneGame*)game;
- (void)reset;
@end
