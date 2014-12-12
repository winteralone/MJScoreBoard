//
//  MJViewTargetScoreViewController.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14/12/6.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJViewTargetScoreViewController.h"

//NSComparisonResult

@implementation MJViewTargetScoreViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dict = _scoreInfo[section];
    return [dict allKeys][0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3 - section;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"targetScore"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"targetScore"];
    }
    NSDictionary *dict_self = _scoreInfo[indexPath.section];
    NSDictionary *dict_target = _scoreInfo[indexPath.row + indexPath.section + 1];
    NSInteger self_score = [(NSNumber*)[dict_self allValues][0] integerValue];
    NSInteger target_score = [(NSNumber*)[dict_target allValues][0] integerValue];
    NSInteger nDiff = target_score - self_score;
    NSInteger nPangDian = nDiff - 31;
    NSInteger nDuiDian = ceil( (nDiff - 31) / 2.f );
    NSInteger nZiMo = ceil((nDiff - 31) / 4.f);
        nPangDian = nPangDian < 8? 8 : nPangDian;
        nDuiDian = nDuiDian < 8? 8 : nDuiDian;
        nZiMo = nZiMo < 8? 8 : nZiMo;
    cell.textLabel.text = [NSString stringWithFormat:@"%@: 自摸：%ld, 直击：%ld, 和牌：%ld", [dict_target allKeys][0],  nZiMo, nDuiDian, nPangDian];

    return cell;
}

- (void)viewDidLoad
{
    [_scoreInfo sortUsingComparator:
     ^(id id1, id id2)
    {
        NSDictionary* dict1 = id1;
        NSDictionary* dict2 = id2;
        NSNumber *num1 = [dict1 allValues][0];
        NSNumber *num2 = [dict2 allValues][0];
        if ([num1 intValue] < [num2 intValue])
        {
            return NSOrderedAscending;
        }
        if ([num2 intValue] < [num1 intValue])
        {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
}

- (IBAction)CloseMe
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
