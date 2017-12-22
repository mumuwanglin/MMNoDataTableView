//
//  ViewController.m
//  MMNoDataTableView
//
//  Created by 王林 on 2017/12/21.
//  Copyright © 2017年 王林. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
}

- (void)loadData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}

#pragma mark - TableView 占位图

- (UIImage *)mm_noDataViewImage {
    return [UIImage imageNamed:@"note_list_no_data"];
}

- (NSString *)mm_noDataViewMessage {
    return @"都用起来吧, 起飞~";
}

- (UIColor *)mm_noDataViewMessageColor {
    return [UIColor blackColor];
}

@end

