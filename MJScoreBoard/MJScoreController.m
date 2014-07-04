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
@interface MJScoreController ()
{
    
    NSMutableArray* _penaltyAction;
    NSInteger _pScores[4];
    MJOneRound *_tempResult;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *winnerControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *loserControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *changeScoreControl;
@property (strong, nonatomic) IBOutlet UIButton *btnSetPenalty;
@property (strong, nonatomic) IBOutlet UIButton *btnSetScoreElement;

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *loserLabel;


- (IBAction)selectPlayer:(UISegmentedControl *)sender;
- (IBAction)CloseMe:(id)sender;
- (IBAction)ChangeScore:(UISegmentedControl *)sender;

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
    [_changeScoreControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    _changeScoreControl.selectedSegmentIndex = UISegmentedControlNoSegment;
    
    for (int i=0; i<4; i++)
    {
        [_winnerControl setTitle:[_playerNames objectAtIndex:i] forSegmentAtIndex:i];
        [_loserControl setTitle:[_playerNames objectAtIndex:i] forSegmentAtIndex:i];
    }
    if (_originalResult == nil)
    {
        _tempResult = [[MJOneRound alloc] init];
        [self refreshControlStates:4];
    }
    else
    {
        _tempResult = [_originalResult copy];
        [self refreshControlStates:[_originalResult.nWinner integerValue]];
        _winnerControl.selectedSegmentIndex = [_originalResult.nWinner intValue];
        _loserControl.selectedSegmentIndex = [_originalResult.nLoser intValue];
        _scoreLabel.text = [NSString stringWithFormat:@"%d", [_originalResult.nScore intValue]];
    }
    [self setPenaltyButtonTitle];
    [self setScoreElementButtonTitle];
    
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
    }
}


- (IBAction)CloseMe:(id)sender
{
    _tempResult.nWinner = [NSNumber numberWithInteger:_winnerControl.selectedSegmentIndex];
    _tempResult.nLoser = [NSNumber numberWithInteger:_loserControl.selectedSegmentIndex ];
    _tempResult.nScore = [NSNumber numberWithInteger: _scoreLabel.text.integerValue];

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

- (IBAction)ChangeScore:(UISegmentedControl *)sender
{
    NSInteger score = _scoreLabel.text.integerValue;
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            score -= 20;
            break;
        case 1:
            score -= 5;
            break;
        case 2:
            score -= 1;
            break;
        case 3:
            score += 1;
            break;
        case 4:
            score += 5;
            break;
        case 5:
            score += 20;
            break;
        default:
            break;
    }
    score = score < 8 ? 8 : score;
    _scoreLabel.text = [NSString stringWithFormat:@"%d", (int)score];
    
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
    if ([segue.identifier isEqualToString:@"SetElementScore"])
    {
        UIViewController* dest  = segue.destinationViewController;
        if ([dest respondsToSelector:@selector(setSelectedScoreElements:)])
        {
            [dest setValue:_tempResult.scoreElements forKey:@"selectedScoreElements"];
        }
    }
}

- (IBAction)doneWithScoreElement:(UIStoryboardSegue* )segue
{
    MJScoreElementViewController *sourceController =  segue.sourceViewController;
    _tempResult.scoreElements = sourceController.selectedScoreElements;
    [self setScoreElementButtonTitle];
}

#pragma mark PrivateMethods


- (void)refreshControlStates:(NSInteger)selectedIndex
{
    if (selectedIndex == 4)
    {
        _loserControl.hidden = YES;
        _loserControl.selectedSegmentIndex = -1;
        _loserLabel.hidden = YES;
        _scoreLabel.hidden = YES;
        _scoreLabel.text = @"0";
        _changeScoreControl.hidden = YES;
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
        if (_scoreLabel.hidden == YES)
        {
            _scoreLabel.text = @"8";
        }
        _scoreLabel.hidden = NO;
        _changeScoreControl.hidden = NO;

    }
}

- (void)setPenaltyButtonTitle
{
    NSString *penaltyButtonTitle = [NSString stringWithFormat:@"罚分: %@:%@  %@:%@  %@:%@  %@:%@",
                                    _playerNames[0], _tempResult.penaltyScores[0],
                                    _playerNames[1], _tempResult.penaltyScores[1],
                                    _playerNames[2], _tempResult.penaltyScores[2],
                                    _playerNames[3], _tempResult.penaltyScores[3], nil];
    [_btnSetPenalty setTitle:penaltyButtonTitle forState:UIControlStateNormal];
    
}

- (void)setScoreElementButtonTitle
{
    NSString *labelText = @"番种: ";
    for (NSString *toDisplay in _tempResult.scoreElements)
    {
        labelText = [NSString stringWithFormat:@"%@ %@", labelText, toDisplay];
    }
    [_btnSetScoreElement setTitle:labelText forState:UIControlStateNormal];

}

#pragma mark MJSetPenaltyScoreDelegate
- (NSArray *)penaltyScores
{
    return _tempResult.penaltyScores;
}

- (void)setPenaltyScores:(NSMutableArray *)penaltyScores
{
    _tempResult.penaltyScores = penaltyScores;
}

- (void)didSetPenaltyScores
{
    [self setPenaltyButtonTitle];
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
