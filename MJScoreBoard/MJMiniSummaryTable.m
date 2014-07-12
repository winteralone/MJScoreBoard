//
//  MJMiniSummaryTable.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-7-8.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJMiniSummaryTable.h"
#import "MJScoreDelegates.h"
#import "MJOneRound.h"

@interface MJMiniSummaryTable ()
@property IBOutlet UIViewController<MJMiniSummaryTableDelegate> *delegate;
@property NSMutableArray* rawScoreLabels;
@property NSMutableArray* penaltyScoreLabels;
@property NSMutableArray* totalScoreLabels;
@property UILabel* scoreElementLabel;
@end

@implementation MJMiniSummaryTable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UILabel*)addLabelWithTitle:(NSString*)title atXPos:(NSInteger)x YPos:(NSInteger)y width:(NSInteger)w
{
    CGFloat cellWidth = (self.bounds.size.width - 40) / 5;
    CGFloat cellHeight = self.bounds.size.height / 5;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(cellWidth*x, cellHeight*y, cellWidth*w, cellHeight)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.font = [UIFont systemFontOfSize:24];
    label.adjustsFontSizeToFitWidth = YES;
    [self addSubview:label];
    return label;
    
}

- (void)awakeFromNib
{
    for (int i=0; i<4; i++)
    {
        if ([[_delegate playerNames]count] > i)
        {
            [self addLabelWithTitle:[_delegate playerNames][i] atXPos:i+1 YPos:0 width:1] ;
        }
    }
    [self addLabelWithTitle:@"得分" atXPos:0 YPos:1 width:1];
    [self addLabelWithTitle:@"罚分" atXPos:0 YPos:2 width:1];
    [self addLabelWithTitle:@"合计" atXPos:0 YPos:3 width:1];
    [self addLabelWithTitle:@"番种" atXPos:0 YPos:4 width:1];
    _rawScoreLabels = [[NSMutableArray alloc] init];
    _penaltyScoreLabels = [[NSMutableArray alloc] init];
    _totalScoreLabels = [[NSMutableArray alloc] init];
    for (int i=1; i<=4; i++)
    {
        [_rawScoreLabels addObject: [self addLabelWithTitle:@"0" atXPos:i YPos:1 width:1] ];
        [_penaltyScoreLabels addObject: [self addLabelWithTitle:@"0" atXPos:i YPos:2 width:1] ];
        [_totalScoreLabels addObject: [self addLabelWithTitle:@"0" atXPos:i YPos:3 width:1] ];

    }
    _scoreElementLabel = [self addLabelWithTitle:@"番种" atXPos:1 YPos:4 width:4];
    
    CGFloat cellWidth = (self.bounds.size.width - 40) / 5;
    CGFloat cellHeight = self.bounds.size.height / 5;
    
    UIButton *buttonSetPenalty = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    buttonSetPenalty.frame = CGRectMake(cellWidth * 5 , cellHeight *2, 40, 40 );
    [self addSubview:buttonSetPenalty];
    [buttonSetPenalty addTarget:self action:@selector(setPenalty:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonSetScoreElement = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    buttonSetScoreElement.frame = CGRectMake(cellWidth * 5 , cellHeight *4, 40, 40 );
    [self addSubview:buttonSetScoreElement];
    [buttonSetScoreElement addTarget:self action:@selector(setScoreElement:) forControlEvents:UIControlEventTouchUpInside];

}

- (IBAction)setPenalty:(id)sender
{
    [self.delegate performSegueWithIdentifier:@"SetPenalty" sender:self.delegate];
    
}

- (IBAction)setScoreElement:(id)sender
{
    [self.delegate performSegueWithIdentifier:@"SetScoreElement" sender:self.delegate];
}

- (void)reloadData
{
    NSArray* scores = [[_delegate getCurrentRound] getScore];
    if (scores)
    {
        for (int i=0; i<4; i++)
        {
            UILabel* label = _totalScoreLabels[i];
            label.text = [(NSNumber*)scores[i] stringValue];
        }
    }
    NSArray* rawScores = [[_delegate getCurrentRound]getRawScore];
    if (rawScores)
    {
        for (int i=0; i<4; i++)
        {
            UILabel *label = _rawScoreLabels[i];
            label.text = [(NSNumber*)rawScores[i] stringValue];
        }
    }
    for (int i=0; i<4; i++)
    {
        UILabel* penaltyLabel = _penaltyScoreLabels[i];
        NSNumber *penaltyScore = [_delegate getCurrentRound].penaltyScores[i];
        penaltyLabel.text = [penaltyScore stringValue];
    }
    NSString *labelText = @"";
    for (NSString *toDisplay in [_delegate getCurrentRound].scoreElements)
    {
        labelText = [NSString stringWithFormat:@"%@ %@", labelText, toDisplay];
    }
    _scoreElementLabel.text = labelText;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGFloat cellWidth = (self.bounds.size.width - 40) / 5;
    CGFloat cellHeight = self.bounds.size.height / 5;

    UIBezierPath *path = [[UIBezierPath alloc]init];
    [[UIColor blackColor] setStroke];
    [path moveToPoint:CGPointMake(0, cellHeight)];
    [path addLineToPoint:CGPointMake(cellWidth*5, cellHeight)];
    [path moveToPoint:CGPointMake(0, cellHeight*3)];
    [path addLineToPoint:CGPointMake(cellWidth*5, cellHeight*3)];
    [path moveToPoint:CGPointMake(0, cellHeight*4)];
    [path addLineToPoint:CGPointMake(cellWidth*5, cellHeight*4)];
    [path stroke];
    
}


@end
