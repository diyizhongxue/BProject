//
//  OurListenVC.m
//  BProject
//
//  Created by lanouhn on 16/1/5.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "OurListenVC.h"
#import "ourLietenCell.h"
#import "OurListenModel.h"
#import "MJRefresh.h"
@interface OurListenVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) NSMutableArray *ourListenModelArray;
@end

@implementation OurListenVC
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.number = 1;
    self.ourListenModelArray  = [@[] mutableCopy];
    [self.tableView registerNib:[UINib nibWithNibName:@"ourLietenCell" bundle:nil] forCellReuseIdentifier:@"ourLietenCell"];
    [self getData];
    //明杰下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.number = 1;
        [self.ourListenModelArray removeAllObjects];
        [self getData];
        [self.tableView.mj_header endRefreshing];
    }];
    
    //明杰上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        ++self.number;
        [self getData];
        [self.tableView.mj_footer endRefreshing];
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (void)getData{
    NetWork *net = [NetWork new];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/userListening?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=%ld&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&channel=m360&version=2.7.12", self.number] success:^(id obj) {
        for (NSDictionary *dic in obj[@"data"][@"data_list"]) {
            OurListenModel *model = [OurListenModel ourListenModelWithDic:dic];
            [self.ourListenModelArray addObject:model];
        }
        [self.tableView reloadData];
    }];
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ourListenModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ourLietenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ourLietenCell"];
    if (self.ourListenModelArray.count != 0) {
        OurListenModel *model = self.ourListenModelArray[indexPath.row];
        cell.titleLabel.text = model.title;
        [cell.bigImage sd_setImageWithURL:[NSURL URLWithString:model.bigImage] placeholderImage:[UIImage imageNamed:@"pic"]];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ 正在收听", model.realName];
        cell.desLabel.text = model.des;
        [cell.smallImage sd_setImageWithURL:[NSURL URLWithString:model.smallImage] placeholderImage:[UIImage imageNamed:@"jiazai"]];
    }
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KScreenHeight/5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
