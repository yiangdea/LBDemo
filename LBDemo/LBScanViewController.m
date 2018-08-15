//
//  LBScanViewController.m
//  LBDemo
//
//  Created by 杨达 on 2018/8/15.
//  Copyright © 2018年 杨达. All rights reserved.
//

#import "LBScanViewController.h"

#import "LBHelper.h"

#import "LBPictureCell.h"

@interface LBScanViewController ()<UITableViewDelegate, UITableViewDataSource, LBLoadingCellDelegate>

@property (nonatomic, strong) UITableView *picTabView;

@property (nonatomic, strong) NSArray *arrUrls;

@end

@implementation LBScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.picTabView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    [[LBHelper shareManage] httpImgUrls:^(NSArray *arr) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.arrUrls = arr;
        [strongSelf.picTabView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - another
- (void)didSelectCell:(LBPictureCell *)cell imgView:(UIImageView *)imgView {
    
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
        _picTabView.backgroundColor = [UIColor blueColor];
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
