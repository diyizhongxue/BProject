//
//  SpecialMoreVC.m
//  BProject
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "SpecialMoreVC.h"
#import "OneCollectionViewCell.h"
#import "SprcialMoreModel.h"
#import "SecondModel.h"
#import "ListVC.h"
#import "PlayViewController.h"


@interface SpecialMoreVC ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *sprcialMoreModelArr;
@end

@implementation SpecialMoreVC

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sprcialMoreModelArr = [@[] mutableCopy];
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"OneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collection2"];
    [self getData];
    
}

- (void)getData{
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/recommend/more?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=1&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&type=&recommend_category_id=%@&channel=m360&version=2.7.12", self.ID] success:^(id obj) {
        for (NSDictionary *dic in obj[@"data"][@"data_list"]) {
            SprcialMoreModel *model = [SprcialMoreModel  sprcialMoreModelwithDic:dic];
            [self.sprcialMoreModelArr addObject:model];
        }
        [self.collectionView reloadData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sprcialMoreModelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection2" forIndexPath:indexPath];
    SecondModel *model = self.sprcialMoreModelArr[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%ld", indexPath.row);
   SprcialMoreModel *model = self.sprcialMoreModelArr[indexPath.row];
    [self performSegueWithIdentifier:@"ToListVC" sender:model.item_value];
//    NSLog(@"%@", model.item_value);
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((KScreenWidth - 40), 250);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 10, 10);
}

- (IBAction)search:(id)sender {
    [self performSegueWithIdentifier:@"toPlayViewController" sender:nil];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ToListVC"]) {
        ListVC *listVC = segue.destinationViewController;
        listVC.ID = sender;
    } else {
        //PlayViewController *playViewController = segue.destinationViewController;
    }
    
}
@end
