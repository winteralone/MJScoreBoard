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

@interface MJMasterViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MJMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (NSURL*)getPathURL
{
    return [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];

}

- (NSArray*)getFileList
{
    NSArray* allFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[self getPathURL] path] error:nil];
    NSMutableArray* filteredFiles = [[NSMutableArray alloc]init];
    for (NSString* file in allFiles)
    {
        if ([self isValidFile:file])
        {
            [filteredFiles addObject:file];
        }
    }
    return filteredFiles;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.editButtonItem.title = @"编辑";
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
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
        if ([self containsGame:gameName] == NO)
        {
            MJOneGame *game = [[MJOneGame alloc] initWithName:gameName];
            [self addGame:game];
            break;
        }
    }
}

- (void)addGame:(MJOneGame *)game
{
    [game saveToFile];
    [self.tableView reloadData];
}

- (BOOL)containsGame:(NSString *)gameName
{
    NSURL *url = [self getPathURL];
    return [[NSFileManager defaultManager]fileExistsAtPath:[[url URLByAppendingPathComponent:gameName] path] ];
}

- (BOOL)isValidFile:(NSString*)fileName
{
    NSArray* sections = [fileName componentsSeparatedByString:@"-"];
    if (sections.count == 4
        && ((NSString*)sections[0]).length == 4
        && ((NSString*)sections[1]).length == 2
        && ((NSString*)sections[2]).length == 2
        && ((NSString*)sections[3]).length == 1)
    {
        return YES;
    }
    return NO;
}
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* pathArray = [self getFileList];
    return [pathArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray* pathArray = [self getFileList];
    NSInteger index =  [pathArray count] - 1 - indexPath.row;
    NSString* filename = pathArray[index];
    MJOneGame *game = [[MJOneGame alloc]initWithName:filename];
    [game loadFromFile];
    cell.textLabel.text = pathArray[index];
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
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSURL *path = [self getPathURL];
        NSString* fileName = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;

        [[NSFileManager defaultManager] removeItemAtURL:[path URLByAppendingPathComponent:fileName] error:nil];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *pathArray = [self getFileList];
    NSInteger index = [pathArray count] - 1 - indexPath.row;
    NSString* filename = [[pathArray[index] componentsSeparatedByString:@"."] firstObject];
    MJOneGame *game = [[MJOneGame alloc]initWithName:filename];
    [_detailViewController loadFromMJOneGame:game];
    [self CloseMe];
    
}

- (IBAction)CloseMe
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
