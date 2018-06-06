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
        _dataArray = [[NSMutableArray alloc]initWithObjects:@"支付宝和微信支付",@"多线程相关", nil ];
        
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatTableView];
    self.hlTableView.tableFooterView = [UIView new];
    self.hlTableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 120.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"a6efce1b9d16fdfa8bbfac72b88f8c5495ee7b5e"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.width.height.mas_equalTo(100);
        }];
        view;
    });
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
    NSArray * pushBVNameArray = [NSArray arrayWithObjects:HLPayVCName,HLMultithreadingVCName, nil];
    UIViewController * pushVC = [[HHRouter shared] matchController:[pushBVNameArray objectAtIndex:indexPath.row]];
    pushVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 147;
}




@end
