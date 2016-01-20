//
//  TodayHotVC.m
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "TodayHotVC.h"
#import "LeftCell.h"
#import "RightCell.h"
#import "NetWork.h"
#import "SubModel.h"

@interface TodayHotVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UIImageView *arrowsView;
@property (weak, nonatomic) IBOutlet UIScrollView *bScrollView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *centrolButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIView *choiceView;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, assign) BOOL flag;
@property (nonatomic, copy) NSString *name;//记录标题的内容

@end

@implementation TodayHotVC
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)moreChance:(id)sender {
    [UIView transitionWithView:self.arrowsView duration:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.arrowsView.transform = CGAffineTransformRotate(self.arrowsView.transform, M_PI);
    } completion:^(BOOL finished) {
        [self.titleButton setTitle:self.name forState:(UIControlStateNormal)];
//        NSLog(@"%@", self.titleButton.titleLabel.text);
    }];
    if (self.flag == NO) {
        [UIView transitionWithView:self.choiceView duration:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
            self.choiceView.hidden= NO;
        } completion:^(BOOL finished) {
            _flag = !_flag;
        }];
    } else {
        [UIView transitionWithView:self.choiceView duration:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.choiceView.hidden= YES;
        } completion:^(BOOL finished) {
            _flag = !_flag;
        }];
    }
}
- (IBAction)todayHot:(id)sender {
    [self.titleButton setTitle:@"今日热榜" forState:(UIControlStateNormal)];
    self.name = @"今日热榜";
    self.number = 0;
    self.bScrollView.contentOffset = CGPointMake(0, 0);
    self.leftButton.backgroundColor = [UIColor orangeColor];
    self.centrolButton.backgroundColor = [UIColor whiteColor];
    self.rightButton.backgroundColor = [UIColor whiteColor];
    NSString *str = @"http://api.duotin.com/rank/subscribe?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=1&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&period_type=day&channel=m360&version=2.7.12";
    [self sendNotification:str];
}
- (IBAction)weakHot:(id)sender {
    [self.titleButton setTitle:@"本周热榜" forState:(UIControlStateNormal)];
    self.name = @"本周热榜";
    self.number = 1;
    self.bScrollView.contentOffset = CGPointMake(0, 0);
    self.leftButton.backgroundColor = [UIColor orangeColor];
    self.centrolButton.backgroundColor = [UIColor whiteColor];
    self.rightButton.backgroundColor = [UIColor whiteColor];
    NSString *str = @"http://api.duotin.com/rank/subscribe?platform=android&period_type=week&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
    [self sendNotification:str];
}

- (IBAction)monthHot:(id)sender {
    [self.titleButton setTitle:@"本月热榜" forState:(UIControlStateNormal)];
    self.name = @"本月热榜";
    self.number = 2;
    self.bScrollView.contentOffset = CGPointMake(0, 0);
    self.leftButton.backgroundColor = [UIColor orangeColor];
    self.centrolButton.backgroundColor = [UIColor whiteColor];
    self.rightButton.backgroundColor = [UIColor whiteColor];
    NSString *str = @"http://api.duotin.com/rank/subscribe?platform=android&period_type=month&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
    [self sendNotification:str];
}



- (IBAction)leftButton:(id)sender {//订阅榜
    self.bScrollView.contentOffset = CGPointMake(0, 0);
    self.leftButton.backgroundColor = [UIColor orangeColor];
    self.centrolButton.backgroundColor = [UIColor whiteColor];
    self.rightButton.backgroundColor = [UIColor whiteColor];
    if (self.number == 0) {
        NSString *str = @"http://api.duotin.com/rank/subscribe?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=1&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&period_type=day&channel=m360&version=2.7.12";
        [self sendNotification:str];
    } else if (self.number == 1){
        NSString *str = @"http://api.duotin.com/rank/subscribe?platform=android&period_type=week&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
        [self sendNotification:str];
    } else {
        NSString *str = @"http://api.duotin.com/rank/subscribe?platform=android&period_type=month&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
        [self sendNotification:str];
    }
    
}
- (IBAction)centrlButton:(id)sender {//收听榜
    self.bScrollView.contentOffset = CGPointMake(KScreenWidth, 0);
    self.leftButton.backgroundColor = [UIColor whiteColor];
    self.centrolButton.backgroundColor = [UIColor orangeColor];
    self.rightButton.backgroundColor = [UIColor whiteColor];
    if (self.number == 0) {
        NSString *str = @"http://api.duotin.com/rank/listen?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=1&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&period_type=day&channel=m360&version=2.7.12";
        [self sendNotification:str];
    } else if (self.number == 1){
        NSString *str = @"http://api.duotin.com/rank/listen?platform=android&period_type=week&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
        [self sendNotification:str];
    } else {
        NSString *str = @"http://api.duotin.com/rank/listen?platform=android&period_type=month&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
        [self sendNotification:str];
    }
}
- (IBAction)rightButton:(id)sender {//评论榜
    self.bScrollView.contentOffset = CGPointMake(2*KScreenWidth, 0);
    self.leftButton.backgroundColor = [UIColor whiteColor];
    self.centrolButton.backgroundColor = [UIColor whiteColor];
    self.rightButton.backgroundColor = [UIColor orangeColor];
    if (self.number == 0) {
        NSString *str = @"http://api.duotin.com/rank/comment?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=1&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&period_type=day&channel=m360&version=2.7.12";
        [self sendNotification:str];
    } else if (self.number == 1){
        NSString *str = @"http://api.duotin.com/rank/comment?platform=android&period_type=week&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
        [self sendNotification:str];
    } else {
        NSString *str = @"http://api.duotin.com/rank/comment?platform=android&period_type=month&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
        [self sendNotification:str];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bScrollView.delegate = self;
    self.flag = NO;
    self.choiceView.hidden = YES;
    self.number = 0;
    [self.titleButton setTitle:@"今日热榜" forState:(UIControlStateNormal)];
    self.name = @"今日热榜";
    self.leftButton.backgroundColor = [UIColor orangeColor];
    self.centrolButton.backgroundColor = [UIColor whiteColor];
    self.rightButton.backgroundColor = [UIColor whiteColor];
    NSString *str = @"http://api.duotin.com/rank/subscribe?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=1&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&period_type=day&channel=m360&version=2.7.12";
    [self sendNotification:str];
    
}
- (void)sendNotification:(NSString *)str{
    //发送通知()
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FirstTableVC" object:nil userInfo:@{@"arrays":str}];
}
#pragma mark - UIScrollViewDelegate
//结束减速的时候开始请求数据
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.bScrollView.contentOffset.x == 0) {
        self.leftButton.backgroundColor = [UIColor orangeColor];
        self.centrolButton.backgroundColor = [UIColor whiteColor];
        self.rightButton.backgroundColor = [UIColor whiteColor];
        if (self.number == 0) {
            NSString *str = @"http://api.duotin.com/rank/subscribe?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=1&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&period_type=day&channel=m360&version=2.7.12";
            [self sendNotification:str];
        } else if (self.number == 1){
            NSString *str = @"http://api.duotin.com/rank/subscribe?platform=android&period_type=week&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
            [self sendNotification:str];
        } else {
            NSString *str = @"http://api.duotin.com/rank/subscribe?platform=android&period_type=month&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
            [self sendNotification:str];
        }
    } else if (self.bScrollView.contentOffset.x == KScreenWidth){
        self.leftButton.backgroundColor = [UIColor whiteColor];
        self.centrolButton.backgroundColor = [UIColor orangeColor];
        self.rightButton.backgroundColor = [UIColor whiteColor];
        if (self.number == 0) {
            NSString *str = @"http://api.duotin.com/rank/listen?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=1&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&period_type=day&channel=m360&version=2.7.12";
            [self sendNotification:str];
        } else if (self.number == 1){
            NSString *str = @"http://api.duotin.com/rank/listen?platform=android&period_type=week&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
            [self sendNotification:str];
        } else {
            NSString *str = @"http://api.duotin.com/rank/listen?platform=android&period_type=month&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
            [self sendNotification:str];
        }
    } else {
        self.leftButton.backgroundColor = [UIColor whiteColor];
        self.centrolButton.backgroundColor = [UIColor whiteColor];
        self.rightButton.backgroundColor = [UIColor orangeColor];
        if (self.number == 0) {
            NSString *str = @"http://api.duotin.com/rank/comment?page_size=20&device_key=356633056895293&platform=android&source=danxinben&page=1&device_token=AmdqwD9_s0wN8UHZg7tX5rqCNyx0YImru0FiN38zp3Qi&user_key=&package=com.duotin.fm&period_type=day&channel=m360&version=2.7.12";
            [self sendNotification:str];
        } else if (self.number == 1){
            NSString *str = @"http://api.duotin.com/rank/comment?platform=android&period_type=week&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
            [self sendNotification:str];
        } else {
            NSString *str = @"http://api.duotin.com/rank/comment?platform=android&period_type=month&source=danxinben&package=com.duotin.fm&user_key=&version=2.7.12&page_size=20&device_token=AhPgC5lTpyl_fdKNrvyXSoH1wAmYsTKTLajqcqRMLeJe&page=1&channel=m360&device_key=A000004E60D1EF";
            [self sendNotification:str];
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FirstTableVC" object:nil];
}
@end
