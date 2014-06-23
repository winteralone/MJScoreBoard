//
//  MJMasterViewController.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-2-24.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJMasterViewController.h"

#import "MJDetailViewController.h"
#import "MJOneGame.h"

@interface MJMasterViewController () {
//    NSMutableArray *_objects;
    NSMutableArray *_gameList;
}
@end

@implementation MJMasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    //self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (MJDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    NSString *dateToday = [[[NSDate date] description] substringToIndex:10];
    
    for (int i=1; i<100; i++)
    {
        NSString *gameName = [NSString stringWithFormat:@"%@-%@", dateToday, [[NSNumber numberWithInt:i] stringValue]];
        if ([self containsGame:gameName] == -1)
        {
            MJOneGame *game = [[MJOneGame alloc] initWithName:gameName];
            [self addGame:game];
            break;
        }
    }
}

- (void)addGame:(MJOneGame *)game
{
    if (!_gameList)
    {
        _gameList = [[NSMutableArray alloc] init];
    }
    NSInteger index = [self containsGame:game.gameName];

    if (index != -1)
    {
        _gameList[index] = game;
    }
    else
    {
        [_gameList insertObject:game atIndex:0];
    }
    [self.tableView reloadData];
}

- (NSInteger)containsGame:(NSString *)gameName
{
    for (NSInteger i=0; i<_gameList.count; i++)
    {
        MJOneGame *game= _gameList[i];
        if ( [game.gameName isEqualToString:gameName])
        {
            return i;
        }
    }
    return -1;
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _gameList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    MJOneGame *game = _gameList[indexPath.row];
    cell.textLabel.text = game.gameName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@", game.playerNames[0], game.playerNames[1], game.playerNames[2], game.playerNames[3]];
    return cell;

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_gameList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_detailViewController loadFromMJOneGame:_gameList[indexPath.row]];
    
}

@end
