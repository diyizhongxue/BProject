//
//  MarkListVC.h
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkListVC : UIViewController
@property (nonatomic, copy) NSString *ID;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) NSString *name;
@end
