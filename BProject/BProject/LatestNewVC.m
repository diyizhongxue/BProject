//
//  LatestNewVC.m
//  BProject
//
//  Created by lanouhn on 16/1/5.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "LatestNewVC.h"
#import "LatestNewModel.h"
#import "TwoCollectionViewCell.h"
#import "MJRefresh.h"
#import "ListVC.h"
@interface LatestNewVC ()
@property (nonatomic, strong) NSMutableArray *latestNewModelArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger number;
@end

@implementation LatestNewVC
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.latestNewModelArray = [@[] mutableCopy];
    self.number = 1;
    // Do any additional setup after loading the view.
    [self.collectionView registerNib:[UINib nibWithNibName:@"TwoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TwoCollectionViewCell"];
    [self getData];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        ++self.number;
        [self getData];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
}
- (void)getData{
    NetWork *net = [NetWork new];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/album/latest?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=%ld&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&channel=m360&version=2.7.12", self.number] success:^(id obj) {
        for (NSDictionary *dic in obj[@"data"][@"data_list"]) {
            LatestNewModel *model = [LatestNewModel latestNewModelWithDic:dic];
            [self.latestNewModelArray addObject:model];
        }
        [self.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.latestNewModelArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TwoCollectionViewCell" forIndexPath:indexPath];
    LatestNewModel *model = self.latestNewModelArray[indexPath.row];
    
    cell.titleLabel.text = model.title;
    cell.smallLabel.text = [NSString stringWithFormat:@"上次更新: %@", model.created];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"pic"]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LatestNewModel *model = self.latestNewModelArray[indexPath.row];
    [self performSegueWithIdentifier:@"toListVC" sender:model.ID];
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KScreenWidth - 30)/2, KScreenHeight/3.5);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 0, 10);
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ListVC *listVC = segue.destinationViewController;
    listVC.ID = sender;
}


@end
