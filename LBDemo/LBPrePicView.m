//
//  LBPrePicView.m
//  LBDemo
//
//  Created by 杨达 on 2018/8/15.
//  Copyright © 2018年 杨达. All rights reserved.
//

#import "LBPrePicView.h"

@implementation LBPrePicView

- (instancetype)initWithFrame:(CGRect)frame Photo:(UIImage *)photo {
    if (self = [super initWithFrame:frame]) {
        CGFloat scale = photo.size.width / self.frame.size.width;
        CGFloat height = photo.size.height / scale;
        
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - height)/2, self.frame.size.width, height)];
        imageView.image = photo;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        
        UITapGestureRecognizer *oneTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDisappear)];
        oneTapGesture.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:oneTapGesture];
    }
    return self;
}

- (void)tapDisappear {
    [self removeFromSuperview];
}

@end
