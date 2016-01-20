//
//  HomeViewController.m
//  BProject
//
//  Created by lanouhn on 15/12/25.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "SDCycleScrollView.h"
#import "NetWork.h"
#import "FristModel.h"
#import "SecondModel.h"
#import "OneCollectionViewCell.h"
#import "TwoCollectionViewCell.h"
#import "OtherHeaderView.h"
#import "ThirdCollectionViewCell.h"
#import "PLayerVC.h"
#import "HotRecommendVC.h"
#import "SpecialMoreVC.h"
#import "ListVC.h"
#import "MoodVC.h"
#import "PodcastRadioVC.h"



@interface HomeViewController ()<SDCycleScrollViewDelegate, UICollectionViewDelegateFlowLayout, HomeHeaderViewDelegate, OtherHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray *firstDataArr;
@property (nonatomic, strong) HomeHeaderView *homeHeader;
@end

@implementation HomeViewController
- (IBAction)menuButton:(id)sender {
    [self.mm_drawerController toggleDrawerSide:(MMDrawerSideLeft) animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstDataArr = [NSMutableArray arrayWithCapacity:0];
    
    //_layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    //注册区头视图1
    [self.collection registerClass:[HomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    //注册区头视图2
    [self.collection registerNib:[UINib nibWithNibName:@"OtherHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header2"];
    
    //注册cell1
    [self.collection registerNib:[UINib nibWithNibName:@"OneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collection1"];
    //注册cell2
    [self.collection registerNib:[UINib nibWithNibName:@"TwoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collection2"];
    //注册 cell 3
    [self.collection registerNib:[UINib nibWithNibName:@"ThirdCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collection3"];
    
    [self getData1];//封装首页面的数据
    //明杰下拉刷新
    self.collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData1];
        [self.collection.mj_header endRefreshing];
    }];
    
}

//封装轮播图的数据
- (void)getData1 {
     
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NetWork *network = [[NetWork alloc] init];
    [network getNetwork:@"http://api.duotin.com/homepage/index?device_key=356633056895293&platform=android&source=danxinben&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&channel=m360&version=2.7.12" success:^(id obj) {
        
        //封装数据
        for (NSDictionary *dic in obj[@"data"]) {
           FristModel *firstModel = [FristModel fristModelWithDic:dic];
            [self.firstDataArr addObject:firstModel];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
         [self.collection reloadData];
     }];

}
//跳转到真正的搜索页面
- (IBAction)searchButton:(id)sender {
}

//选择哪个滚动视图
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
   SecondModel *second = [self.firstDataArr.firstObject dataArray][index];

    if (second.item_value.length == 7) {
        [self performSegueWithIdentifier:@"toPlayerVC" sender:second.item_value];
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.firstDataArr.count - 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }else if(section == 8) {
        return [self.firstDataArr[section + 1] dataArray].count;
    }else {
        return 3;
    }
}

//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        OneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection1" forIndexPath:indexPath];
        SecondModel *second = [self.firstDataArr[indexPath.section + 1] dataArray][indexPath.row];
        cell.model = second;
        return cell;
    } else if (indexPath.section == 8){
        ThirdCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection3" forIndexPath:indexPath];
        SecondModel *second = [self.firstDataArr[indexPath.section + 1] dataArray][indexPath.row];
        cell.model = second;
        return cell;
        
    } else {
        TwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection2" forIndexPath:indexPath];
        
        NSMutableArray *array = [self.firstDataArr[indexPath.section + 1] dataArray];
//        NSLog(@"%@", array);
//        NSLog(@"%lu", indexPath.row);
        if (array.count >= indexPath.row + 1) {
            SecondModel *second = array[indexPath.row];
            cell.model = second;
        }

        return  cell;
    }
}
//区头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            if (indexPath.section == 0) {
                self.homeHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
                self.homeHeader.cycleScrollView.delegate = self;
                
                //往 滚动视图 上传值
                for (SecondModel *secondModel in [self.firstDataArr.firstObject dataArray]) {
                    [self.homeHeader.imagesArray addObject:secondModel.image_url];
                }
                
                    FristModel *first =  self.firstDataArr[indexPath.section + 1];
                    self.homeHeader.titleLabel.text  = first.title;
                self.homeHeader.delegate = self;
                //把indexPath的值传过去
                self.homeHeader.index = indexPath;
                return self.homeHeader;
            }
            else {
                OtherHeaderView *other = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header2" forIndexPath:indexPath];
                 FristModel *first =  self.firstDataArr[indexPath.section + 1];
                other.titleLabel.text = first.title;
                other.delegate = self;
                //把indexPath的值传过去
                other.index = indexPath;
                return other;
            }
        }  else {
            UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
            return foot;
        }
    
}

#pragma mark -HeaderViewDelegate
//点击哪个区头视图
- (void)clickButton:(NSIndexPath *)index {
    FristModel *first = self.firstDataArr[index.section + 1];
    if (index.section == 0) {
        
        [self performSegueWithIdentifier:@"HotRecommendVC" sender:first.ID];
    } else if (index.section == 1) {
        [self performSegueWithIdentifier:@"ToSpecialMoreVC" sender:first.ID];
    } else if (index.section == 8) {
        [self performSegueWithIdentifier:@"toPodcastRadioVC" sender:nil];
        
    } else {
        [self performSegueWithIdentifier:@"toMoodVC" sender:first.redirect_value];
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 || indexPath.section == 8 || indexPath.section == 6 || indexPath.section == 7) {//分区是1, 传值到ListVC
        FristModel *model = self.firstDataArr[indexPath.section + 1];
        SecondModel *second = model.dataArray[indexPath.row];
        [self performSegueWithIdentifier:@"toListVC" sender:second.item_value];
    } else {
        FristModel *model = self.firstDataArr[indexPath.section + 1];
        SecondModel *second = model.dataArray[indexPath.row];
        if (second.item_value.length == 7) {
            [self performSegueWithIdentifier:@"toPlayerVC" sender:second.item_value];
        }
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout
//分区间距的大小(上下左右)
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 10, 10, 10);
}

//控制item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        return CGSizeMake(KScreenWidth, 250);
    }  else if (indexPath.section == 8 ){
        return CGSizeMake(KScreenWidth,100);
    } else {
        return CGSizeMake((KScreenWidth - 41)/3, 150);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
//设置区头的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(KScreenWidth, 230);
    } else {
        return CGSizeMake(KScreenWidth, 30);
    }
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toPlayerVC"]) {
        
            PlayerVC *player = segue.destinationViewController;
            player.ID = sender;
    }
    if ([segue.identifier isEqualToString:@"HotRecommendVC"]) {
        HotRecommendVC *hotRecommendVC = segue.destinationViewController;
        hotRecommendVC.ID = sender;
    }
    if ([segue.identifier isEqualToString:@"ToSpecialMoreVC"]) {
        SpecialMoreVC *specialMoreVC = segue.destinationViewController;
        specialMoreVC.ID = sender;
    }
    if ([segue.identifier isEqualToString:@"toListVC"]) {
        ListVC *listVC = segue.destinationViewController;
        listVC.ID = sender;
    }
    if ([segue.identifier isEqualToString:@"toMoodVC"]) {
        MoodVC *moodVC = segue.destinationViewController;
        moodVC.redirect_value = sender;
    }
    if ([segue.identifier isEqualToString:@"toPodcastRadioVC"]) {
        //PodcastRadioVC *podcastRadioVC = segue.destinationViewController;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
