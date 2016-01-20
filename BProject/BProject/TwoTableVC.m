//
//  TwoTableVC.m
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "TwoTableVC.h"
#import "RightCell.h"
#import "ListenModel.h"
#import "ListVC.h"
#import "PlayerVC.h"

@interface TwoTableVC ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (nonatomic, strong) NSMutableArray *listenModelArray;
@end

@implementation TwoTableVC
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FirstTableVC" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.listenModelArray = [@[] mutableCopy];
    // Do any additional setup after loading the view.
    [self.tabelView registerNib:[UINib nibWithNibName:@"RightCell" bundle:nil] forCellReuseIdentifier:@"RightCell"];
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveNoti:) name:@"FirstTableVC" object:nil];
    
}
//接受到通知后发出的方法
-(void)recieveNoti:(NSNotification *)noti {
        [self.listenModelArray removeAllObjects];
        NetWork *net = [NetWork new];
        [net getNetwork:noti.userInfo[@"arrays"] success:^(id obj) {
            for (NSDictionary *dic in obj[@"data"][@"data_list"]) {
                ListenModel *model = [ListenModel listenModelWithDic:dic];
                [self.listenModelArray addObject:model];
            }
            [self.tabelView reloadData];
        }];
    
 }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listenModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightCell"];
    cell.leftLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    cell.photoView.image = [UIImage imageNamed:@"music"];
    ListenModel *model = self.listenModelArray[indexPath.row];
    cell.desLabel.text = model.title;
    cell.numLabel.text = [NSString stringWithFormat:@"%.lf万", [model.play_num floatValue]/10000];
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
    if (self.listenModelArray.count != 0) {
        ListenModel *model = self.listenModelArray[indexPath.row];
        [self performSegueWithIdentifier:@"toPlayerVC" sender:model.ID];

    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PlayerVC *playerVC = segue.destinationViewController;
    playerVC.ID = sender;
}


@end
