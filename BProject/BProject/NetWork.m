//
//  NetWork.m
//  BProject
//
//  Created by lanouhn on 15/12/25.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "NetWork.h"
#import <AFNetworking.h>
@implementation NetWork

- (void)getNetwork:(NSString *)urlString success:(void(^)(id obj))block{
    
    //发起网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //异步get请求, 自动解析json数据
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ////自动解析数据, 返回的数据是responseObject
        id obj = responseObject;
        block(obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
    }];
}


@end
