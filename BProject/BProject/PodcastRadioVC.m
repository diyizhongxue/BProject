//
//  PodcastRadioVC.m
//  BProject
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "PodcastRadioVC.h"
#import "RadioOneCollectionViewCell.h"
#import "TopScrollModel.h"
#import "RadiosModel.h"
#import "HotRadioModel.h"
#import "AlbumsCell.h"
#import "HotAlbumsCell.h"
#import "SDCycleScrollView.h"
#import "ListVC.h"
#import "AlbumsOneView.h"
#import "AlbumsTwoView.h"
#import "MarkVC.h"
#import "MarkListVC.h"
@interface PodcastRadioVC ()<SDCycleScrollViewDelegate, AlbumsOneViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *scrollModelArray;
@property (nonatomic, strong) NSMutableArray *radioModelArray;
@property (nonatomic, strong) NSMutableArray *hotRadioModelArray;
@property (nonatomic, assign) NSInteger number;
@end

@implementation PodcastRadioVC
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollModelArray = [@[] mutableCopy];
    self.radioModelArray = [@[] mutableCopy];
    self.hotRadioModelArray = [@[] mutableCopy];
    self.number = 1;
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"RadioOneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"scrollcell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AlbumsCell" bundle:nil] forCellWithReuseIdentifier:@"AlbumsCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HotAlbumsCell" bundle:nil] forCellWithReuseIdentifier:@"HotAlbumsCell"];
    //注册区头
    [self.collectionView registerNib:[UINib nibWithNibName:@"AlbumsOneView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AlbumsOneView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"AlbumsTwoView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AlbumsTwoView"];
    
    self.layout.minimumInteritemSpacing = 0;
    [self getData];//
    //明杰上拉加载
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.number++;
        [self getData1];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
    
}

- (void)getData{
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:@"http://api.duotin.com/radio/index?platform=android&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&channel=m360&device_key=A000004E60D1EF" success:^(id obj) {
        for (NSDictionary *dic in obj[@"data"][@"banner_recommend"]) {
            TopScrollModel *model = [TopScrollModel scrollModelWithDic:dic];
            [self.scrollModelArray addObject:model];
        }
         for (NSDictionary *dic in obj[@"data"][@"new_albums"]) {
            RadiosModel *model = [RadiosModel newRadioModelWithDic:dic];
            [self.radioModelArray addObject:model];
        }
        
        for (NSDictionary *dic in obj[@"data"][@"hot_albums"][@"data_list"]) {
            HotRadioModel *model = [HotRadioModel hotRadioModelWithDic:dic];
            [self.hotRadioModelArray addObject:model];
        }
        [self.collectionView reloadData];
    }];
    
}
- (void)getData1{
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/radio/morehot?platform=android&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=%ld&channel=m360&device_key=A000004E60D1EF", self.number ] success:^(id obj) {
        
        for (NSDictionary *dic in obj[@"data"][@"data_list"]) {
            HotRadioModel *model = [HotRadioModel hotRadioModelWithDic:dic];
            [self.hotRadioModelArray addObject:model];
        }
        [self.collectionView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return self.radioModelArray.count;
    } if (section == 2) {
        return self.hotRadioModelArray.count;
    } else {
       return 1;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     if (indexPath.section == 0) {
        RadioOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"scrollcell" forIndexPath:indexPath];
         cell.cycleScrollView.delegate = self;
         if (cell.scrollViewArray.count == 0) {
             cell.scrollViewArray  = [NSMutableArray arrayWithArray:self.scrollModelArray];
         }
         return cell;
     } else if (indexPath.section == 1 ){
         AlbumsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumsCell" forIndexPath:indexPath];
         RadiosModel *model = self.radioModelArray[indexPath.row];
         cell.model = model;
         return cell;
         
     } else {
         HotAlbumsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotAlbumsCell" forIndexPath:indexPath];
         HotRadioModel *model = self.hotRadioModelArray[indexPath.row];
         cell.model = model;
         return cell;
     }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 2 ) {
            AlbumsTwoView *two = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AlbumsTwoView" forIndexPath:indexPath];
            return two;
        } else{
            AlbumsOneView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AlbumsOneView" forIndexPath:indexPath];
            headerView.index = indexPath;
            headerView.delegate = self;
            if (indexPath.section == 0) {
                headerView.titleLabel.text = @"热门主播";
            } else {
                headerView.titleLabel.text = @"新晋主播";
            }
            return headerView;
        }
    } else {
        UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
        return foot;
    }
}

#pragma mark - AlbumsOneViewDelegate
//点击哪个分区的区头
- (void)clickButton:(NSIndexPath *)index {
    if (index.section == 0) {
        [self performSegueWithIdentifier:@"MarkVC" sender:nil];
    }
    if (index.section == 1) {
        [self performSegueWithIdentifier:@"MarkListVC" sender:nil];
    }
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        RadiosModel *model = self.radioModelArray[indexPath.row];
        [self performSegueWithIdentifier:@"toListVC" sender:model.ID];
    } else {
        HotRadioModel *model = self.hotRadioModelArray[indexPath.row];
        [self performSegueWithIdentifier:@"toListVC" sender:model.ID];
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(KScreenWidth, KScreenHeight / 5 );
    } else if (indexPath.section == 1){
        return CGSizeMake((KScreenWidth - 40)/ 3, KScreenHeight / 5);
    } else {
        return CGSizeMake(KScreenWidth, KScreenHeight / 5);
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 0, 10);
}
//设置区头大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(KScreenWidth, KScreenHeight/ 13);
}

//选择哪个滚动视图
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    TopScrollModel *model = self.scrollModelArray[index];
    [self performSegueWithIdentifier:@"toListVC" sender:model.ID];
    
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toListVC"]) {
       ListVC *listVC = segue.destinationViewController;
        listVC.ID = sender;
    } if ([segue.identifier isEqualToString:@"MarkVC"]) {
        //MarkVC *markVC = segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"MarkListVC"]) {
        MarkListVC *markListVC = segue.destinationViewController;
        markListVC.name = @"新晋主播";
    }
}


@end
