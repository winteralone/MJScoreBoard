//
//  MJScoreMainTable.h
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-14.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCORE_ELEMENT_LABEL_WIDTH 209
#define INFO_BUTTON_WIDTH 40
#define TEXT_FIELD_HEIGHT 35
#define SECTION_LABEL_HEIGHT 30
#define CELL_HEIGHT 44
#define TABLE_LEFT_BOUNDARY 50

@protocol MJScoreMainTableDelegate;



@interface MJScoreMainTable : UIView
@property (weak, nonatomic) IBOutlet UIViewController<MJScoreMainTableDelegate> *delegate;
@property (weak, nonatomic) NSMutableArray* playerNames;

- (void)reloadData;
- (void)setLayout: (NSInteger)mode;
- (NSIndexPath*)indexPathForSender:(id)sender;
- (IBAction)clickedInfoButton:(id)sender;
+ (CGRect)getCellFrame:(CGSize)containerSize withNum:(NSInteger)cellNum atIndex:(NSInteger)index withMode:(NSInteger)mode;

@end
