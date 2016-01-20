//
//  MoodVC.m
//  BProject
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "MoodVC.h"
#import "OneMoodCollectionViewCell.h"
#import "TwoCollectionViewCell.h"
#import "TopModel.h"
#import "BottomModel.h"
#import "ButtonSmallModel.h"
#import "TwoMoodCollectionViewCell.h"
#import "ListVC.h"



@interface MoodVC ()<UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray *topModelArray;
@property (nonatomic, strong) BottomModel *bottomModel;
@property (nonatomic, strong) NSMutableArray *smallModelArray;
@property (nonatomic, assign) NSInteger number;//上拉加载的页数
@property (nonatomic, copy) NSString *ID; //存储第一分区的item的id
@property (nonatomic, assign) NSInteger index;

@end

@implementation MoodVC
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}
- (IBAction)changeSegment:(id)sender {
//    NSLog(@"%ld", self.segmented.selectedSegmentIndex);
    [self.smallModelArray removeAllObjects];
    [self getData1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topModelArray = [@[] mutableCopy];
    self.smallModelArray = [@[] mutableCopy];
    self.number = 1;
    self.ID = @"-1";
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"OneMoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"OneMoodCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TwoMoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TwoMoodCell"];
    self.layout.minimumInteritemSpacing = 0;
    [self getData]; //上部分数据请求
    [self getData1];//下部分数据请求
    //明杰上拉加载
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        ++self.number;
        [self getData1];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
}
  //上部分分请求
- (void)getData{
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/category/subcategories?platform=android&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&category_id=%@&channel=m360&device_key=A000004E60D1EF", self.redirect_value] success:^(id obj) {
        for (NSDictionary *dic in obj[@"data"]) {
            TopModel *model = [TopModel topModelWithDic:dic];
            [self.topModelArray addObject:model];
        }
        [self.collectionView reloadData];
    }];
    
}
//下部的请求部分
- (void)getData1{
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/category/content?platform=android&source=danxinben&package=com.duotin.fm&user_key=&sort_type=%ld&version=2.7.12&sub_category_id=%@&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&category_id=%@&page=%ld&channel=m360&device_key=A000004E60D1EF", 2 - self.segmented.selectedSegmentIndex, self.ID, self.redirect_value, self.number] success:^(id obj) {
        
        self.bottomModel = [BottomModel bottomModelWithDic:obj[@"data"]];
         self.titleLabel.text = self.bottomModel.bigTitle;
        
        
        for (NSDictionary *dic in obj[@"data"][@"data_list"]) {
            ButtonSmallModel *smallModel = [ButtonSmallModel buttonSmallModelWithDic:dic];
            [self.smallModelArray addObject:smallModel];
        }
        [self.collectionView reloadData];
    }];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.topModelArray.count;
    } else {
        return self.smallModelArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        OneMoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OneMoodCell" forIndexPath:indexPath];
        TopModel *model = self.topModelArray[indexPath.row];
        cell.label.text = model.title;
        
        //点击选中的item 改变颜色
        if (self.index == indexPath.row) {
            cell.contentView.backgroundColor = [UIColor brownColor];
        } else {
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        return cell;
    } else {
        TwoMoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TwoMoodCell" forIndexPath:indexPath];
        ButtonSmallModel *model = self.smallModelArray[indexPath.row];
        cell.model = model;
        return  cell;
    }
}
#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        //点击选中的item 改变颜色
        if (indexPath.row != self.index) {
            self.index = indexPath.row;
        }
        TopModel *model = self.topModelArray[indexPath.row];
        self.ID = model.ID;
        [self.smallModelArray removeAllObjects];//加载新数据之前, 移除之前的数据
        [self getData1];
        
        
        
    } else {
        ButtonSmallModel *model = self.smallModelArray[indexPath.row];
        ;
        //把string 转化成 number
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSNumber *ID = [numberFormatter numberFromString:model.ID];
        [self performSegueWithIdentifier:@"toListVC" sender:ID];
    }
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake((KScreenWidth - 50) / 4, 25);
    } else {
        return CGSizeMake((KScreenWidth - 30)/2, (KScreenWidth - 30)/2);
    }
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toListVC"]) {
        ListVC *listVC = segue.destinationViewController;
        listVC.ID = sender;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
