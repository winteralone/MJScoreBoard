//
//  MJViewTargetScoreViewController.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14/12/6.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJViewTargetScoreViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *scoreInfo;

@end
