//
//  WelcomePageView.h
//  Yike
//
//  Created by lanouhn on 15/12/7.
//  Copyright (c) 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomePageView : UIView
@property (nonatomic, retain)UIButton *guideBtn;

- (id)initWithFrame:(CGRect)frame
         namesArray:(NSArray *)items;

@end
