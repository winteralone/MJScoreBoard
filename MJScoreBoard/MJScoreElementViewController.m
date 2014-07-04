//
//  MJScoreElementViewController.m
//  MJScoreBoard
//
//  Created by Yan Wei on 14-6-27.
//  Copyright (c) 2014年 Self. All rights reserved.
//

#import "MJScoreElementViewController.h"
#import "MJCustomButton.h"
#import "MJScoreElementCell.h"
#import "MJScoreElementHeaderView.h"

@interface MJScoreElementViewController ()
@property NSArray *scoreElementList;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UILabel *scoreElementLabel;
@end

@implementation MJScoreElementViewController

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
    _scoreElementList = [[NSArray alloc]initWithObjects:
                         [NSArray arrayWithObjects:@4, @"全带幺",@"不求人", @"双明杠", @"和绝张",   nil],
                         [NSArray arrayWithObjects:@6,  @"碰碰和", @"混一色", @"三色三步高", @"五门齐",  @"全求人", @"双箭刻", nil],
                         [NSArray arrayWithObjects:@8, @"花龙", @"推不倒", @"三色三同顺", @"三色三节高", @"无番和", @"妙手回春", @"海底捞月", @"杠上开花" , @"抢杠和", @"双暗杠", nil],
                         [NSArray arrayWithObjects:@12, @"全不靠", @"组合龙", @"大于五", @"小于五", @"三风刻" , nil],
                         [NSArray arrayWithObjects:@16, @"清龙", @"三色双龙会", @"一色三步高", @"全带五", @"三同刻", @"三暗刻", nil],
                         [NSArray arrayWithObjects:@24, @"七对", @"七星不靠", @"全双刻", @"清一色", @"一色三同顺", @"一色三节高", @"全大", @"全中", @"全小", nil],
                         [NSArray arrayWithObjects:@32, @"一色四步高", @"三杠", @"混幺九", nil],
                         [NSArray arrayWithObjects:@48, @"一色四同顺", @"一色四节高", nil],
                         [NSArray arrayWithObjects:@64, @"清幺九", @"小四喜", @"小三元", @"字一色", @"四暗刻", @"一色双龙会", nil],
                         [NSArray arrayWithObjects:@88, @"大四喜", @"大三元", @"绿一色", @"九莲宝灯", @"四杠", @"连七对", @"十三幺", nil],
                         nil];
    if (!_selectedScoreElements)
    {
        _selectedScoreElements = [[NSMutableArray alloc] init];
    }
    [self refreshScoreElementLabel];
    _collectionView.collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addSelectedScoreElementsObject:(NSString *)object
{

    for (NSString *toAdd in _selectedScoreElements)
    {
        if ([toAdd isEqualToString:object])
        {
            [_selectedScoreElements removeObject:toAdd];
            return;
        }
    }
    [_selectedScoreElements addObject:object];
    
    
}

- (void)refreshScoreElementLabel
{
    NSString *labelText = @"主番种: ";
    for (NSString *toDisplay in _selectedScoreElements)
    {
        labelText = [NSString stringWithFormat:@"%@ %@", labelText, toDisplay];
    }
    _scoreElementLabel.text = labelText;
}


#pragma mark UICollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_scoreElementList count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray* array = _scoreElementList[section];
    return [array count] - 1;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MJScoreElementCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ScoreElementCell" forIndexPath:indexPath];
    if (cell)
    {
        NSArray *array = _scoreElementList[indexPath.section];
        cell.title = array[indexPath.row + 1];        
    }
    return cell;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MJScoreElementHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ScoreElementHeader" forIndexPath:indexPath];
    NSArray* section = _scoreElementList[indexPath.section];
    view.title = [NSString stringWithFormat:@"%@番", section[0], nil ];
    return view;
    
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* names = _scoreElementList[indexPath.section];
    
    [self addSelectedScoreElementsObject:names[indexPath.row + 1]];
    
    [self refreshScoreElementLabel];

}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(100, 35);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 35);
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
