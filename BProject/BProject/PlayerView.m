//
//  PlayerView.m
//  BProject
//
//  Created by lanouhn on 16/1/6.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "PlayerView.h"
#import "Playing.h"
#import "PlayerListModel.h"
#import "PlayerModel.h"
@interface PlayerView ()
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *start;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, assign) NSInteger number;

@property (nonatomic, assign) float time;
@end
@implementation PlayerView

- (void)setModel:(PlayerModel *)model{
    if (_model != model) {
        _model = model;
    }
    
    self.playSingleton = [Playing sharePlaying];
    self.duration.layer.cornerRadius = 5;
    self.duration.layer.borderWidth = 2;
    self.duration.layer.borderColor = [UIColor whiteColor].CGColor;
    self.title.text = model.title;
    
    
    self.playerItem = [self getPlayerItem:model.audio_32_url];
    [self.playSingleton playerWithItem:_playerItem];
    
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_playSingleton.player];
    playerLayer.frame = CGRectZero;
    [self.layer addSublayer:playerLayer];
    [_playSingleton.player play];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //AVPlayer播放完成时通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playSingleton.player.currentItem];
        //计时器
        [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(Stack) userInfo:nil repeats:YES];
        [self createButton];
        [self createSlider];
    });
    
}

//懒加载
- (AVPlayerItem *)getPlayerItem:(NSString *)url{
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    return playerItem;
}
#pragma mark - Slider
- (void)createSlider{
    //设置slider的中间块的背景
    [_slider setThumbTintColor:[UIColor purpleColor]];
    //设置slider的未滑到的滑到的颜色
    //设置slider的已经划过的滑道的背景颜色
    [_slider setMinimumTrackTintColor:[UIColor redColor]];
    
    [_slider addTarget:self action:@selector(progressSlider:) forControlEvents:UIControlEventValueChanged];
}
#pragma mark - slider滑动事件
//让slider随着进度滑动
- (void)progressSlider:(UISlider *)slider{
    
    //拖动改变播放进度
    self.playSingleton = [Playing sharePlaying];
        //转换成CMTime才能给player来控制播放进度
        CMTime dragedCMTime = CMTimeMake(slider.value * CMTimeGetSeconds(self.playSingleton.player.currentItem.duration), 1);
        [_playSingleton.player pause];
        [_playSingleton.player seekToTime:dragedCMTime completionHandler:^(BOOL finished) {
            [_playSingleton.player play];
        }];
}
#pragma mark - 播放和下一首按钮

- (void)createButton {
    if (_playSingleton.player.rate == 1.0) {
        [_start setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    } else {
        [_start setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
    [_start addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (IBAction)last:(id)sender {//点击播放上一曲
    [_playSingleton.player pause];
    //代理方法
    if ([_delegate respondsToSelector:@selector(next)]) {
        [_delegate last];
    }
}
- (IBAction)next:(id)sender {//点击播放下一曲
    [_playSingleton.player pause];
    //代理方法
    if ([_delegate respondsToSelector:@selector(next)]) {
        [_delegate next];
    }
}
#pragma mark - 播放暂停按钮方法
- (void)startAction:(UIButton *)button {
    if (button.selected) {
        [_start setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        
        [_playSingleton.player play];
    } else {
        [_start setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        
        [_playSingleton.player pause];
    }
    button.selected = !button.selected;
}
#pragma mark - 计时器事件

//监测播放总时长 和 当前的播放进度
- (void)Stack {
    if (_playerItem.duration.timescale != 0) {
        _slider.maximumValue = 1;//音乐总时长
        _slider.value = CMTimeGetSeconds([_playerItem currentTime])/(_playerItem.duration.value / _playerItem.duration.timescale);
        //当前时长进度progress
        
        NSInteger proMin = (NSInteger)CMTimeGetSeconds([_playSingleton.player currentTime]) / 60;
        NSInteger proSec = (NSInteger)CMTimeGetSeconds([_playSingleton.player currentTime]) % 60;
        
        //duration 总时长
        NSInteger durMin = (NSInteger)_playerItem.duration.value/_playerItem.duration.timescale/60;  //总秒
        NSInteger durSec = (NSInteger)_playerItem.duration.value/_playerItem.duration.timescale%60;  //总分钟
        self.duration.text = [NSString stringWithFormat:@"%02ld:%02ld/%02ld:%02ld", proMin, proSec, durMin, durSec];
    }
}
//播放结束
- (void)moviePlayDidEnd:(id)sender {
    [self next:sender];
    [self createButton];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:_playSingleton.player.currentItem];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
