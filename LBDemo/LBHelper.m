//
//  LBHelper.m
//  LBDemo
//
//  Created by 杨达 on 2018/8/15.
//  Copyright © 2018年 杨达. All rights reserved.
//

#import "LBHelper.h"

@implementation LBHelper

+ (instancetype)shareManage {
    static LBHelper *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[self alloc] init];
    });
    return shareManager;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)httpImgUrls:(void(^)(NSArray *arr, NSError *error))callBack {
    if (self.arrImgUrls.count > 0) {
        if (callBack) {
            callBack(self.arrImgUrls, nil);
        }
        return;
    }
//    if (callBack) {
//        callBack(@[
//                   @[@"http://www.nasa.gov/sites/default/files/thumbnails/image/28680508458_2745f5fa6e_k.jpg",
//                   @"http://www.nasa.gov/sites/default/files/thumbnails/image/42535970511_bc542c6efc_o.jpg"],
//                   @[@"http://www.nasa.gov/sites/default/files/thumbnails/image/pia22422.jpg"]
//                   ], nil);
//        return;
//    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str = @"https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss";
        NSError *error = nil;
        NSString *html = [NSString stringWithContentsOfURL:[NSURL URLWithString:str] encoding:NSUTF8StringEncoding error:&error];
        NSLog(@"%@",error);
        NSArray *array = [html componentsSeparatedByString:@"\""];
        NSMutableArray *imgHttps = [NSMutableArray array];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSString *imgHttp in array) {
            if ([imgHttp hasSuffix:@"jpg"]) {
                [arr addObject:imgHttp];
                if (arr.count == 2) {
                    [imgHttps addObject:arr];
                    arr = [NSMutableArray array];
                }
            }
        }
        if (arr.count > 0) {
            [imgHttps addObject:arr];
        }
        self.arrImgUrls = imgHttps;
        if (callBack) {
            callBack(imgHttps, nil);
        }
    });
}

@end
