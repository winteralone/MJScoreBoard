//
//  MJPenaltyViewController.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-17.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJPenaltyViewController.h"
#import "MJOneRound.h"

@interface MJPenaltyViewController ()
{
    NSInteger _pScores[4];
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *penaltyPlayerControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *penaltyModeControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *benefitPlayerControl;
@property (strong, nonatomic) IBOutlet UIButton *btnResetPenaltyScore;
@property (strong, nonatomic) NSMutableArray *penaltyScoreLabels;

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
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    [_penaltyPlayerControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [_benefitPlayerControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [_penaltyModeControl   setTitleTextAttributes:attributes forState:UIControlStateNormal];
    _penaltyModeControl.selectedSegmentIndex = 1;
    _penaltyPlayerControl.selectedSegmentIndex = UISegmentedControlNoSegment;
    [self setPenaltyMode:_penaltyModeControl];

    _penaltyScoreLabels = [[NSMutableArray alloc] init];
    CGRect rect = _penaltyPlayerControl.frame;
    rect.size = CGSizeMake(rect.size.width / 4, rect.size.height);
    rect.origin.y += 40;
    for (int i=0; i<4; i++)
    {
        rect.origin.x = _penaltyPlayerControl.frame.origin.x + rect.size.width * i;
        UILabel * label = [[UILabel alloc]initWithFrame:rect];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:30];
        [_penaltyScoreLabels addObject:label];
        [self.view addSubview:label];
        
        [_penaltyPlayerControl setTitle:_playerNames[i] forSegmentAtIndex:i];
        [_benefitPlayerControl setTitle:_playerNames[i] forSegmentAtIndex:i];
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

- (IBAction)setPenaltyMode:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 2)
    {
        _benefitPlayerControl.hidden = NO;
    }
    else
    {
        _benefitPlayerControl.hidden = YES;
    }
}

- (IBAction)AddPenaltyScore:(UIButton*)sender
{
    NSInteger punishedPlayer = _penaltyPlayerControl.selectedSegmentIndex;
    NSInteger penaltyMode = _penaltyModeControl.selectedSegmentIndex;
    if (punishedPlayer == UISegmentedControlNoSegment || penaltyMode == UISegmentedControlNoSegment)
    {
        return;
    }
    NSInteger benefitedPlayer = _benefitPlayerControl.selectedSegmentIndex;
    NSInteger penaltyScore = - [sender.titleLabel.text integerValue];
    
    switch (penaltyMode)
    {
        case 0:  //扣分
            _pScores[punishedPlayer] -= penaltyScore;
            break;
        case 1: //罚付三家
            _pScores[punishedPlayer] -= 3*penaltyScore;
            for (int i=0; i<4; i++)
            {
                if( punishedPlayer != i)
                {
                    _pScores[i] += penaltyScore;
                }
            }
            break;
        case 2:
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
        [_benefitPlayerControl setEnabled:sender.selectedSegmentIndex!=i forSegmentAtIndex:i];
    }
}

- (void)refreshPenaltyLabelText
{
    for (int i=0; i<4; i++)
    {
        _penaltyScores[i] = [NSNumber numberWithInteger:_pScores[i]];
        UILabel *label = _penaltyScoreLabels[i];
        label.text = [_penaltyScores[i] stringValue];
    }
    
}

- (void)setDelegate:(UIViewController<MJMiniSummaryTableDelegate> *)delegate
{
    _penaltyScores = [delegate getCurrentRound].penaltyScores;
    _playerNames = delegate.playerNames;
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

@end
