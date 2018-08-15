//
//  LBPictureCell.m
//  LBDemo
//
//  Created by 杨达 on 2018/8/15.
//  Copyright © 2018年 杨达. All rights reserved.
//

#import "LBPictureCell.h"
#import "CommonLibHeader.h"

@implementation LBPictureCell

+ (LBPictureCell *)loadCell:(UITableView *)tabView {
    LBPictureCell *cell = [tabView dequeueReusableCellWithIdentifier:@"LBPictureCell"];
    if (!cell) {
        cell = [[LBPictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LBPictureCell"];
        cell.tabView = tabView;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageLeft = [[UIImageView alloc] init];
        self.imageLeft.userInteractionEnabled = YES;
        [self.contentView addSubview:self.imageLeft];
        
        self.imageRight = [[UIImageView alloc] init];
        self.imageRight.userInteractionEnabled = YES;
        [self.contentView addSubview:self.imageRight];
        
        self.arrImg = @[_imageLeft, _imageRight];
        
        [self.imageLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).mas_offset(8);
            make.top.mas_greaterThanOrEqualTo(self.contentView).mas_offset(8);
            make.bottom.mas_lessThanOrEqualTo(self.contentView).mas_offset(-8);
            make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-8);
        }];
        
        [self.imageRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).mas_offset(8);
            make.top.mas_greaterThanOrEqualTo(self.contentView).mas_offset(8);
            make.bottom.mas_lessThanOrEqualTo(self.contentView).mas_offset(-8);
            make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(8);
        }];
        
        UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLetfImage:)];
        [self.imageLeft addGestureRecognizer:tapLeft];
        
        UITapGestureRecognizer *tapRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightImage:)];
        [self.imageRight addGestureRecognizer:tapRight];
    }
    return self;
}

- (void)clickLetfImage:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectCell:imgView:)]) {
        [self.delegate didSelectCell:self imgView:self.imageLeft];
    }
}

- (void)clickRightImage:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectCell:imgView:)]) {
        [self.delegate didSelectCell:self imgView:self.imageRight];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - set|get
- (void)setArrUrls:(NSArray *)arrUrls {
    self.isNeedLoad = ![_arrUrls isEqual:arrUrls];
    _arrUrls = arrUrls;
    if (self.isNeedLoad) {
        [self loadRequestImg];
    }
}

#pragma mark - other
- (void)loadRequestImg {
    for (UIImageView *imgView in self.arrImg) {
        NSInteger index = [self.arrImg indexOfObject:imgView];
        if (_arrUrls.count > index) {
            imgView.hidden = NO;
        } else {
            imgView.hidden = YES;
            break;
        }
        NSString *strUrl = [_arrUrls[index] isKindOfClass:[NSString class]] ? _arrUrls[index] : @"";
        __weak typeof(self) weakSelf = self;
        [imgView sd_setImageWithURL:[NSURL URLWithString:strUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.arrImg[index] setImage:image];
            [strongSelf imageSizeChange:image imageView:strongSelf.arrImg[index]];
        }];
    }
}

- (void)imageSizeChange:(UIImage *)image
              imageView:(UIImageView *)imageView {
    CGSize imgSize = image.size;
    CGFloat maxWidth = self.contentView.bounds.size.width/2.0 - 16.0;
    CGFloat width = imgSize.width;
    CGFloat heigh = imgSize.height;
    if (width > maxWidth) {
        heigh = maxWidth/width * heigh;
        width = maxWidth;
    }
    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(heigh);
        make.width.mas_equalTo(width);
    }];
    NSIndexPath *indexpach = [self.tabView indexPathForCell:self];
    if (indexpach && self.isNeedLoad) {
        [self.tabView reloadRowsAtIndexPaths:@[indexpach] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

@end
