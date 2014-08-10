//
//  MJDetailViewController.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-2-24.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJMasterViewController.h"
#import "MJDetailViewController.h"
#import "MJScoreController.h"
#import "MJOneRound.h"
#import "MJOneGame.h"
#import "MJScoreMainTable.h"
#import "MJScoreMainTableCell.h"
#import "MJScoreMainTableTotalScoreCell.h"

@interface MJDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) MJScoreMainTable *mainTable;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *layoutModeControl;

@end

@implementation MJDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)reset
{
    _oneRoundScoreList = [[NSMutableArray alloc]initWithObjects:@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, nil];
    _rawScoreList = [[NSMutableArray alloc]initWithObjects:@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, nil];
    _totalScoreList = [[NSMutableArray alloc]initWithObjects:@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11, @12, @13, @14, @15, nil];
    _currentRound = 0;

    [_mainTable reloadData];
    
}

- (void)updateRow:(MJOneRound *)result atIndexPath:(NSIndexPath *)indexPath
{
    if (![result isKindOfClass:[MJOneRound class]])
    {
        return;
    }
    NSArray * scores = [result getScore];
    if (scores == nil)
    {
        return;
    }
    else
    {
        NSInteger arrayIndex = indexPath.section * 4 + indexPath.row;
        if (arrayIndex == _currentRound)
        {
            _currentRound++;
        }
        _rawScoreList[arrayIndex] = result;
    }
        
    //刷新总成绩列表
    [self calculateScores];
    [self saveCurrentGame];
    [_mainTable reloadData];
}

- (void)calculateScores
{
    int s[4] = {0, 0, 0, 0};
    for (int i=0; i<16; i++)
    {
        if ([_rawScoreList[i] isKindOfClass:[MJOneRound class]])
        {
            NSArray* currRoundScore = [_rawScoreList[i] getScore];
            if (currRoundScore)
            {
                _oneRoundScoreList[i] = currRoundScore;
                for (int j=0; j<4; j++)
                {
                    s[j] += [currRoundScore[j] intValue];
                }
                NSArray *totalScore = [[NSArray alloc]initWithObjects:
                                       [NSNumber numberWithInt:s[0]],
                                       [NSNumber numberWithInt:s[1]],
                                       [NSNumber numberWithInt:s[2]],
                                       [NSNumber numberWithInt:s[3]],nil];
                _totalScoreList[i] = totalScore;
            }
       
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:34/255.f green:134/255.f blue:86/255.f alpha:1];
    CGRect rect = self.view.bounds;
    CGFloat height = self.navigationController.navigationBar.bounds.size.height + 20;
    rect.origin.y += height;
    rect.size.height -= height;
    _mainTable = [[MJScoreMainTable alloc]initWithFrame:rect];
    _mainTable.delegate = self;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:rect];
    _scrollView.scrollEnabled = YES;
    _scrollView.delegate = self;
    [_scrollView addSubview:_mainTable];
    rect.origin.y = 0;
    _mainTable.frame = rect;
    CGSize size = CGSizeMake(500, TEXT_FIELD_HEIGHT + CELL_HEIGHT + 4 * SECTION_LABEL_HEIGHT + 16 * CELL_HEIGHT + 64);
    _scrollView.contentSize = size;
    [self.view addSubview:_scrollView];

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18]};
    
    [_layoutModeControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self reset];
    
    NSString* dateToday = [[[NSDate date] description] substringToIndex:10];

    MJMasterViewController *masterViewController = (MJMasterViewController*)[[[self.splitViewController viewControllers] firstObject] topViewController];
    int i=1;
    while (1)
    {
        NSString* title = [NSString stringWithFormat:@"%@-%@", dateToday, [[NSNumber numberWithInt:i] stringValue] ];
        if ([masterViewController containsGame:title] == NO )
        {
            [self.navigationItem setTitle:title];
            break;
        }
        i++;
    }

}

- (void)viewWillLayoutSubviews
{
    CGRect rect = _scrollView.frame;
    rect.size = self.view.bounds.size;
    _scrollView.frame = rect;
    rect.origin.y = 0;
    _mainTable.frame = rect;
    [_mainTable setLayout:_layoutModeControl.selectedSegmentIndex];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)setLayoutMode:(UISegmentedControl *)sender
{
    [_mainTable setLayout:sender.selectedSegmentIndex];
}

- (IBAction)saveCurrentGame
{
    MJMasterViewController *masterController = (MJMasterViewController*)[[[self.splitViewController viewControllers] firstObject] topViewController];
    MJOneGame *game = [[MJOneGame alloc] init];
    game.gameName = [self.navigationItem.title copy];
    game.playerNames = [_mainTable playerNames];
    game.rawScoreList = [[NSMutableArray alloc] initWithArray:_rawScoreList copyItems:YES];
    [masterController addGame:game];
        
}

- (void)loadFromMJOneGame:(MJOneGame *)game
{
    if (game)
    {
        [game loadFromFile];
        _rawScoreList = nil;
        _rawScoreList = [[NSMutableArray alloc]initWithArray:game.rawScoreList copyItems:YES];
        self.navigationItem.title = game.gameName;
        for (NSInteger i=0; i<16; i++)
        {
            if ( [_rawScoreList[i] isKindOfClass: [NSNumber class]])
            {
                _currentRound = i;
                break;
            }
        }
        if ([_rawScoreList[15] isKindOfClass:[MJOneRound class]])
        {
            _currentRound = 16;
        }
        [self calculateScores];
        [_mainTable reloadData];
        [_mainTable setPlayerNames:[game.playerNames mutableCopy]];
    }
}
#pragma mark - MJScoreMainTableDelegate

- (void)updateOneRoundCell:(MJScoreMainTableCell*)cell atRound:(NSInteger)round
{
    if (round == _currentRound)
    {
        cell.hidden = NO;
        for (UILabel *label in cell.scoreLabels)
        {
            label.text = @"";
        }
        cell.scoreElementLabel.textAlignment = NSTextAlignmentRight;
        cell.scoreElementLabel.text = @"录入成绩👉";
    }
    else if (round > _currentRound)
    {
        cell.hidden = YES;
    }
    else if (round < _currentRound)
    {
        if ( [[_oneRoundScoreList objectAtIndex:round] isKindOfClass:[NSArray class]]
            && [[_totalScoreList objectAtIndex:round] isKindOfClass:[NSArray class]] )
        {
            for (int i=0; i<4; i++)
            {
                UILabel* currText = (UILabel*)cell.scoreLabels[i*2];
                NSNumber *value = _oneRoundScoreList[round][i];
                currText.text = [value stringValue];
                currText = (UILabel*)cell.scoreLabels[i*2+1];
                value = _totalScoreList[round][i];
                currText.text = [value stringValue];
            }
            NSString *scoreElementText = @"";
            MJOneRound *currRound = _rawScoreList[round];
            for (NSString *se in currRound.scoreElements)
            {
                if (se == [currRound.scoreElements firstObject])
                {
                    scoreElementText = se;
                }
                else
                    scoreElementText = [scoreElementText stringByAppendingFormat:@"、%@", se ];
            }
            if([currRound.nWinner isEqualToNumber:@4])
            {
                scoreElementText = @"荒牌";
            }
            cell.scoreElementLabel.textAlignment = NSTextAlignmentLeft;
            cell.scoreElementLabel.text =scoreElementText;
            cell.hidden = NO;
        }

    }
}

- (void)updateTotalScoreCell:(MJScoreMainTableTotalScoreCell *)cell
{
    if (_currentRound == 0)
    {
        for (UILabel *label in cell.labels)
        {
            label.text = @"0";
        }
        return;
    }
    for (int i=0; i<4; i++)
    {
        if ([_totalScoreList[_currentRound - 1] isKindOfClass:[NSArray class]])
        {
            UILabel* label =  cell.labels[i];
            label.text = [_totalScoreList[_currentRound - 1][i] stringValue];
        }
    }
    
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = @"历史战绩";//NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MJScoreController* scoreController = [segue destinationViewController];
    NSArray *defaultName = @[@"东家", @"南家", @"西家", @"北家"];

    scoreController.parentController = self;
    NSIndexPath* indexPath = [_mainTable indexPathForSender:sender];
    NSMutableArray *tmpNames = [_mainTable playerNames];
    for (int i=0; i<4; i++)
    {
        if ([tmpNames[i] isEqualToString:@""])
        {
            tmpNames[i] = defaultName[i];
        }
    }
    scoreController.playerNames = tmpNames;
    scoreController.indexPath = indexPath;
    NSInteger arrayIndex = indexPath.section * 4 + indexPath.row;
    if ([[_rawScoreList objectAtIndex:arrayIndex] isKindOfClass:[MJOneRound class]])
    {
        scoreController.originalResult = [_rawScoreList objectAtIndex:arrayIndex];
    }
}

@end
