//
//  LBScanViewController.m
//  LBDemo
//
//  Created by 杨达 on 2018/8/15.
//  Copyright © 2018年 杨达. All rights reserved.
//

#import "LBScanViewController.h"

#import "LBHelper.h"
#import "CommonLibHeader.h"

#import "LBPictureCell.h"
#import "LBPrePicView.h"

@interface LBScanViewController ()<UITableViewDelegate, UITableViewDataSource, LBLoadingCellDelegate>

@property (nonatomic, strong) UITableView *picTabView;

@property (nonatomic, strong) NSArray *arrUrls;

@end

@implementation LBScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.picTabView];
    [self.picTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).mas_offset(0);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(0);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).mas_offset(0);
            make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).mas_offset(0);
        }
        make.left.right.mas_equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    [[LBHelper shareManage] httpImgUrls:^(NSArray *arr) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_sync(dispatch_get_main_queue(), ^{
            strongSelf.arrUrls = arr;
            [strongSelf.picTabView reloadData];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - another
- (void)didSelectCell:(LBPictureCell *)cell imgView:(UIImageView *)imgView {
    LBPrePicView *review = [[LBPrePicView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) Photo:imgView.image];
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    transition.duration = 0.5;
    [review.layer addAnimation:transition forKey:nil];
    [self.navigationController.view addSubview:review];
}

#pragma mark - tabViewDelegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LBPictureCell *cell = [LBPictureCell loadCell:tableView];
    cell.delegate = self;
    cell.arrUrls = self.arrUrls[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrUrls.count;
}

#pragma mark - set|get
- (UITableView *)picTabView {
    if (!_picTabView) {
        _picTabView = [[UITableView alloc] init];
        _picTabView.backgroundColor = [UIColor whiteColor];
        _picTabView.delegate = self;
        _picTabView.dataSource = self;
        _picTabView.rowHeight = UITableViewAutomaticDimension;
    }
    return _picTabView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
