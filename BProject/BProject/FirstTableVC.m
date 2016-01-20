//
//  FirstTableVC.m
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "FirstTableVC.h"
#import "LeftCell.h"
#import "SubModel.h"
#import "ListVC.h"

@interface FirstTableVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *subArray;
@property (nonatomic, assign) NSInteger numberOne;
@end

@implementation FirstTableVC
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FirstTableVC" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subArray = [@[] mutableCopy];
    self.numberOne = 1;
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"LeftCell" bundle:nil] forCellReuseIdentifier:@"LeftCell"];
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNoti:) name:@"FirstTableVC" object:nil];
    
}
//接受到通知后发出的方法
-(void)recieveNoti:(NSNotification *)noti {
    [self.subArray removeAllObjects];
        NetWork *net = [NetWork new];
        [net getNetwork:noti.userInfo[@"arrays"] success:^(id obj) {
            for (NSDictionary *dic in obj[@"data"][@"data_list"]) {
                SubModel *model = [SubModel subModelWithDic:dic];
                [self.subArray addObject:model];
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
    return self.subArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftCell"];
    cell.leftLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    SubModel *model = self.subArray[indexPath.row];
    [cell.photoView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"pic"]];
    cell.desLabel.text = model.title;
    cell.smallLabel.text = [NSString stringWithFormat:@"订阅数: %.1lf万", [model.subscribe_num  floatValue]/10000];
    if (indexPath.row == 0) {
        cell.leftLabel.backgroundColor = [UIColor redColor];
    } else if (indexPath.row ==1){
        cell.leftLabel.backgroundColor = [UIColor orangeColor];
    } else if (indexPath.row ==2){
        cell.leftLabel.backgroundColor = [UIColor blueColor];
    } else {
        cell.leftLabel.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KScreenHeight/12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SubModel *model = self.subArray[indexPath.row];
    [self performSegueWithIdentifier:@"toListVC" sender:model.ID];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ListVC *listVC = segue.destinationViewController;
    listVC.ID = sender;
}


@end
