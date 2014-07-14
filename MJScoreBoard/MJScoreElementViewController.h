//
//  MJScoreElementViewController.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-27.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJScoreDelegates.h"

@interface MJScoreElementViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MJSelectedScoreElementListDelegate>

@property NSMutableArray *selectedScoreElements;

@end
