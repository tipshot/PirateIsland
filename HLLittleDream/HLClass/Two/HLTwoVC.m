//
//  HLTwoVC.m
//  HLLittleDream
//
//  Created by asd on 2018/4/2.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "HLTwoVC.h"

@interface HLTwoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)HLBaseTableView * hlTableView;
@property (nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation HLTwoVC

- (NSMutableArray *)dataArray
{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]initWithObjects:@"支付宝和微信支付",@"XX",@"xxx",@"XXX",@"XX", nil ];
        
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatTableView];
    self.hlTableView.tableFooterView = [UIView new];
}

- (void)creatTableView
{
    self.hlTableView = [[HLBaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_hlTableView];
    _hlTableView.delegate = self;
    _hlTableView.dataSource = self;
    [_hlTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
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
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIViewController * pushVC = [[HHRouter shared] matchController:HLPayVCName];
        pushVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pushVC animated:YES];
    }
}




@end
