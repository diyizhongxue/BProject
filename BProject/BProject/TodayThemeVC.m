//
//  TodayThemeVC.m
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "TodayThemeVC.h"
#import "OneCell.h"
#import "NetWork.h"
#import "TodayThemeModel.h"
#import "TodaiDetailVC.h"

@interface TodayThemeVC ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *todayThemeModelArray;
@end

@implementation TodayThemeVC
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.todayThemeModelArray = [@[] mutableCopy];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"OneCell" bundle:nil] forCellReuseIdentifier:@"OneCell"];
    [self getData];
    
    
}

- (void)getData{
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:@"http://api.duotin.com/topic/list?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=1&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&channel=m360&version=2.7.12" success:^(id obj) {
        for (NSDictionary *dic in obj[@"data"][@"data_list"]) {
            TodayThemeModel *model = [TodayThemeModel todayThemeModelWithDic:dic];
            [self.todayThemeModelArray addObject:model];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todayThemeModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneCell"];
    TodayThemeModel *model = self.todayThemeModelArray[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (KScreenHeight - 50)/2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TodayThemeModel *model = self.todayThemeModelArray[indexPath.row];
    [self performSegueWithIdentifier:@"toTodayDetailVC" sender:model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TodaiDetailVC *vc = segue.destinationViewController;
    vc.model = sender;
}


@end
