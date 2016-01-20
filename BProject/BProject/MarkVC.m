//
//  MarkVC.m
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "MarkVC.h"
#import "OneMoodCollectionViewCell.h"
#import "MarkModel.h"
#import "MarkListVC.h"

@interface MarkVC ()<UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *topModelArray;
@end

@implementation MarkVC
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topModelArray = [@[] mutableCopy];
    
    // Do any additional setup after loading the view.
    [self.collectionView registerNib:[UINib nibWithNibName:@"OneMoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"OneMoodCollectionViewCell"];
    [self getData];
    
}

- (void)getData{
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:@"http://api.duotin.com/tag/list?platform=android&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&channel=m360&device_key=A000004E60D1EF" success:^(id obj) {
        for (NSDictionary *dic in obj[@"data"]) {
            MarkModel *model = [MarkModel markModelWithDic:dic];
            [self.topModelArray addObject:model];
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
    return self.topModelArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OneMoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OneMoodCollectionViewCell" forIndexPath:indexPath];
    MarkModel *model = self.topModelArray[indexPath.row];
    cell.label.text = model.title;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((KScreenWidth - 50) / 4, KScreenHeight / 16);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 0, 10);
}
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MarkModel *model = self.topModelArray[indexPath.row];
    [self performSegueWithIdentifier:@"MarkListVC" sender:model.ID];
    
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MarkListVC"]) {
        MarkListVC *markListVC = segue.destinationViewController;
        markListVC.ID = sender;
        markListVC.name = @"主播电台";
    }
}
@end
