//
//  MarkListVC.m
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "MarkListVC.h"
#import "HotAlbumsCell.h"
#import "HotRadioModel.h"
#import "ListVC.h"

@interface MarkListVC ()<UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *hotRadioModelArray;
@property (nonatomic, assign) NSInteger number;
@end

@implementation MarkListVC
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hotRadioModelArray = [@[] mutableCopy];
    self.number = 1;
    // Do any additional setup after loading the view.
    [self.collectionView registerNib:[UINib nibWithNibName:@"HotAlbumsCell" bundle:nil] forCellWithReuseIdentifier:@"HotAlbumsCell"];
    
    self.titleLabel.text = self.name;
    [self get];
    //明杰上拉加载
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.number++;
        [self get];
        [self.collectionView.mj_footer endRefreshing];
    }];
}
- (void)get{//判断两种不同的接口
    if ([self.titleLabel.text isEqualToString:@"主播电台"]) {
        [self getData:[NSString stringWithFormat:@"http://api.duotin.com/tag/search?platform=android&source=danxinben&package=com.duotin.fm&user_key=&tag_id=%@&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=%ld&channel=m360&device_key=A000004E60D1EF", self.ID, self.number]];
    }
    if ([self.titleLabel.text isEqualToString:@"新晋主播"]) {
        [self getData:[NSString stringWithFormat:@"http://api.duotin.com/album/new?platform=android&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=%ld&channel=m360&device_key=A000004E60D1EF", self.number]];
    }
}

- (void)getData:(NSString *)str{
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:str success:^(id obj) {
        //
        for (NSDictionary *dic in obj[@"data"][@"data_list"]) {
            HotRadioModel *model = [HotRadioModel hotRadioModelWithDic:dic];
            [self.hotRadioModelArray addObject:model];
        }
        [self.collectionView reloadData];
    }];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hotRadioModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotAlbumsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotAlbumsCell" forIndexPath:indexPath];
    HotRadioModel *model = self.hotRadioModelArray[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(KScreenWidth, KScreenHeight / 5);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 0, 10);
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HotRadioModel *model = self.hotRadioModelArray[indexPath.row];
    [self performSegueWithIdentifier:@"toListVC" sender:model.ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toListVC"]) {
        ListVC *listVC = segue.destinationViewController;
        listVC.ID = sender;
    }
}


@end
