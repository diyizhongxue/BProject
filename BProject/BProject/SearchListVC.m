//
//  SearchListVC.m
//  BProject
//
//  Created by lanouhn on 15/12/27.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "SearchListVC.h"
#import "SearchListTableViewCell.h"
#import "SearchSpecialModel.h"
#import "SearchProgrameModel.h"
#import "SearchAfterArrModel.h"
#import "ListVC.h"
#import "PlayerVC.h"
@interface SearchListVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *searchFrondArr;
@property (strong, nonatomic) NSMutableArray *specialModelArr;
@property (nonatomic, strong) NSMutableArray *programModelArr;
@property (nonatomic, assign) BOOL flag;

@end

@implementation SearchListVC
//搜索
- (IBAction)search:(id)sender {
    [self.textField resignFirstResponder];
    
    if (self.textField.text.length != 0) {
        //对汉字字符串进行转码, URL中不能出现中文, 如果出现, 则必须对其进行转码
       NSString *afterStr = [self.textField.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NetWork *net = [[NetWork alloc] init];
        
        [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/search/suggest?platform=android&source=danxinben&search_word=%@&package=com.duotin.fm&user_key=&version=2.7.12&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&channel=m360&device_key=A000004E60D1EF", afterStr] success:^(id obj) {
            self.flag = NO;
            //加载之前移除之前的数据
            [self.searchFrondArr removeAllObjects];
            [self.specialModelArr removeAllObjects];
            [self.programModelArr removeAllObjects];
            
            //封装数据
            for (NSDictionary *dic in obj[@"data"]) {
                SearchAfterArrModel *searchAfter = [SearchAfterArrModel searchAfterArrModel:dic];
                [self.searchFrondArr addObject:searchAfter];
            }
            [self.tableView reloadData];
        }];
    }
}
//返回
- (IBAction)return:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchFrondArr = [@[] mutableCopy];
    self.specialModelArr = [@[] mutableCopy];
    self.programModelArr = [@[] mutableCopy];
    
    //注册自定义的cell
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchListTableViewCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
    //注册搜做结果的cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"forCell"];
    self.flag = YES;
    [self getData];//网络请求
}

- (void)getData {
    //对汉字字符串进行转码, URL中不能出现中文, 如果出现, 则必须对其进行转码
     NSString *afterStr = [self.myTitle stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/search/all?platform=android&source=danxinben&search_word=%@&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF", afterStr] success:^(id obj) {
        self.flag = YES;
        //加载之前移除之前的数据
        [self.specialModelArr removeAllObjects];
        [self.programModelArr removeAllObjects];
        
        //封装数据 专辑 和 节目
        for (NSDictionary *dic in obj[@"data"][@"album_list"][@"data_list"]) {
            SearchSpecialModel *specialModel = [SearchSpecialModel searchSpecialModelWithDic:dic];
            [self.specialModelArr addObject:specialModel];
        }
        for (NSDictionary *dic in obj[@"data"][@"content_list"][@"data_list"]) {
            SearchProgrameModel *programModel = [SearchProgrameModel searchPragrameModelWithDid:dic];
            [self.programModelArr addObject:programModel];
        }
        
        [self.tableView reloadData];
    }];
}


- (void)getNetData:(NSString *)str {
    //对汉字字符串进行转码, URL中不能出现中文, 如果出现, 则必须对其进行转码
    NSString *afterStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NetWork *net = [[NetWork alloc] init];
    [net getNetwork:[NSString stringWithFormat:@"http://api.duotin.com/search/all?platform=android&source=danxinben&search_word=%@&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF", afterStr] success:^(id obj) {
        self.flag = YES;
        //加载之前移除之前的数据
        [self.specialModelArr removeAllObjects];
        [self.programModelArr removeAllObjects];
        
        //封装数据 专辑 和 节目
        for (NSDictionary *dic in obj[@"data"][@"album_list"][@"data_list"]) {
            SearchSpecialModel *specialModel = [SearchSpecialModel searchSpecialModelWithDic:dic];
            [self.specialModelArr addObject:specialModel];
        }
        for (NSDictionary *dic in obj[@"data"][@"content_list"][@"data_list"]) {
            SearchProgrameModel *programModel = [SearchProgrameModel searchPragrameModelWithDid:dic];
            [self.programModelArr addObject:programModel];
        }
        [self.tableView reloadData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_flag == YES) {
        return 2;
    } else {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_flag == YES) {
        
        if (section == 0) {
            return self.specialModelArr.count;
        } else {
            return self.programModelArr.count;
        }
        
    } else {
        return self.searchFrondArr.count;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
     if (_flag == YES) {
        
          SearchListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
        if (indexPath.section == 0) {
            SearchSpecialModel *model = self.specialModelArr[indexPath.row];
            cell.model = model;
            return cell;
        } else {
            SearchProgrameModel *model = self.programModelArr[indexPath.row];
            cell.model2 = model;
            return cell;
        }
        
    } else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forCell"];
        
        SearchAfterArrModel *medol = self.searchFrondArr[indexPath.row];
        cell.textLabel.text = medol.title ;
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_flag == YES) {
        NSArray *arr = @[@"专辑", @"节目"];
        return [arr objectAtIndex:section];
    } else {
        return nil;
    }
    
}

#pragma  mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_flag == NO) {
        SearchAfterArrModel *medol = self.searchFrondArr[indexPath.row];
        [self getNetData:medol.title];
    } else{
        if (indexPath.section == 0) {
            SearchSpecialModel *model = self.specialModelArr[indexPath.row];
            
            [self performSegueWithIdentifier:@"listVC" sender:model.ID];
        } else {
            SearchProgrameModel *model = self.programModelArr[indexPath.row];
            [self performSegueWithIdentifier:@"toPlayerVC" sender:model.ID];
        }
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"listVC"]) {
        ListVC *list = segue.destinationViewController;
        list.ID = sender;
    } if ([segue.identifier isEqualToString:@"toPlayerVC"]) {
        PlayerVC *playerVC = segue.destinationViewController;
        playerVC.ID = sender;
    }
}
@end
