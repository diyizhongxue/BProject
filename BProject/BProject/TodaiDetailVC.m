//
//  TodaiDetailVC.m
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "TodaiDetailVC.h"
#import "NetWork.h"
#import "TodayDetailModel.h"
#import "TodayDetailCell.h"
#import "TodayThemeModel.h"
#import "MJRefresh.h"
#import "MarkListVC.h"
@interface TodaiDetailVC ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *todayDetailModelArray;
@property (nonatomic, assign) NSInteger number;
@end

@implementation TodaiDetailVC
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.todayDetailModelArray = [@[] mutableCopy];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.model.title;
    [self.tableView registerNib:[UINib nibWithNibName:@"TodayDetailCell" bundle:nil] forCellReuseIdentifier:@"TodayDetailCell"];
    [self getData];
    self.number = 1;
    //明杰上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        ++self.number;
        [self getData];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)getData{
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/topic/albums?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=%ld&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&topic_id=%@&channel=m360&version=2.7.12",self.number, self.model.ID] success:^(id obj) {
        for (NSDictionary *dic in obj[@"data"][@"data_list"]) {
            TodayDetailModel *model = [TodayDetailModel todayDetailModelWithDic:dic];
            [self.todayDetailModelArray addObject:model];
        }
        [self.tableView reloadData];
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todayDetailModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TodayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodayDetailCell"];
    TodayDetailModel *model = self.todayDetailModelArray[indexPath.row];
    [cell.photoView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    cell.titleLabel.text = model.title;
    cell.play_numLabel.text = [NSString stringWithFormat:@"节目数量: %@", model.content_num];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KScreenWidth / 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TodayDetailModel *detailmodel = self.todayDetailModelArray[indexPath.row];
    [self performSegueWithIdentifier:@"toListVC" sender:detailmodel.ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MarkListVC *listVC = segue.destinationViewController;
    listVC.ID = sender;
}


@end
