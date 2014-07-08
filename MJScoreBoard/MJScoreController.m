//
//  MJScoreController.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-2-26.
//  Copyright (c) 2014年 Self. All rights reserved.
//
#import "MJDetailViewController.h"
#import "MJScoreController.h"
#import "MJScoreElementViewController.h"
#import "MJOneRound.h"
#import "MJScoreAdjustControl.h"
#import "MJMiniSummaryTable.h"

@interface MJScoreController ()
{
    
    NSMutableArray* _penaltyAction;
    NSInteger _pScores[4];
    MJOneRound *_tempResult;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *winnerControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *loserControl;

@property (strong, nonatomic) IBOutlet UILabel *loserLabel;
@property (strong, nonatomic) IBOutlet MJScoreAdjustControl *scoreAdjustControl;
@property (strong, nonatomic) IBOutlet MJMiniSummaryTable *summaryTable;


- (IBAction)selectPlayer:(UISegmentedControl *)sender;
- (IBAction)CloseMe:(id)sender;

@end

@implementation MJScoreController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIFont *font = [UIFont boldSystemFontOfSize:20.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    [_winnerControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [_loserControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    for (int i=0; i<4; i++)
    {
        [_winnerControl setTitle:[_playerNames objectAtIndex:i] forSegmentAtIndex:i];
        [_loserControl setTitle:[_playerNames objectAtIndex:i] forSegmentAtIndex:i];
    }
    if (_originalResult == nil)
    {
        _tempResult = [[MJOneRound alloc] init];
        [self refreshControlStates:-1];
    }
    else
    {
        _tempResult = [_originalResult copy];
        [self refreshControlStates:[_originalResult.nWinner integerValue]];
        _winnerControl.selectedSegmentIndex = [_originalResult.nWinner intValue];
        _loserControl.selectedSegmentIndex = [_originalResult.nLoser intValue];
        [_scoreAdjustControl reloadData];
    }
    [_summaryTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectPlayer:(UISegmentedControl *)sender
{
    if (sender == _winnerControl)
    {
        [self refreshControlStates:_winnerControl.selectedSegmentIndex];
    }
    else if (sender == _loserControl)
    {
        if(_winnerControl.selectedSegmentIndex == sender.selectedSegmentIndex)
        {
            _winnerControl.selectedSegmentIndex = -1;
        }
        _tempResult.nLoser = [NSNumber numberWithInteger:sender.selectedSegmentIndex];
        [_summaryTable reloadData];
    }
}


- (IBAction)CloseMe:(id)sender
{
    _tempResult.nWinner = [NSNumber numberWithInteger:_winnerControl.selectedSegmentIndex];
    _tempResult.nLoser = [NSNumber numberWithInteger:_loserControl.selectedSegmentIndex ];
    
    if ([_tempResult.nWinner integerValue] != 4
        && [_tempResult.nWinner integerValue] != -1
        && [_tempResult.nLoser integerValue] == -1 )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"未指定点炮者！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if(_originalResult) //修改现有战绩
    {
        if([_tempResult isEqual:_originalResult])
        {
            //若没被修改，直接退出
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            NSArray* winds = [[NSArray alloc] initWithObjects:@"东", @"南", @"西", @"北", nil];
            NSArray* nums = [[NSArray alloc] initWithObjects:@"一局", @"二局", @"三局", @"四局", nil];
            NSString *title = [NSString stringWithFormat:@"%@%@",  [winds objectAtIndex:[_indexPath section]], [nums objectAtIndex:[_indexPath row]], nil];
            //若被修改，弹出警告
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:@"当前局成绩已修改，保存吗？" delegate:self cancelButtonTitle:@"放弃修改" otherButtonTitles:@"保存修改", nil];
            [alert show];
        }
    }
    else
    {
        //新局，直接保存退出
        if ([_tempResult isValid])
        {
            [_parentController updateRow:_tempResult atIndexPath:_indexPath];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"SetPenalty"])
    {
        UIViewController* dest = segue.destinationViewController;
        if ([dest respondsToSelector:@selector(setDelegate:)])
        {
            [dest setValue:self forKey:@"delegate"];
        }
    }
    if ([segue.identifier isEqualToString:@"SetScoreElement"])
    {
        UIViewController* dest  = segue.destinationViewController;
        if ([dest respondsToSelector:@selector(setSelectedScoreElements:)])
        {
            [dest setValue:_tempResult.scoreElements forKey:@"selectedScoreElements"];
        }
    }
}

- (IBAction)doneWithScoreSettings:(UIStoryboardSegue* )segue
{
    [_summaryTable reloadData];
}

#pragma mark PrivateMethods


- (void)refreshControlStates:(NSInteger)selectedIndex
{
    if (selectedIndex == 4 || selectedIndex == -1)
    {
        _loserControl.hidden = YES;
        _loserControl.selectedSegmentIndex = -1;
        _loserLabel.hidden = YES;
        _scoreAdjustControl.hidden = YES;
        _tempResult.nScore = [NSNumber numberWithInt:0];
        _tempResult.nLoser = [NSNumber numberWithInt:-1];
        [_tempResult.scoreElements removeAllObjects];
    }
    else
    {
        _loserControl.hidden = NO;
        _loserControl.hidden = NO;
        _loserLabel.hidden = NO;
        if(_loserControl.selectedSegmentIndex == selectedIndex)
        {
            _loserControl.selectedSegmentIndex = -1;
        }
        for (int i = 0; i<5; i++)
        {
            [_loserControl setEnabled:i!=selectedIndex forSegmentAtIndex:i];
            
        }
        if (_scoreAdjustControl.hidden == YES)
        {
            _tempResult.nScore = [NSNumber numberWithInt:8];
        }
        _scoreAdjustControl.hidden = NO;
    }
    _tempResult.nWinner = [NSNumber numberWithInteger:selectedIndex];
    [_scoreAdjustControl reloadData];
    [_summaryTable reloadData];
}


#pragma mark MJMiniSummaryTableDelegate

- (MJOneRound*)getCurrentRound
{
    return _tempResult;
}

#pragma mark MJScoreAdjustControlDelegate

- (NSNumber*)currentScore
{
    return _tempResult.nScore;
}

- (void)setCurrentScore:(NSNumber *)currentScore
{
    _tempResult.nScore = currentScore;
}

- (void)adjustScore:(NSInteger)offset
{
    NSInteger newScore = [_tempResult.nScore integerValue] + offset;
    newScore = newScore < 8 ? 8: newScore;
    _tempResult.nScore = [NSNumber numberWithInteger:newScore];
    [_scoreAdjustControl reloadData];
    [_summaryTable reloadData];
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    assert(_originalResult);
    if (buttonIndex == 1 && [_tempResult isValid])
    {
        [_parentController updateRow:_tempResult atIndexPath:_indexPath];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
