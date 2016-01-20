//
//  PlayerView.h
//  BProject
//
//  Created by lanouhn on 16/1/6.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class Playing;
@class PlayerModel;
//代理
@protocol PlayerViewDelegate <NSObject>
@optional
- (void)next;
-(void)last;
@end

@interface PlayerView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) Playing *playSingleton;
@property (nonatomic, strong) PlayerModel *model;
@property (nonatomic, assign) id <PlayerViewDelegate> delegate;


@end
