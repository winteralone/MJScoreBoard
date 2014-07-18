//
//  MJScoreMainTable.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-14.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCORE_ELEMENT_LABEL_WIDTH 200
#define INFO_BUTTON_WIDTH 30
#define TEXT_FIELD_HEIGHT 40
#define SECTION_LABEL_HEIGHT 30
#define CELL_HEIGHT 44
#define TABLE_LEFT_BOUNDARY 40

@protocol MJScoreMainTableDelegate;

@interface MJScoreMainTable : UIView
@property (weak, nonatomic) IBOutlet UIViewController<MJScoreMainTableDelegate> *delegate;
@property (weak, nonatomic) NSMutableArray* playerNames;

- (void)reloadData;
- (NSIndexPath*)indexPathForSender:(id)sender;
- (IBAction)clickedInfoButton:(id)sender;
@end
