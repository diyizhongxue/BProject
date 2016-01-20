//
//  OtherHeaderView.m
//  BProject
//
//  Created by lanouhn on 15/12/26.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "OtherHeaderView.h"

@implementation OtherHeaderView

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)more:(id)sender {
    if ([_delegate respondsToSelector:@selector(clickButton:)]) {
        [_delegate clickButton:_index];
    }
}
@end
