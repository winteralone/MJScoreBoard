//
//  MJScoreMainTable.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-14.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJScoreMainTable.h"
#import "MJScoreDelegates.h"
#import "MJScoreMainTableCell.h"
#import "MJScoreMainTableTotalScoreCell.h"



@interface MJScoreMainTable ()
@property NSMutableArray *textFields;
@property NSMutableArray *sectionLabels;
@property NSMutableArray *tableCells;
@property MJScoreMainTableTotalScoreCell *totalScoreCell;
@end

@implementation MJScoreMainTable

- (void)setupTextFields
{
    CGFloat textWidth = (self.bounds.size.width - TABLE_LEFT_BOUNDARY - SCORE_ELEMENT_LABEL_WIDTH - INFO_BUTTON_WIDTH)/4;
    CGFloat textHeight = TEXT_FIELD_HEIGHT;
    if (!_textFields)
    {
        _textFields = [[NSMutableArray alloc]init];
    }
    NSArray *defaulNames = @[@"东家", @"南家", @"西家", @"北家"];
    const CGFloat INTERVAL = 5;
    for (int i=0; i<4; i++)
    {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(TABLE_LEFT_BOUNDARY + textWidth*i+INTERVAL, INTERVAL, textWidth-2*INTERVAL, textHeight-2*INTERVAL)];
        [_textFields addObject:textField];
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        [textField setTextAlignment:NSTextAlignmentCenter];
        [textField setFont:[UIFont systemFontOfSize:28]];
        textField.adjustsFontSizeToFitWidth = YES;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [textField setPlaceholder:defaulNames[i]];
        [self addSubview:textField];
    }
    
}

- (void)setup
{
    [self setupTextFields];
    
    if (!_sectionLabels)
    {
        _sectionLabels = [[NSMutableArray alloc]init];
    }
    if (!_tableCells)
    {
        _tableCells = [[NSMutableArray alloc]init];
    }
    CGFloat baseline_y = TEXT_FIELD_HEIGHT;
    NSArray *roundName = @[@"东", @"南", @"西", @"北"];
    _totalScoreCell = [[MJScoreMainTableTotalScoreCell alloc]initWithFrame:CGRectMake(0, baseline_y, self.bounds.size.width, CELL_HEIGHT)];
    [self addSubview:_totalScoreCell];
    baseline_y += CELL_HEIGHT;
    for (int i=0; i<4; i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, baseline_y, self.bounds.size.width, SECTION_LABEL_HEIGHT)];
        label.font = [UIFont systemFontOfSize:20];
        label.text = roundName[i];
        label.layer.borderWidth = 0.5;
        label.layer.borderColor = [[UIColor blackColor] CGColor];
        label.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [_sectionLabels addObject:label];
        [self addSubview:label];
        baseline_y += SECTION_LABEL_HEIGHT;
        for (int j=0; j<4; j++)
        {
            MJScoreMainTableCell *cell = [[MJScoreMainTableCell alloc]initWithFrame:CGRectMake(0, baseline_y, self.bounds.size.width, CELL_HEIGHT)];
            baseline_y += CELL_HEIGHT;
            [_tableCells addObject:cell];
            [self addSubview:cell];
        }
    }
    UIView *bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, baseline_y, self.bounds.size.width, 1)];
    bottomline.backgroundColor = [UIColor blackColor];
    [self addSubview:bottomline];
    
    
}

- (void)reloadData
{
    for (NSInteger i=0; i<16; i++)
    {
        [_delegate updateOneRoundCell:_tableCells[i] atRound:i];
    }
    [_delegate updateTotalScoreCell:_totalScoreCell];
    
}

- (void)setLayout:(NSInteger)mode
{
    for (MJScoreMainTableCell *cell in _tableCells)
    {
        CGRect rect = cell.frame;
        rect.size.width = self.bounds.size.width;
        cell.frame = rect;
        cell.mode = mode;
    }
    CGFloat cellWidth = (self.bounds.size.width - TABLE_LEFT_BOUNDARY - (mode?0:SCORE_ELEMENT_LABEL_WIDTH) - INFO_BUTTON_WIDTH) / 4;
    for (int i=0; i<4; i++)
    {
        UITextField *textField = _textFields[i];
        textField.frame = CGRectMake(TABLE_LEFT_BOUNDARY + cellWidth * i, 0, cellWidth, TEXT_FIELD_HEIGHT);
    }
    CGRect rect = _totalScoreCell.frame;
    rect.size.width = self.bounds.size.width;
    _totalScoreCell.frame = rect;
    _totalScoreCell.mode = mode;
}

- (NSMutableArray*)playerNames
{
    NSMutableArray *names = [NSMutableArray arrayWithObjects:
                              ((UITextField*)_textFields[0]).text,
                              ((UITextField*)_textFields[1]).text,
                              ((UITextField*)_textFields[2]).text,
                              ((UITextField*)_textFields[3]).text, nil];
                             return names;
}

- (void)setPlayerNames:(NSMutableArray *)playerNames
{
    if ([playerNames count] == 4)
    {
        for (int i=0; i<4; i++)
        {
            if ([playerNames[i] isKindOfClass:[NSString class]])
            {
                ((UITextField*)_textFields[i]).text = playerNames[i];
            }
        }
    }
}

- (NSIndexPath*)indexPathForSender:(id)sender
{
    UIButton *button = sender;
    NSUInteger index = [_tableCells indexOfObject:button.superview];
    return [NSIndexPath indexPathForRow:index%4 inSection:index/4];
}

- (IBAction)clickedInfoButton:(id)sender
{
    [self.delegate performSegueWithIdentifier:@"SetScore" sender:sender];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
