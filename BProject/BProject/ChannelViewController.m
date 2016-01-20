//
//  ChannelViewController.m
//  BProject
//
//  Created by lanouhn on 15/12/25.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "ChannelViewController.h"
#import "PlayViewController.h"
#import "ChangnelBottomCell.h"
#import "OnetopCell.h"
#import "OneOtherCell.h"
#import "NetWork.h"
#import "ChannelBottomModel.h"
#import "ChannelTopModel.h"
#import "PodcastRadioVC.h"
#import "MoodVC.h"
#import "TodayThemeVC.h"
#import "TodayHotVC.h"
#import "LatestNewVC.h"
#import "OurListenVC.h"

@interface ChannelViewController ()<UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *channelBottomArray;
@property (nonatomic, strong)NSArray *imageNameArray;
@property (nonatomic, strong)NSArray *nameArray;
@property (nonatomic, strong) ChannelTopModel *channelTopModel;
@end

@implementation ChannelViewController
- (IBAction)menuButton:(id)sender {
    [self.mm_drawerController toggleDrawerSide:(MMDrawerSideLeft) animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.channelBottomArray = [@[] mutableCopy];
    self.imageNameArray = @[@"hot", @"list", @"latest", @"our"];
    self.nameArray = @[@"热门话题", @"排行榜", @"最近新增", @"大家在听"];
    // Do any additional setup after loading the view.
    [self.collectionView registerNib:[UINib nibWithNibName:@"OnetopCell" bundle:nil] forCellWithReuseIdentifier:@"OnetopCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"OneOtherCell" bundle:nil] forCellWithReuseIdentifier:@"OneOtherCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ChangnelBottomCell" bundle:nil] forCellWithReuseIdentifier:@"ChangnelBottomCell"];
    [self getData];
}
- (void)getData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:@"http://api.duotin.com/user/subscribecategories?device_key=356633056895293&platform=android&source=danxinben&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&channel=m360&version=2.7.12" success:^(id obj) {
        for (NSDictionary *dic in obj[@"data"][@"subscribed_categories"]) {
            ChannelBottomModel *model = [ChannelBottomModel channelBottomModelWithDic:dic];
            [self.channelBottomArray addObject:model];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.collectionView reloadData];
    }];
    [net getNetwork:@"http://api.duotin.com/podcast/latest?platform=android&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&channel=m360&device_key=A000004E60D1EF" success:^(id obj) {
        //
        self.channelTopModel = [ChannelTopModel  channelTopModelWithDic:obj[@"data"]];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return self.channelBottomArray.count;
    } else {
        return 5;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        OnetopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OnetopCell" forIndexPath:indexPath];

        cell.label2.text = [NSString stringWithFormat:@"%@播客入住", self.channelTopModel.podcast_num];
        [cell.image3 sd_setImageWithURL:[NSURL URLWithString:self.channelTopModel.photoNameArray[0][@"image_url"]]];
        [cell.image2 sd_setImageWithURL:[NSURL URLWithString:self.channelTopModel.photoNameArray[1][@"image_url"]]];
        [cell.image4 sd_setImageWithURL:[NSURL URLWithString:self.channelTopModel.photoNameArray[2][@"image_url"]]];
        
        
        return cell;
    } else if (indexPath.section == 0 && indexPath.row != 0){
        OneOtherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OneOtherCell" forIndexPath:indexPath];
        cell.photoView.image =[UIImage imageNamed:self.imageNameArray[indexPath.row - 1]];
        cell.label.text = self.nameArray[indexPath.row - 1];
        return cell;
    }
    else  {
        ChangnelBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChangnelBottomCell" forIndexPath:indexPath];
        ChannelBottomModel *model = self.channelBottomArray[indexPath.row];
        cell.model = model;
        return cell;
    }

}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return CGSizeMake(KScreenWidth, KScreenHeight/ 10);
    } else if(indexPath.section == 0 && indexPath.row != 0){
        return CGSizeMake((KScreenWidth - 30)/2, KScreenHeight/ 10);
    }
    else {
        return CGSizeMake((KScreenWidth - 50)/ 4, 3 *(KScreenWidth - 50)/ 8);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"toPodcastRadioVC" sender:nil];
    } else if(indexPath.section == 1){
        ChannelBottomModel *model = self.channelBottomArray[indexPath.row];
        [self performSegueWithIdentifier:@"toMoodVC" sender:model.ID];
    } else if(indexPath.section == 0 && indexPath.row == 1){
        [self performSegueWithIdentifier:@"toTodayThemeVC" sender:nil];
    } else if (indexPath.section == 0 && indexPath.row == 2){
        [self performSegueWithIdentifier:@"toTodayHotVC" sender:nil];
    } else if (indexPath.section == 0 && indexPath.row == 3){
        [self performSegueWithIdentifier:@"toLatestNewVC" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"toOurListenVC" sender:nil];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)search:(id)sender {
    
    [self performSegueWithIdentifier:@"toPlayViewController" sender:nil];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toPlayViewController"]) {
       // PlayViewController *playViewController = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"toPodcastRadioVC"]) {
        //PodcastRadioVC *padcastRadioVC = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"toMoodVC"]) {
        MoodVC *moodVC = segue.destinationViewController;
        moodVC.redirect_value = sender;
    }
    if ([segue.identifier isEqualToString:@"toTodayThemeVC"]) {
        //TodayThemeVC *todayVC = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"toTodayHotVC"]) {
        //TodayHotVC *todayHotVC = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"toLatestNewVC"]) {
       // LatestNewVC *latestNewVC = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"toOurListenVC"]) {
        //OurListenVC *ourListenVC = segue.destinationViewController;
    }
    
}


@end
