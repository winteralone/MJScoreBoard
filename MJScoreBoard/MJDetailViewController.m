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

@interface MJDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *playerName1;
@property (weak, nonatomic) IBOutlet UITextField *playerName2;
@property (weak, nonatomic) IBOutlet UITextField *playerName3;
@property (weak, nonatomic) IBOutlet UITextField *playerName4;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation MJDetailViewController
- (IBAction)PlayerNameChanged:(UITextField *)sender
{
    [sender resignFirstResponder];
}

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

    [_tableView reloadData];
    
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
    [_tableView reloadData];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveCurrentGame
{
    MJMasterViewController *masterController = (MJMasterViewController*)[[[self.splitViewController viewControllers] firstObject] topViewController];
    MJOneGame *game = [[MJOneGame alloc] init];
    game.gameName = [self.navigationItem.title copy];
    game.playerNames = [[NSArray alloc]initWithObjects:_playerName1.text, _playerName2.text, _playerName3.text, _playerName4.text, nil];
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
        _playerName1.text = game.playerNames[0];
        _playerName2.text = game.playerNames[1];
        _playerName3.text = game.playerNames[2];
        _playerName4.text = game.playerNames[3];
        self.navigationItem.title = game.gameName;
        for (NSInteger i=0; i<16; i++)
        {
            if ( [_rawScoreList[i] isKindOfClass: [NSNumber class]])
            {
                _currentRound = i;
                break;
            }
        }
        [self calculateScores];
        [_tableView reloadData];
    }
}

#pragma mark - table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSInteger currIndex = indexPath.section * 4 + indexPath.row;

    if (currIndex == _currentRound)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"NewRound"];
        [cell setUserInteractionEnabled:YES];
    }
    else if (currIndex > _currentRound)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"OneRound"];
        [cell setHidden:YES];
    }
    else if (currIndex < _currentRound)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"OneRound"];
        if ( [[_oneRoundScoreList objectAtIndex:currIndex] isKindOfClass:[NSArray class]]
            && [[_totalScoreList objectAtIndex:currIndex] isKindOfClass:[NSArray class]] )
        {
            for (int i=0; i<4; i++)
            {
                UITextView* currText = (UITextView*)[cell viewWithTag:i*2 + 1];
                NSNumber *value = [[_oneRoundScoreList objectAtIndex:currIndex] objectAtIndex:i];
                currText.text = [NSString stringWithFormat:@"%@", value];
                currText = (UITextView *)[cell viewWithTag:(i+1)*2];
                value = [[_totalScoreList objectAtIndex:currIndex] objectAtIndex:i];
                currText.text = [NSString stringWithFormat:@"%@", value];
            }
        }
    }
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return @"东";
            break;
        case 1:
            return @"南";
            break;
        case 2:
            return @"西";
            break;
        case 3:
            return @"北";
            break;
        default:
            return nil;
            break;
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
    NSMutableArray* tmpNames = [[NSMutableArray alloc]initWithObjects:_playerName1.text, _playerName2.text, _playerName3.text, _playerName4.text, nil];
    NSArray *defaultName = [[NSArray alloc] initWithObjects:@"东家", @"南家", @"西家", @"北家", nil];
    for (NSInteger i=0; i<4; i++)
    {
        if ([[tmpNames objectAtIndex:i] isEqualToString: @""])
        {
            [tmpNames replaceObjectAtIndex:i withObject:[defaultName objectAtIndex:i ]];
        }
    }
    scoreController.playerNames = tmpNames;

    scoreController.parentController = self;
    NSIndexPath* indexPath = [_tableView indexPathForCell:sender];
    scoreController.indexPath = indexPath;
    NSInteger arrayIndex = indexPath.section * 4 + indexPath.row;
    if ([[_rawScoreList objectAtIndex:arrayIndex] isKindOfClass:[MJOneRound class]])
    {
        scoreController.originalResult = [_rawScoreList objectAtIndex:arrayIndex];
    }
}

@end
