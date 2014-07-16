//
//  MJSelectedScoreElementList.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-13.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJScoreDelegates.h"

@interface MJSelectedScoreElementList : UIView
@property (weak, nonatomic) IBOutlet UIViewController<MJSelectedScoreElementListDelegate> *delegate;
- (IBAction)clickedCloseButton:(id)sender;
- (void)reloadData;
@end
