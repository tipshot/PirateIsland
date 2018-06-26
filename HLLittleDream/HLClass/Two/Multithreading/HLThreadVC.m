//
//  HLThreadVC.m
//  HLLittleDream
//
//  Created by asd on 2018/6/6.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "HLThreadVC.h"

@interface HLThreadVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * threadTableView;
@property (nonatomic,strong)UIImageView * headerImageView;
@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,strong)NSThread * thread;
@property (nonatomic,strong)NSMutableArray * threadArray;//存放线程的数组
@end

@implementation HLThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.threadTableView = ({
        _threadTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _threadTableView.delegate = self;
        _threadTableView.dataSource = self;
        [self.view addSubview:_threadTableView];
        [_threadTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
       _threadTableView.tableHeaderView = [self creatHeaderView];
    });

    
    
    self.dataArray = [NSArray arrayWithObjects:@"NSThread动态实例化(http)",@"NSThread静态实例化(https)",@"NSThread隐式实例化(http)",@"强制退出当前线程",@"用数组存储多个线程", nil];
    [self show];
}



-(void)show
{

}

- (UIView *)creatHeaderView
{
    self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 200.f)];
    self.headerImageView.image = [UIImage imageNamed:@"a6efce1b9d16fdfa8bbfac72b88f8c5495ee7b5e"];
    return self.headerImageView;
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
    if (indexPath.row == 0) {
        [self tableViewRow0:tableView didSelectRowAtIndexPath:indexPath];
    }else if (indexPath.row == 1){
        [self tableViewRow1:tableView didSelectRowAtIndexPath:indexPath];
    }else if (indexPath.row == 2){
        [self tableViewRow2:tableView didSelectRowAtIndexPath:indexPath];
    }else if (indexPath.row == 3){
        [self tableViewRow3:tableView didSelectRowAtIndexPath:indexPath];
    }else if (indexPath.row == 4){
        [self tableViewRow4:tableView didSelectRowAtIndexPath:indexPath];
    }
}
//动态实例化
- (void)tableViewRow0:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view makeToast:@"动态实例化" duration:1 position:CSToastPositionBottom];
    NSString * imageUrlStr = @"http://scimg.jb51.net/allimg/151006/14-151006114S1135.jpg";
    self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(creatThread:) object:imageUrlStr];
    self.thread.threadPriority = 1;/// 设置线程的优先级(0.0 - 1.0，1.0最高级)
    self.thread.name = @"2";
    [self.thread start];
}
//静态实例化
- (void)tableViewRow1:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view makeToast:@"静态实例化" duration:1 position:CSToastPositionBottom];
    NSString * imageUrlStr = @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1528362227&di=e387c1dd12974411ca88a0dba02eba05&src=http://imgstore.cdn.sogou.com/app/a/100540002/472915.jpg";
    if (@available(iOS 10.0, *)) {//block回调创建线程是在iOS10之后才有的方法
        [NSThread detachNewThreadWithBlock:^{
         [self creatThread:imageUrlStr];
        }];
    } else {
        [NSThread detachNewThreadSelector:@selector(creatThread:) toTarget:self withObject:imageUrlStr];//创建线程后自动启动线程
    }
}
//隐式实例化
- (void)tableViewRow2:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view makeToast:@"隐式实例化" duration:1 position:CSToastPositionBottom];
    NSString * imageUrlStr = @"http://www.taopic.com/uploads/allimg/130602/240458-1306020P62434.jpg";
    [self performSelectorInBackground:@selector(creatThread:) withObject:imageUrlStr];
}
//强制退出当前线程
- (void)tableViewRow3:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSThread currentThread] cancel];
    if ([[NSThread currentThread] isCancelled]) {
        [NSThread exit];
    }
    [self.view makeToast:[NSString stringWithFormat:@"当前thread-exit线程为：%@",[NSThread currentThread]] duration:1 position:CSToastPositionBottom];
}
//用一个数组存储多条线程
- (void)tableViewRow4:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.threadArray) {
        self.threadArray = [NSMutableArray array];
    }
    [self.threadArray removeAllObjects];
    for (int i = 0; i < 10; i ++) {
        NSThread * thread = [[NSThread alloc]initWithTarget:self selector:@selector(arrayThreadAction:) object:[NSNumber numberWithInt:i]];
        thread.name = [NSString stringWithFormat:@"数组里面的线程%i",i];
        [self.threadArray addObject:thread];
        [thread start];
    }
    [self.view makeToast:[NSString stringWithFormat:@"当前thread-exit线程为：%@",[NSThread currentThread]] duration:1 position:CSToastPositionBottom];
}
- (void)arrayThreadAction:(NSString *)arrthreadObj
{
    [self.view makeToast:[NSString stringWithFormat:@"当前数组线程为：%@",[NSThread currentThread]] duration:1 position:CSToastPositionTop];
    NSLog(@"%@",[NSString stringWithFormat:@"当前数组线程为：%@",[NSThread currentThread]]);
    [[NSThread currentThread] cancel];
    [NSThread exit];
     [self performSelectorOnMainThread:@selector(reloadImage:) withObject:nil waitUntilDone:YES];//回到主线程刷新UI
}
- (void)creatThread:(NSString *)url{

    NSURL * Url = [NSURL URLWithString:url];
    NSData * data = [NSData dataWithContentsOfURL:Url];
    UIImage * image = [UIImage imageWithData:data];
    NSLog(@"Url=%@_data=%@_image=%@",Url,data,image);
    if (image) {
        [self performSelectorOnMainThread:@selector(reloadImage:) withObject:image waitUntilDone:YES];//回到主线程刷新UI
    }

}
- (void)reloadImage:(UIImage *)image
{
    [self.headerImageView setImage:image];
}






@end
