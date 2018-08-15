//
//  LBLoadingDeal.m
//  LBDemo
//
//  Created by 杨达 on 2018/8/15.
//  Copyright © 2018年 杨达. All rights reserved.
//

#import "LBLoadingDeal.h"

#import "CommonLibHeader.h"
#import "LBScanViewController.h"
#import "LBHelper.h"

@implementation LBLoadingDeal : NSObject

+ (void)loadingBackDeal {
    [[LBHelper shareManage] httpImgUrls:nil];
    
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *lasVC = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen123"];
    UIView *launchView = lasVC.view;
    mainWindow.rootViewController = lasVC;
    
    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:launchView];
    
    UILabel *labTitle = nil;
    for (UIView *view in launchView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *lab = (UILabel *)view;
            if (lab.tag == 10001) {
                labTitle = lab;
            }
        }
    }
    
    NSString *svgPath = [[NSBundle mainBundle] pathForResource:@"svg_loding" ofType:nil];
    NSData *svgData = [NSData dataWithContentsOfFile:svgPath];
    NSString *reasourcePath = [[NSBundle mainBundle] resourcePath];
    NSURL *baseUrl = [[NSURL alloc] initFileURLWithPath:reasourcePath isDirectory:true];
    UIWebView *imageLoading = [[UIWebView alloc] init];
    imageLoading.backgroundColor = [UIColor blueColor];
    imageLoading.frame = CGRectMake(0, 0, 200, 200);
    [launchView addSubview:imageLoading];
    
    [imageLoading loadData:svgData MIMEType:@"image/svg+xml" textEncodingName:@"UTF-8" baseURL:baseUrl];
    
    [imageLoading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.mas_equalTo(lasVC.view.mas_centerX);
        make.top.mas_equalTo(labTitle.mas_bottom).mas_offset(20);
    }];
    
    [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lasVC.view).mas_offset(16);
        make.right.mas_equalTo(lasVC.view).mas_offset(-16);
        make.bottom.mas_equalTo(imageLoading.mas_top).mas_offset(-16);
    }];
    
    [UIView animateWithDuration:0.2f delay:2.8f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5f,1.5f, 1.0f);
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
        LBScanViewController *lbScanVC = [[LBScanViewController alloc] init];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:lbScanVC];
        navi.navigationBarHidden = YES;
        [UIApplication sharedApplication].keyWindow.rootViewController = navi;
    }];
}

@end
