//
//  CommentModel.m
//  BProject
//
//  Created by lanouhn on 16/1/5.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
+(id)listenModelWithDic:(NSDictionary *)dic{
    CommentModel *model = [CommentModel new];
    model.ID = dic[@"id"];
    model.title = dic[@"title"];
    model.comment_num = dic[@"comment_num"];
    return model;
}
@end
