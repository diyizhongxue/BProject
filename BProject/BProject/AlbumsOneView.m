//
//  AlbumsOneView.m
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "AlbumsOneView.h"

@implementation AlbumsOneView

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)click:(id)sender {
    if ([_delegate respondsToSelector:@selector(clickButton:)]) {
        [_delegate clickButton:self.index];
    }
}

@end
