//
//  LBLoadingDeal.m
//  LBDemo
//
//  Created by 杨达 on 2018/8/15.
//  Copyright © 2018年 杨达. All rights reserved.
//

#import "LBLoadingDeal.h"

#import "CommonLibHeader.h"

@implementation LBLoadingDeal : NSObject

+ (void)loadingBackDeal {
    UIViewController *lasVC = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIView *launchView = lasVC.view;
    launchView.backgroundColor = [UIColor blueColor];
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:launchView];
    
    UILabel *labTitle = [UILabel new];
    labTitle.numberOfLines = 0;
    labTitle.font = [UIFont systemFontOfSize:17];
    labTitle.text = @"一阵风一阵雨一阵晴天,半是文半是武半是野蛮";
    [launchView addSubview:labTitle];
    
    NSString *svgPath = [[NSBundle mainBundle] pathForResource:@"SVGLoding" ofType:nil];
    NSData *svgData = [NSData dataWithContentsOfFile:svgPath];
    NSString *reasourcePath = [[NSBundle mainBundle] resourcePath];
    NSURL *baseUrl = [[NSURL alloc] initFileURLWithPath:reasourcePath isDirectory:true];
    UIWebView *imageLoading = [[UIWebView alloc] init];
    [launchView addSubview:imageLoading];
    imageLoading.frame = CGRectMake(0, 0, 200, 200);
    [imageLoading loadData:svgData MIMEType:@"image/svg+xml" textEncodingName:@"UTF-8" baseURL:baseUrl];
    
    [imageLoading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.mas_equalTo(lasVC.view.mas_centerX);
        make.centerY.mas_equalTo(lasVC.view.mas_centerY).mas_offset(20);
    }];
    
    [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lasVC.view).mas_offset(16);
        make.right.mas_equalTo(lasVC.view).mas_offset(-16);
        make.bottom.mas_equalTo(imageLoading.mas_top).mas_offset(-16);
    }];
    
    [UIView animateWithDuration:0.2f delay:2.8f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5f, 1.5f, 1.0f);
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
}

@end
