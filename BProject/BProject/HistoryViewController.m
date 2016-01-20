//
//  HistoryViewController.m
//  BProject
//
//  Created by lanouhn on 16/1/13.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryModel.h"

#import "HistoryTableViewCell.h"
#import "PlayerModel.h"
#import "AppDelegate.h"
#import "PlayerVC.h"
@interface HistoryViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) PlayerModel *playerModel;
@end

@implementation HistoryViewController
- (IBAction)menuButton:(id)sender {
    [self.mm_drawerController toggleDrawerSide:(MMDrawerSideLeft) animated:YES completion:nil];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"HistoryTableViewCell"];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //移除之前的数据
    [self.dataArray removeAllObjects];
    //从数据库中取出数据
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    //创建检索条件
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HistoryModel"];
    NSArray *historyArray = [app.managedObjectContext executeFetchRequest:request error:nil];
    [self.dataArray addObjectsFromArray:historyArray];
    [self.tableView reloadData];
    
}
//编辑状态
- (IBAction)editor:(id)sender {
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
    } else {
        self.tableView.editing = YES;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryTableViewCell"];
    HistoryModel *model = self.dataArray[indexPath.row];
    [cell.photoView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"jiazai@3x"]];
    cell.titleLabel.text = model.name;
    cell.desLabel.text = model.des;
    
    return cell;
}

//删除数据
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        HistoryModel *history = self.dataArray[indexPath.row];
        [app.managedObjectContext deleteObject:history];
        [self.dataArray removeObject:history];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [app saveContext];
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryModel *model = self.dataArray[indexPath.row];
    [self performSegueWithIdentifier:@"toPlayerVC" sender:model.myID];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toPlayerVC"]) {
        PlayerVC *playerVC = segue.destinationViewController;
        playerVC.ID = sender;
    }
}


@end
