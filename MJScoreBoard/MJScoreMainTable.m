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
@property UILabel *dummyTitleSE;
@property NSMutableArray *sectionLabels;
@property NSMutableArray *tableCells;
@property NSMutableArray *segmentHeaderLines;
@property NSMutableArray *segmentSeparateLines;
@property MJScoreMainTableTotalScoreCell *totalScoreCell;
@end

@implementation MJScoreMainTable

- (void)setupArrays
{
    if (!_textFields)
    {
        _textFields = [[NSMutableArray alloc]init];
    }
    if (!_sectionLabels)
    {
        _sectionLabels = [[NSMutableArray alloc]init];
    }
    if (!_tableCells)
    {
        _tableCells = [[NSMutableArray alloc]init];
    }
    if (!_segmentHeaderLines)
    {
        _segmentHeaderLines = [[NSMutableArray alloc] init];
    }
    if (!_segmentSeparateLines)
    {
        _segmentSeparateLines = [[NSMutableArray alloc] init];
    }
    
}

- (void)setupTextFields:(CGFloat)y
{
    CGFloat textWidth = (self.bounds.size.width - TABLE_LEFT_BOUNDARY - SCORE_ELEMENT_LABEL_WIDTH - INFO_BUTTON_WIDTH)/4;
    CGFloat textHeight = TEXT_FIELD_HEIGHT;

    NSArray *defaulNames = @[@"东家", @"南家", @"西家", @"北家"];
    for (int i=0; i<4; i++)
    {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(TABLE_LEFT_BOUNDARY + textWidth*i, y, textWidth, textHeight)];
        [_textFields addObject:textField];
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        [textField setTextAlignment:NSTextAlignmentCenter];
        [textField setFont:[UIFont boldSystemFontOfSize:30]];
        [textField setTextColor:[UIColor whiteColor]];
        [textField setBorderStyle:UITextBorderStyleNone];
        textField.adjustsFontSizeToFitWidth = YES;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [textField setPlaceholder:defaulNames[i]];
        [self addSubview:textField];
    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(TABLE_LEFT_BOUNDARY + textWidth * 4, y, SCORE_ELEMENT_LABEL_WIDTH, textHeight)];
    label.font = [UIFont boldSystemFontOfSize:30];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"主番种";
    _dummyTitleSE = label;
    [self addSubview:_dummyTitleSE];
    
}

- (void)setup
{
    [self setupArrays];
    [self setupTextFields:45];

    CGFloat baseline_y = TEXT_FIELD_HEIGHT + 45;
    NSArray *roundName = @[@"东", @"南", @"西", @"北"];
    _totalScoreCell = [[MJScoreMainTableTotalScoreCell alloc]initWithFrame:CGRectMake(0, baseline_y, self.bounds.size.width, CELL_HEIGHT)];
    [self addSubview:_totalScoreCell];
    baseline_y += CELL_HEIGHT + 45;
    for (int i=0; i<4; i++)
    {
        [self addSegmentHeaderLine:baseline_y];
        baseline_y +=2;
        for (int j=0; j<4; j++)
        {
            MJScoreMainTableCell *cell = [[MJScoreMainTableCell alloc]initWithFrame:CGRectMake(0, baseline_y, self.bounds.size.width, CELL_HEIGHT)];
            if (j==0)
            {
                [cell addSectionHeaderLabel:roundName[i]];
            }
            baseline_y += CELL_HEIGHT;
            [_tableCells addObject:cell];
            [self addSubview:cell];
            if (j != 3)
            {
                [self addSegmentSeparateLine:baseline_y];
                baseline_y += 1;
            }
        }
    }
    [self addSegmentHeaderLine:baseline_y];

}

- (void)addSegmentHeaderLine:(CGFloat)y
{
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(20, y, self.bounds.size.width - 40, 1)];
    line1.backgroundColor = [UIColor colorWithRed:0 green:52/255.f blue:50/255.f alpha:1];
    [self addSubview:line1];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(20, y+1, self.bounds.size.width - 40, 1)];
    line2.backgroundColor = [UIColor colorWithRed:147/255.f green:195/255.f blue:171/255.f alpha:1];
    [self addSubview:line2];
    [_segmentHeaderLines addObject:line1];
    [_segmentHeaderLines addObject:line2];
}

- (void)addSegmentSeparateLine:(CGFloat)y
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(70, y, self.bounds.size.width-90, 1)];
    line.backgroundColor = [UIColor colorWithRed:104/255.f green:171/255.f blue:136/255.f alpha:1];
    [self addSubview:line];
    [_segmentSeparateLines addObject:line];
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
        rect.origin.x = 20;
        rect.size.width = self.bounds.size.width - 40;
        cell.frame = rect;
        cell.mode = mode;
    }
    for (UIView *line in _segmentHeaderLines)
    {
        CGRect rect = line.frame;
        rect.origin.x = 20;
        rect.size.width = self.bounds.size.width - 40;
        line.frame = rect;
    }
    for (UIView *line in _segmentSeparateLines)
    {
        CGRect rect = line.frame;
        rect.origin.x = 20 + TABLE_LEFT_BOUNDARY;
        rect.size.width  = self.bounds.size.width - 40 - TABLE_LEFT_BOUNDARY;
        line.frame = rect;
    }
    CGFloat cellWidth = (self.bounds.size.width - 40 - TABLE_LEFT_BOUNDARY - (mode?0:SCORE_ELEMENT_LABEL_WIDTH) - INFO_BUTTON_WIDTH) / 4;
    for (int i=0; i<4; i++)
    {
        UITextField *textField = _textFields[i];
        CGRect rect = textField.frame;
        rect.origin.x = 20 + TABLE_LEFT_BOUNDARY + cellWidth * i;
        rect.size.width = cellWidth;
        textField.frame = rect;
    }
    CGRect rect = _dummyTitleSE.frame;
    rect.origin.x = 20 + TABLE_LEFT_BOUNDARY + cellWidth * 4;
    _dummyTitleSE.frame = rect;
    
    rect = _totalScoreCell.frame;
    rect.origin.x = 20;
    rect.size.width = self.bounds.size.width - 40;
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
    for (UITextField *textField in _textFields)
    {
        [textField resignFirstResponder];
    }
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
