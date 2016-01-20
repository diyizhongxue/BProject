//
//  NetWork.h
//  BProject
//
//  Created by lanouhn on 15/12/25.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NetWork : NSObject

- (void)getNetwork:(NSString *)urlString success:(void(^)(id obj))block;


@end
