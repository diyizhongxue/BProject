//
//  HotRecommendVC.m
//  BProject
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "HotRecommendVC.h"
#import "TwoCollectionViewCell.h"
#import "HotRecommendMoreModel.h"
#import "SecondModel.h"
#import "PlayViewController.h"
#import "PlayerVC.h"

@interface HotRecommendVC ()<UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray *hotRecommendMoreArr;



- (IBAction)dismiss:(id)sender;


@end

@implementation HotRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hotRecommendMoreArr = [@[] mutableCopy];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"TwoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collection2"];
    _layout.minimumInteritemSpacing = 0;
    
    [self getData];
}

- (void)getData{
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/recommend/more?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=1&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&type=&recommend_category_id=%@&channel=m360&version=2.7.12", self.ID] success:^(id obj) {
        //
        for (NSDictionary *dic in obj[@"data"][@"data_list"]) {
            HotRecommendMoreModel *model = [HotRecommendMoreModel hotRecommendMoreModelWithDic:dic];
            [self.hotRecommendMoreArr addObject:model];
        }
        [self.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hotRecommendMoreArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection2" forIndexPath:indexPath];
    SecondModel *model = self.hotRecommendMoreArr[indexPath.row];
    cell.model = model;
    return cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((KScreenWidth - 40)/3, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 10, 10);
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HotRecommendMoreModel *model = self.hotRecommendMoreArr[indexPath.row];
    [self performSegueWithIdentifier:@"toPlayerVC" sender:model.item_value];
//    NSLog(@"%@", model.item_value);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //PlayViewController *playViewController = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"toPlayerVC"]) {
        PlayerVC *playerVC = segue.destinationViewController;
        playerVC.ID = sender;
    }
}

- (IBAction)toSearch:(id)sender {
    [self performSegueWithIdentifier:@"ToPlayVC" sender:nil];
}


- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
    
}
@end
