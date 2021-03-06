//
//  HLTwoMultithreadingViewController.m
//  HLLittleDream
//
//  Created by asd on 2018/6/6.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "HLTwoMultithreadingViewController.h"

@interface HLTwoMultithreadingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * multithreadTableView;
@property (nonatomic,strong)NSArray * dataArray;
@end

@implementation HLTwoMultithreadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"多线程";
    self.multithreadTableView = ({
        _multithreadTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _multithreadTableView.delegate = self;
        _multithreadTableView.dataSource = self;
        [self.view addSubview:_multithreadTableView];
        [_multithreadTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    });
    self.dataArray = [NSArray arrayWithObjects:@"Thread",@"GCD",@"NSOperation", nil];
}

#pragma makr - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * arr = [NSArray arrayWithObjects:HLThreadVCName,HLGCDVCName,HLNSOperationVCName, nil];
    UIViewController * pushVC = [[HHRouter shared] matchController:[arr objectAtIndex:indexPath.row]];
    pushVC.title = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:pushVC animated:YES];
}
















@end
