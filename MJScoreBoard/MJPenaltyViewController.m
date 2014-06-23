//
//  MJPenaltyViewController.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-17.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJPenaltyViewController.h"

@interface MJPenaltyViewController ()
{
    NSInteger _pScores[4];
}

- (IBAction)CloseMe;
@property (strong, nonatomic) IBOutlet UISegmentedControl *penaltyPlayerControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *penaltyModeControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *addPenaltyScoreControl;
@property (strong, nonatomic) IBOutlet UIButton *btnResetPenaltyScore;
@property (strong, nonatomic) IBOutlet UILabel *penaltyScoreLabel;

@property (weak, nonatomic) NSArray *playerNames;
@property (strong, nonatomic) NSMutableArray *penaltyScores;

- (IBAction)ResetPenaltyScore;
- (IBAction)AddPenaltyScore:(UISegmentedControl *)sender;
- (IBAction)selectPenaltyPlayer:(UISegmentedControl *)sender;


@end

@implementation MJPenaltyViewController

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
    
    [_penaltyPlayerControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [_addPenaltyScoreControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    _addPenaltyScoreControl.selectedSegmentIndex = UISegmentedControlNoSegment;
    _penaltyPlayerControl.selectedSegmentIndex = UISegmentedControlNoSegment;
    

    for (int i=0; i<4; i++)
    {
        [_penaltyPlayerControl setTitle:[_playerNames objectAtIndex:i] forSegmentAtIndex:i];
        [_penaltyModeControl setTitle:[NSString stringWithFormat:@"付给%@", [_playerNames objectAtIndex:i] ] forSegmentAtIndex:i+2];
        _pScores[i] = [_penaltyScores[i] integerValue];
    }
    [self refreshPenaltyLabelText];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ResetPenaltyScore
{
    for (int i=0; i<4; i++)
    {
        _pScores[i] = 0;
    }
    [self refreshPenaltyLabelText];
}

- (IBAction)AddPenaltyScore:(UISegmentedControl *)sender
{
    NSInteger punishedPlayer = _penaltyPlayerControl.selectedSegmentIndex;
    NSInteger penaltyMode = _penaltyModeControl.selectedSegmentIndex;
    if (punishedPlayer == UISegmentedControlNoSegment || penaltyMode == UISegmentedControlNoSegment)
    {
        return;
    }
    NSInteger benefitedPlayer = penaltyMode - 2;
    NSInteger penaltyScore = (sender.selectedSegmentIndex + 1) * 5;
    
    switch (penaltyMode)
    {
        case 0:  //罚付三家
            _pScores[punishedPlayer] -= 3*penaltyScore;
            for (int i=0; i<4; i++)
            {
                if( punishedPlayer != i)
                {
                    _pScores[i] += penaltyScore;
                }
            }
            break;
        case 1: //扣分
            _pScores[punishedPlayer] -= penaltyScore;
            break;
        case 2:
        case 3:
        case 4:
        case 5:
            //支付给某一个玩家
            _pScores[punishedPlayer] -= penaltyScore;
            _pScores[benefitedPlayer] += penaltyScore;
            break;
        default:
            break;
    }

    [self refreshPenaltyLabelText];
    
    
}

- (IBAction)selectPenaltyPlayer:(UISegmentedControl *)sender
{
    for (int i=0; i<4; i++)
    {
        [_penaltyModeControl setEnabled:sender.selectedSegmentIndex!=i forSegmentAtIndex:i+2];
    }
}

- (void)refreshPenaltyLabelText
{
    for (int i=0; i<4; i++)
    {
        _penaltyScores[i] = [NSNumber numberWithInteger:_pScores[i]];
    }
    _penaltyScoreLabel.text = [NSString stringWithFormat:@"%@                %@                %@               %@",
                              _penaltyScores[0], _penaltyScores[1], _penaltyScores[2], _penaltyScores[3]];
    
}

- (void)setDelegate:(UIViewController<MJSetPenaltyDelegate> *)delegate
{
    _penaltyScores = delegate.penaltyScores;
    _playerNames = delegate.playerNames;
    _delegate = delegate;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)CloseMe
{
    [_delegate didSetPenaltyScores];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
