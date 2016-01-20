//
//  Playing.m
//  BProject
//
//  Created by lanouhn on 16/1/6.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "Playing.h"
#import <AVFoundation/AVFoundation.h>
@implementation Playing
+ (Playing *)sharePlaying {
    static Playing *play = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        play = [[Playing alloc] init];
        
    });
    return play;
}

- (void)playerWithItem:(AVPlayerItem *)item {
    if (self.player.rate) {
        [self.player pause];
        self.player = nil;
        self.player = [AVPlayer playerWithPlayerItem:item];
    } else {
        self.player = [AVPlayer playerWithPlayerItem:item];
    }
}
@end
