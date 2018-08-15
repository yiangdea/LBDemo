//
//  LBPictureCell.h
//  LBDemo
//
//  Created by 杨达 on 2018/8/15.
//  Copyright © 2018年 杨达. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class LBPictureCell;

@protocol LBLoadingCellDelegate <NSObject>

- (void)didSelectCell:(LBPictureCell *)cell imgView:(UIImageView *)imgView;

@end

@interface LBPictureCell : UITableViewCell

+ (LBPictureCell *)loadCell:(UITableView *)tabView;

@property (nonatomic, strong) NSArray *arrUrls;

@property (nonatomic, weak) UITableView *tabView;
@property (nonatomic, assign) BOOL isNeedLoad;

@property (nonatomic, strong) NSArray<UIImageView *> *arrImg;
@property (nonatomic, strong) UIImageView *imageLeft;
@property (nonatomic, strong) UIImageView *imageRight;

@property (nonatomic, weak) id<LBLoadingCellDelegate>delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier;

@end
