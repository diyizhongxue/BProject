//
//  LeftVC.m
//  BProject
//
//  Created by lanouhn on 15/12/25.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "LeftVC.h"
#import "leftTableViewCell.h"
#import <MessageUI/MessageUI.h>
#import "UMSocial.h"
@interface LeftVC ()<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (nonatomic, strong) UIAlertView *alert;
@end

@implementation LeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.backgroundImage.image = [UIImage imageNamed:@"sett"];
    self.topImage.image = [UIImage imageNamed:@"tooimage"];
    self.tableView.rowHeight = 80;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"leftTableViewCell" bundle:nil] forCellReuseIdentifier:@"setCell"];
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    leftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setCell" forIndexPath:indexPath];
    NSArray *array = @[@"浏览精彩内容",@"清理内存", @"意见反馈", @"软件和须知", @"分享给好友"];
    cell.textLabel.text = array[indexPath.row];
    return cell;
    
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = @[@"right", @"SoftwareViewController", @"AothorViewController"];
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (indexPath.row == 0) {
        
        //通过storyboard, 找到  Vc
        UIViewController *controller = [board instantiateViewControllerWithIdentifier:arr[indexPath.row]];
        //重新设置 抽屉的viewController
        [self.mm_drawerController setCenterViewController:controller withCloseAnimation:YES completion:^(BOOL finished) {
        }];
    } else if (indexPath.row == 1) {
        [self clearMemory];
    } else if (indexPath.row == 2){
        [self suggest];
    } else if(indexPath.row == 3) {
        //通过storyboard, 找到  Vc
        UIViewController *controller = [board instantiateViewControllerWithIdentifier:arr[indexPath.row - 2]];
        //重新设置 抽屉的viewController
        [self.mm_drawerController setCenterViewController:controller withCloseAnimation:YES completion:^(BOOL finished) {
        }];
    } else {
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"569dd91367e58e0fd7001863"
                                          shareText:@"听榆, 听心, 听世界。软件'听榆'让耳朵来旅行, 快到appStore下载吧"
                                         shareImage:[UIImage imageNamed:@"icon"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,nil]
                                           delegate:nil];
    }
}
//缓存清理
- (void)clearMemory{
    //清理缓存
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *str = [NSString stringWithFormat:@"监测到缓存量:%.1fM", [self folderSizeAtPath:path]];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"缓存清理" message:str preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"清理" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        NSArray *fiels = [[NSFileManager defaultManager] subpathsAtPath:path];
        for (NSString *f in fiels) {
            NSError *error = nil;
            NSString *string = [path stringByAppendingPathComponent:f];
            if ([[NSFileManager defaultManager] fileExistsAtPath:string]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alert addAction:alertAction];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
}

//缓存清理的方法
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//发送邮件提建议
- (void)suggest{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        [mail setSubject:@"我的意见"];
        [mail setToRecipients:@[@"516182396@qq.com"]];
        
        [mail setMessageBody:@"哈哈" isHTML:NO];
        mail.mailComposeDelegate = self;
        [self presentViewController:mail animated:YES completion:nil];
    } else {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"监测到您的设备不支持发邮件功能" preferredStyle:(UIAlertControllerStyleActionSheet)];
        [self presentViewController:alertView animated:YES completion:nil];
    }
}


- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MFMailComposeResultCancelled:
            
            break;
        case MFMailComposeResultSaved:
//            NSLog(@"用户成功保存邮件");
            break;
        case MFMailComposeResultSent:
//            NSLog(@"用户成功发送邮件");
            break;
        case MFMailComposeResultFailed:
//            NSLog(@"用户试图保存或者发送邮件失败");
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
