//
//  LBHelper.h
//  LBDemo
//
//  Created by 杨达 on 2018/8/15.
//  Copyright © 2018年 杨达. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBHelper : NSObject

@property (atomic, strong) NSArray *arrImgUrls;

+ (instancetype)shareManage;

- (void)httpImgUrls:(void(^)(NSArray *arr, NSError *error))callBack;

@end
