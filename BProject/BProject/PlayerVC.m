//
//  PlayerVC.m
//  BProject
//
//  Created by lanouhn on 16/1/5.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "PlayerVC.h"
#import "PlayerModel.h"
#import "PlayerListModel.h"
#import "PlayerView.h"
#import "TitleCell.h"
#import "UserCell.h"
#import "HistoryModel.h"
#import "AppDelegate.h"

@interface PlayerVC ()<UITableViewDataSource, UITableViewDelegate, PlayerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *playerListModelArray;
@property (nonatomic, strong) PlayerView *playerView;
@property (nonatomic, strong) PlayerModel *playerModel;
@property (nonatomic, assign) NSInteger number;
@end

@implementation PlayerVC
- (IBAction)returnButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.playerListModelArray = [@[] mutableCopy];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleCell" bundle:nil] forCellReuseIdentifier:@"TitleCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserCell" bundle:nil] forCellReuseIdentifier:@"UserCell"];
    
    [self getData:self.ID];
    [self getData1:self.ID];
    
}

- (void)getData:(NSString *)str {
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/content?device_key=356633056895293&platform=android&content_id=%@&source=danxinben&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&channel=m360&version=2.7.12", str] success:^(id obj) {
        self.playerModel = [PlayerModel playerModelWithDic:obj[@"data"]];
        self.titleLabel.text = _playerModel.topTitle;
        [self.backImage sd_setImageWithURL:[NSURL URLWithString:self.playerModel.bigImage_url]];
        
        
//---------------------- 往数据库存数据---------------------------
        //获取appDelegate
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        //创建实体描述对象
        NSEntityDescription *description = [NSEntityDescription entityForName:@"HistoryModel" inManagedObjectContext:app.managedObjectContext];
        //创建被管理的对象
        //把被管理的对象插入下文内
        HistoryModel *historyModel = [[HistoryModel alloc] initWithEntity:description insertIntoManagedObjectContext:app.managedObjectContext];
        //插入数据
        historyModel.image_url = self.playerModel.bigImage_url;
        historyModel.name = self.playerModel.topTitle;
        historyModel.des = self.playerModel.title;
        historyModel.myID = self.playerModel.ID;
        
        //保存修改数据
        [app saveContext];
//--------------------- 往数据库存数据---------------------------
        
        [self.tableView reloadData];
    }];
}
- (void)getData1:(NSString *)str {
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/album/page?album_id=0&page_size=100&device_key=356633056895293&platform=android&content_id=%@&source=danxinben&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=b1fae41ea3097dabbd0354233c53e5dc&sort_type=0&package=com.duotin.fm&channel=m360&version=2.7.12", str] success:^(id obj) {
        for (NSDictionary *dic in obj[@"data"][@"data_list"]) {
            PlayerListModel *model = [PlayerListModel playerListModelwithDic:dic];
            [self.playerListModelArray addObject:model];
        }
        
        [self.tableView reloadData];
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3 + self.playerModel.playerArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 2) {
        TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleCell"];
        if (indexPath.row == 0) {
            cell.label.text = @"主播有话说";
        } else {
            cell.label.text = @"最新评论";
        }
        return cell;
    } else {
        
        UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
        if (indexPath.row == 1) {
            [cell.photoView sd_setImageWithURL:[NSURL URLWithString:self.playerModel.smallImage]];
            cell.nameLabel.text = self.playerModel.real_name;
            cell.desLabel.text = self.playerModel.describe;
            cell.timeLabel.text = [NSString stringWithFormat:@"发表于%@", [self changeDate:self.playerModel.described]];
        } else {
            cell.desLabel.text = self.playerModel.playerArr[indexPath.row - 3][@"comment"][@"content"];
            cell.nameLabel.text = self.playerModel.playerArr[indexPath.row - 3][@"user"][@"real_name"];
            cell.timeLabel.text = [NSString stringWithFormat:@"发表于%@", [self changeDate:self.playerModel.playerArr[indexPath.row - 3][@"comment"][@"created"]]];
            [cell.photoView sd_setImageWithURL:[NSURL URLWithString:self.playerModel.playerArr[indexPath.row - 3][@"user"][@"image_url"]]];
        }
        return cell;
    }
}

//把字符串转时间戳
- (NSString *)changeDate:(NSString *)str{
    NSString *str1 = [str substringToIndex:10];
    return str1;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  KScreenHeight/2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    self.playerView = [[[NSBundle mainBundle] loadNibNamed:@"PlayerView" owner:nil options:nil] firstObject];
    [self.playerView.imageView sd_setImageWithURL:[NSURL URLWithString:self.playerModel.bigImage_url] placeholderImage:[UIImage imageNamed:@"jiazai"]];
    _playerView.model = self.playerModel;
    
    
    _playerView.delegate = self;//遵守协议
     return self.playerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return KScreenHeight / 6;
    } else if (indexPath.row == 0 || indexPath.row == 2) {
        return KScreenHeight/12;
    } else {
        return KScreenHeight/6;
    }
    
}
#pragma mark - PlayerViewDelegate 
//播放上一曲
-(void)last {
    if (self.playerListModelArray.count > 1) {
        --_number;
        if (_number == -1) {
            _number = self.playerListModelArray.count;
            _number--;
        }
        PlayerListModel *model = self.playerListModelArray[_number];
        [self getData:model.ID];
        [self getData1:model.ID];
    } else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经是第一曲" preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleCancel) handler:nil];
        [alert addAction:cancle];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
//播放下一曲
- (void)next {
    if (self.playerListModelArray.count > 1) {
    ++_number;
    if (_number == self.playerListModelArray.count) {
        _number = 0;
        _number++;
    }
    PlayerListModel *model = self.playerListModelArray[_number];
    [self getData:model.ID];
    [self getData1:model.ID];
    } else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经是最后一曲" preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleCancel) handler:nil];
        [alert addAction:cancle];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
