
//
//  ListVC.m
//  BProject
//
//  Created by lanouhn on 15/12/28.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "ListVC.h"
#import "ScorllTableViewCell.h"
#import "NetWork.h"
#import "ListModel.h"
#import "ListOtherTableViewCell.h"
#import "ListOtherModel.h"
#import "PLayerVC.h"
@interface ListVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ListModel *listModel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray *listOtherModelArr;

@end

@implementation ListVC

- (IBAction)return:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listOtherModelArr = [@[] mutableCopy];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ScorllTableViewCell" bundle:nil] forCellReuseIdentifier:@"scroll"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ListOtherTableViewCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
    [self getData];//页面出现前,网络请求
    
}

- (void)getData {
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/album?platform=android&album_id=%@&source=danxinben&package=com.duotin.fm&user_key=&sort_type=0&version=2.7.12&page_size=100&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF", self.ID] success:^(id obj) {
        //封装数据
        self.listModel = [ListModel listWithDic:obj[@"data"][@"album"]];
        self.titleLabel.text = self.listModel.title;
        
        for (NSDictionary *dic in obj[@"data"][@"content_list"][@"data_list"]) {
            ListOtherModel *model = [ListOtherModel listOtherModelWithDic:dic];
            [self.listOtherModelArr addObject:model];
        }
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOtherModelArr.count + 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ScorllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scroll"];
        cell.listModel = self.listModel;
        return cell;
    } else {
        ListOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
         ListOtherModel *model = self.listOtherModelArr[indexPath.row - 1];
        cell.model = model;
        return cell;
    }
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return KScreenHeight / 3;
    } else {
        return KScreenHeight / 6;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     ListOtherModel *model = self.listOtherModelArr[indexPath.row - 1];
    [self performSegueWithIdentifier:@"playerVC" sender:model.ID];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"playerVC"]) {
        PlayerVC *playerVC = segue.destinationViewController;
        playerVC.ID = sender;
    }
}
@end
