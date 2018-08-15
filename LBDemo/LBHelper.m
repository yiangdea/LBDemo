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

- (void)httpImgUrls:(void(^)(NSArray *arr))callBack {
    if (self.arrImgUrls.count > 0) {
        if (callBack) {
            callBack(self.arrImgUrls);
        }
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str = @"https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss";
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *html = [NSString stringWithContentsOfURL:[NSURL URLWithString:str] encoding:enc error:nil];
        NSLog(@"%@",html);
        NSArray *array = [html componentsSeparatedByString:@"\""];
        NSMutableArray *imgHttps = [NSMutableArray array];
        for (NSString *imgHttp in array) {
            if ([imgHttp hasSuffix:@"jpg"]) {
                [imgHttps addObject:imgHttp];
            }
        }
        self.arrImgUrls = array;
        if (callBack) {
            callBack(array);
        }
    });
}

@end
