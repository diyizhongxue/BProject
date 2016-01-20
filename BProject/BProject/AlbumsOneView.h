//
//  AlbumsOneView.h
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
//代理往前传值
@protocol AlbumsOneViewDelegate <NSObject>
- (void)clickButton:(NSIndexPath *)index;
@end

@interface AlbumsOneView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong)  NSIndexPath *index;
@property (nonatomic, assign)id <AlbumsOneViewDelegate> delegate;
@end
