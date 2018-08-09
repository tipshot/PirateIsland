//
//  HLOneVC.m
//  HLLittleDream
//
//  Created by asd on 2018/4/2.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "HLOneVC.h"

@interface HLOneVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)HLBaseTableView * hlTableView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation HLOneVC

- (NSMutableArray *)dataArray
{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]initWithObjects:@"用高德仿百度",@"微信",@"墨迹天气",@"网易新闻",@"天猫", nil ];
        
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatTableView];
    self.hlTableView.tableFooterView = [UIView new];
    [self creatGifHraderRefresh];
    [self creatGifFooterRefresh];
}

//Gif 动画刷新
- (void)creatGifFooterRefresh{
//    MJRefreshAutoGifFooter *header = [MJRefreshAutoGifFooter headerWithRefreshingTarget:self refreshingAction:@selector(request)];
    
    MJRefreshBackGifFooter *header = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(request)];
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", (long)i]];
        [refreshingImages addObject:image];
    }
    
    NSMutableArray *stoneImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=1; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [stoneImages addObject:image];
    }
    
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [idleImages addObject:image];
    }
    
    [header setTitle:@"上拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开即可开始刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    
    // Set font
//    header.stateLabel.font = [UIFont systemFontOfSize:15];
//    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // Set textColor
    header.stateLabel.textColor = KRandomColor;
    // 隐藏刷新状态
//    header.stateLabel.hidden = YES;
    // 设置普通状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:stoneImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:idleImages forState:MJRefreshStateRefreshing];
    // 设置header
    self.hlTableView.mj_footer = header;
}
- (void)creatGifHraderRefresh
{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(request)];
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [refreshingImages addObject:image];
    }
    
    NSMutableArray *stoneImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=1; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [stoneImages addObject:image];
    }
    
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [idleImages addObject:image];
    }
    
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // Set font
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // Set textColor
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    // 隐藏更新时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏刷新状态
    header.stateLabel.hidden = YES;
    // 设置普通状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:stoneImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:idleImages forState:MJRefreshStateRefreshing];
    // 设置header
    self.hlTableView.mj_header = header;
}



- (void)request
{
    NSLog(@"sdfghjkjhgf");
    MJWeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.hlTableView.mj_header endRefreshing];
        [weakSelf.hlTableView.mj_footer endRefreshing];
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
    if (indexPath.row == 0) {
        UIViewController *viewController = [[HHRouter shared] matchController:GaoDeToBaiDuMapName];
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}
@end
