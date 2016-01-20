//
//  PlayViewController.m
//  BProject
//
//  Created by lanouhn on 15/12/26.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "PlayViewController.h"
#import "SearchFrontArrModel.h"
#import "SearchAfterArrModel.h"
#import "SearchListVC.h"

@interface PlayViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (nonatomic, strong) NSMutableArray *searchFrondArr;

@property (nonatomic, assign)BOOL flag;//判断是搜索前的数据还是搜索后的数据

@end

@implementation PlayViewController

//点击取消返回
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

//点击搜做
- (IBAction)search:(id)sender {
    [self.textField resignFirstResponder];
    if (self.textField.text.length != 0) {
        //对汉字字符串进行转码, URL中不能出现中文, 如果出现, 则必须对其进行转码
        NSString *afterStr = [self.textField.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NetWork *net = [[NetWork alloc] init];
        [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/search/suggest?platform=android&source=danxinben&search_word=%@&package=com.duotin.fm&user_key=&version=2.7.12&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&channel=m360&device_key=A000004E60D1EF", afterStr] success:^(id obj) {
            
            self.flag = NO;
            [self.searchFrondArr removeAllObjects];
            //封装数据
            for (NSDictionary *dic in obj[@"data"]) {
                SearchAfterArrModel *searchAfter = [SearchAfterArrModel searchAfterArrModel:dic];
                [self.searchFrondArr addObject:searchAfter];
            }
            [self.tabelView reloadData];
        }];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchFrondArr = [@[] mutableCopy];
    [self getData];
    
    //注册cell
    [self.tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"frontCell"];
}
- (void)getData {
    
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:@"http://api.duotin.com/search?platform=android&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&channel=m360&device_key=A000004E60D1EF" success:^(id obj) {
        self.flag = YES;
        //数据封装
        SearchFrontArrModel *frontModel = [SearchFrontArrModel searchFrontArrModelWithDic:obj];
        
        for (NSString *str in frontModel.dataArray) {
            [self.searchFrondArr addObject:str];
        }
        [self.tabelView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchFrondArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"frontCell"];
    if (self.flag == YES) {
        cell.textLabel.text = self.searchFrondArr[indexPath.row];
    } else {
        SearchAfterArrModel *medol = self.searchFrondArr[indexPath.row];
        cell.textLabel.text = medol.title ;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.flag == YES) {
        NSString *str = self.searchFrondArr[indexPath.row];
        [self performSegueWithIdentifier:@"searchListVC" sender:str];
        
    } else {
        SearchAfterArrModel *model = self.searchFrondArr[indexPath.row];
        [self performSegueWithIdentifier:@"searchListVC" sender:model.title];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"searchListVC"]) {
        SearchListVC *searchListVc = segue.destinationViewController;
        searchListVc.myTitle = sender;
    }
}


@end
