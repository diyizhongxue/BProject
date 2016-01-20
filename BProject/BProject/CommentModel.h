//
//  CommentModel.h
//  BProject
//
//  Created by lanouhn on 16/1/5.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic, copy) NSString *ID, *title, *comment_num;
+(id)listenModelWithDic:(NSDictionary *)dic;
@end
