//
//  OtherHeaderView.h
//  BProject
//
//  Created by lanouhn on 15/12/26.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>


//指定代理
@protocol OtherHeaderViewDelegate <NSObject>

@optional
- (void)clickButton:(NSIndexPath *)index;//点击

@end

@interface OtherHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) NSIndexPath *index;
@property (nonatomic, assign) id <OtherHeaderViewDelegate> delegate;

- (IBAction)more:(id)sender;

@end
