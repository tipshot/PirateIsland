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
@property (nonatomic,strong)UIView * tableHeader;
@property (nonatomic,strong)UILabel * headerTitle;
@property (nonatomic,strong)UILabel * headerSubtitle;
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
    NSLog(@"%@",HLPayVCName);
    if (indexPath.row == 0) {
        UIViewController * pushVC = [[HHRouter shared] matchController:HLPayVCName];
        pushVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pushVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 147;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self tableHeader];
}

// 高度147
- (UIView *)tableHeader {
    if (_tableHeader) return _tableHeader;
    _tableHeader = [[UIView alloc] init];
    _tableHeader.backgroundColor = [UIColor whiteColor];
    _headerTitle = [UILabel new];
    _headerTitle.font = [UIFont boldSystemFontOfSize:18.0f];
    _headerTitle.numberOfLines = 2;
    //    _headerTitle.frame = CGRectMake(15, 22, KScreenWidth-30, 25);
    _headerTitle.backgroundColor = [UIColor redColor];
    _headerTitle.text = @"_headerTitle";
    [_tableHeader addSubview:_headerTitle];
    [_headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(2);
        make.height.mas_equalTo(20);
    }];
    
    _headerSubtitle = [UILabel new];
    _headerSubtitle.numberOfLines = 2;
    _headerSubtitle.backgroundColor = [UIColor grayColor];
    _headerSubtitle.text = @"_headerSubtitle";
    //    _headerSubtitle.frame = CGRectMake(15, _headerTitle.bottom+8, kScreenWidth-30, 18);
    [_tableHeader addSubview:_headerSubtitle];
    [_headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-2);
    }];
    
    return _tableHeader;
}


@end
