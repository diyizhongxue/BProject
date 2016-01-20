//
//  Playing.h
//  BProject
//
//  Created by lanouhn on 16/1/6.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVPlayer;
@class AVPlayerItem;
@interface Playing : NSObject

@property (nonatomic, strong)AVPlayer *player;

+ (Playing *)sharePlaying;

- (void)playerWithItem:(AVPlayerItem *)item;

@end
