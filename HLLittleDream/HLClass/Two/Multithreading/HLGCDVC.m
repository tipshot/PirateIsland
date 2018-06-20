//
//  HLGCDVC.m
//  HLLittleDream
//
//  Created by asd on 2018/6/6.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "HLGCDVC.h"

@interface HLGCDVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * GCDTavleView;
@property (nonatomic,strong)NSArray * dataArray;
@end

@implementation HLGCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSArray arrayWithObjects:@"并发队列-异步",@"并发队列-同步",@"串行队列-异步",@"串行队列-同步",@"主队列-异步",@"主队列-同步-相互等待-卡死闪退",@"全局队列-异步",@"线程间通讯", nil];
    self.GCDTavleView = ({
        _GCDTavleView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_GCDTavleView];
        [_GCDTavleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        _GCDTavleView.delegate = self;
        _GCDTavleView.dataSource = self;
        _GCDTavleView;
    });
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
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // @"并发队列-同步",@"并发队列-异步",@"串行队列-同步",@"串行队列-异步",@"",
    [self.view makeToast:[self.dataArray objectAtIndex:indexPath.row]];
    if (indexPath.row == 0) {
        [self tableView0:tableView didSelectRowAtIndexPath:indexPath];
    }else if (indexPath.row == 1){
        [self tableView1:tableView didSelectRowAtIndexPath:indexPath];
    }else if (indexPath.row == 2){
        [self tableView2:tableView didSelectRowAtIndexPath:indexPath];
    }else if (indexPath.row == 3){
        [self tableView3:tableView didSelectRowAtIndexPath:indexPath];
    }else if (indexPath.row == 4){
        [self tableView4:tableView didSelectRowAtIndexPath:indexPath];
    }else if (indexPath.row == 5){
        [self tableView5:tableView didSelectRowAtIndexPath:indexPath];
    }else if (indexPath.row == 6){
        [self tableView6:tableView didSelectRowAtIndexPath:indexPath];
    }else if (indexPath.row == 7){
        [self tableView7:tableView didSelectRowAtIndexPath:indexPath];
    }
}

//并发队列-异步函数
- (void)tableView0:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"CONCURRENT_async_start");
    //先创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("test.asyncqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{//异步函数
        for (int i = 0; i < 3; i ++) {
            NSLog(@"CONCURRENT - async - 1-%d -----> %@",i,[NSThread currentThread]);
        }
    });

    dispatch_async(queue, ^{//异步函数
        for (int i = 0; i <3; i ++) {
            NSLog(@"CONCURRENT - async - 2-%d -----> %@",i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{//异步函数
        for (int i = 0; i <3; i ++) {
            NSLog(@"CONCURRENT - async - 3-%d -----> %@",i,[NSThread currentThread]);
        }
    });
    NSLog(@"CONCURRENT_async_end");
    //并发队列 异步函数 创建新的线程，-但是测试发现一个新开的子线程里面最多存放十个任务。在start执行之后，后面的任务 包括end都是随机执行的顺序。
    /*
     2018-06-20 09:15:38.548676+0800 HLLittleDream[3343:1158047] CONCURRENT_async_start
     2018-06-20 09:15:38.548952+0800 HLLittleDream[3343:1158047] CONCURRENT_async_end
     2018-06-20 09:15:38.558685+0800 HLLittleDream[3343:1159177] CONCURRENT - async - 1-0 -----> <NSThread: 0x1c4666180>{number = 10, name = (null)}
     2018-06-20 09:15:38.559050+0800 HLLittleDream[3343:1159177] CONCURRENT - async - 1-1 -----> <NSThread: 0x1c4666180>{number = 10, name = (null)}
     2018-06-20 09:15:38.559317+0800 HLLittleDream[3343:1159177] CONCURRENT - async - 1-2 -----> <NSThread: 0x1c4666180>{number = 10, name = (null)}
     2018-06-20 09:15:38.559601+0800 HLLittleDream[3343:1159177] CONCURRENT - async - 2-0 -----> <NSThread: 0x1c4666180>{number = 10, name = (null)}
     2018-06-20 09:15:38.559908+0800 HLLittleDream[3343:1159708] CONCURRENT - async - 3-0 -----> <NSThread: 0x1c4461d80>{number = 11, name = (null)}
     2018-06-20 09:15:38.559978+0800 HLLittleDream[3343:1159177] CONCURRENT - async - 2-1 -----> <NSThread: 0x1c4666180>{number = 10, name = (null)}
     2018-06-20 09:15:38.560196+0800 HLLittleDream[3343:1159708] CONCURRENT - async - 3-1 -----> <NSThread: 0x1c4461d80>{number = 11, name = (null)}
     2018-06-20 09:15:38.561020+0800 HLLittleDream[3343:1159708] CONCURRENT - async - 3-2 -----> <NSThread: 0x1c4461d80>{number = 11, name = (null)}
     2018-06-20 09:15:38.561304+0800 HLLittleDream[3343:1159177] CONCURRENT - async - 2-2 -----> <NSThread: 0x1c4666180>{number = 10, name = (null)}
     */
    
    
}

//并发队列-同步函数
- (void)tableView1:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"CONCURRENT_sync_start");
    //先创建并发队列
    dispatch_queue_t fistyQueue = dispatch_queue_create("test_asyncqueue", DISPATCH_QUEUE_CONCURRENT);
    
    //创建同步函数
    dispatch_sync(fistyQueue, ^{
        for (int i = 0; i <3; i ++) {
            NSLog(@"CONCURRENT - sync - 1-%d -----> %@",i,[NSThread currentThread]);
        }
    });
    dispatch_sync(fistyQueue, ^{
        for (int i = 0; i <3; i ++) {
            NSLog(@"CONCURRENT - sync - 2-%d -----> %@",i,[NSThread currentThread]);
        }
    });
    dispatch_sync(fistyQueue, ^{
        for (int i = 0; i <3; i ++) {
            NSLog(@"CONCURRENT - sync - 2-%d -----> %@",i,[NSThread currentThread]);
        }
    });
    NSLog(@"CONCURRENT_sync_end");
    //都在主线程中执行，没有开辟新的线程，在主线程中顺序执行,立即执行。
    /*
     2018-06-19 09:52:04.799251+0800 HLLittleDream[1577:629432] CONCURRENT_sync_start
     2018-06-19 09:52:04.800024+0800 HLLittleDream[1577:629432] CONCURRENT - sync - 1-0 -----> <NSThread: 0x1c0077400>{number = 1, name = main}
     2018-06-19 09:52:04.800602+0800 HLLittleDream[1577:629432] CONCURRENT - sync - 1-1 -----> <NSThread: 0x1c0077400>{number = 1, name = main}
     2018-06-19 09:52:04.800863+0800 HLLittleDream[1577:629432] CONCURRENT - sync - 1-2 -----> <NSThread: 0x1c0077400>{number = 1, name = main}
     2018-06-19 09:52:04.801115+0800 HLLittleDream[1577:629432] CONCURRENT - sync - 2-0 -----> <NSThread: 0x1c0077400>{number = 1, name = main}
     2018-06-19 09:52:04.801357+0800 HLLittleDream[1577:629432] CONCURRENT - sync - 2-1 -----> <NSThread: 0x1c0077400>{number = 1, name = main}
     2018-06-19 09:52:04.801597+0800 HLLittleDream[1577:629432] CONCURRENT - sync - 2-2 -----> <NSThread: 0x1c0077400>{number = 1, name = main}
     2018-06-19 09:52:04.801838+0800 HLLittleDream[1577:629432] CONCURRENT - sync - 2-0 -----> <NSThread: 0x1c0077400>{number = 1, name = main}
     2018-06-19 09:52:04.802490+0800 HLLittleDream[1577:629432] CONCURRENT - sync - 2-1 -----> <NSThread: 0x1c0077400>{number = 1, name = main}
     2018-06-19 09:52:04.802734+0800 HLLittleDream[1577:629432] CONCURRENT - sync - 2-2 -----> <NSThread: 0x1c0077400>{number = 1, name = main}
     2018-06-19 09:52:04.802839+0800 HLLittleDream[1577:629432] CONCURRENT_sync_end
     */

    
    
}
//串行-异步
- (void)tableView2:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"SERIAL_async_statr");
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (int i = 0; i <3; i ++) {
            NSLog(@"SERIAL_async_1_%d_thread%@",i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i <3; i ++) {
            NSLog(@"SERIAL_async_2_%d_thread%@",i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i <3; i ++) {
            NSLog(@"SERIAL_async_3_%d_thread%@",i,[NSThread currentThread]);
        }
    });
    NSLog(@"SERIAL_async_end");
    //串行队列-异步函数 在子线程中顺序执行
/*
 2018-06-15 17:35:20.380416+0800 HLLittleDream[1449:359136] SERIAL_async_statr
 2018-06-15 17:35:20.380955+0800 HLLittleDream[1449:359136] SERIAL_async_end
 2018-06-15 17:35:20.384832+0800 HLLittleDream[1449:359689] SERIAL_async_1_0_thread<NSThread: 0x1c0271a40>{number = 4, name = (null)}
 2018-06-15 17:35:20.384997+0800 HLLittleDream[1449:359689] SERIAL_async_1_1_thread<NSThread: 0x1c0271a40>{number = 4, name = (null)}
 2018-06-15 17:35:20.385139+0800 HLLittleDream[1449:359689] SERIAL_async_1_2_thread<NSThread: 0x1c0271a40>{number = 4, name = (null)}
 2018-06-15 17:35:20.385280+0800 HLLittleDream[1449:359689] SERIAL_async_2_0_thread<NSThread: 0x1c0271a40>{number = 4, name = (null)}
 2018-06-15 17:35:20.385412+0800 HLLittleDream[1449:359689] SERIAL_async_2_1_thread<NSThread: 0x1c0271a40>{number = 4, name = (null)}
 2018-06-15 17:35:20.385544+0800 HLLittleDream[1449:359689] SERIAL_async_2_2_thread<NSThread: 0x1c0271a40>{number = 4, name = (null)}
 2018-06-15 17:35:20.385681+0800 HLLittleDream[1449:359689] SERIAL_async_3_0_thread<NSThread: 0x1c0271a40>{number = 4, name = (null)}
 2018-06-15 17:35:20.387445+0800 HLLittleDream[1449:359689] SERIAL_async_3_1_thread<NSThread: 0x1c0271a40>{number = 4, name = (null)}
 2018-06-15 17:35:20.387681+0800 HLLittleDream[1449:359689] SERIAL_async_3_2_thread<NSThread: 0x1c0271a40>{number = 4, name = (null)}1
 */
    
}
//串行-同步
- (void)tableView3:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"SERIAL_sync_statr");
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("chaunxing_tongbu", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        for (int i = 0; i <3; i ++) {
            NSLog(@"SERIAL_sync_1_%d_thread%@",i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i <3; i ++) {
            NSLog(@"SERIAL_sync_2_%d_thread%@",i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i <3; i ++) {
            NSLog(@"SERIAL_sync_3_%d_thread%@",i,[NSThread currentThread]);
        }
    });
    NSLog(@"SERIAL_sync_end");
    
    //串行队列-同步函数 在主线程中执行 顺序执行任务-立马执行
/*
 2018-06-15 17:33:01.697365+0800 HLLittleDream[1442:354557] SERIAL_sync_statr
 2018-06-15 17:33:01.698087+0800 HLLittleDream[1442:354557] SERIAL_sync_1_0_thread<NSThread: 0x1c0074780>{number = 1, name = main}
 2018-06-15 17:33:01.698487+0800 HLLittleDream[1442:354557] SERIAL_sync_1_1_thread<NSThread: 0x1c0074780>{number = 1, name = main}
 2018-06-15 17:33:01.698742+0800 HLLittleDream[1442:354557] SERIAL_sync_1_2_thread<NSThread: 0x1c0074780>{number = 1, name = main}
 2018-06-15 17:33:01.698992+0800 HLLittleDream[1442:354557] SERIAL_sync_2_0_thread<NSThread: 0x1c0074780>{number = 1, name = main}
 2018-06-15 17:33:01.699235+0800 HLLittleDream[1442:354557] SERIAL_sync_2_1_thread<NSThread: 0x1c0074780>{number = 1, name = main}
 2018-06-15 17:33:01.699474+0800 HLLittleDream[1442:354557] SERIAL_sync_2_2_thread<NSThread: 0x1c0074780>{number = 1, name = main}
 2018-06-15 17:33:01.699715+0800 HLLittleDream[1442:354557] SERIAL_sync_3_0_thread<NSThread: 0x1c0074780>{number = 1, name = main}
 2018-06-15 17:33:01.700048+0800 HLLittleDream[1442:354557] SERIAL_sync_3_1_thread<NSThread: 0x1c0074780>{number = 1, name = main}
 2018-06-15 17:33:01.701048+0800 HLLittleDream[1442:354557] SERIAL_sync_3_2_thread<NSThread: 0x1c0074780>{number = 1, name = main}
 2018-06-15 17:33:01.701191+0800 HLLittleDream[1442:354557] SERIAL_sync_end
 */
    
}

//主队列-异步
- (void)tableView4:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"mainQueeu_async_start");
    
    //创建主队列
    dispatch_queue_t mainQueu = dispatch_get_main_queue();
    dispatch_async(mainQueu, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(mainQueu, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(mainQueu, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"mainQueeu_async_end");
    //主队列-异步，再主队列中顺序执行，但是不是立马执行。
    /*
     2018-06-20 09:33:49.777205+0800 HLLittleDream[3359:1167278] mainQueeu_async_start
     2018-06-20 09:33:49.777443+0800 HLLittleDream[3359:1167278] mainQueeu_async_end
     2018-06-20 09:33:49.785933+0800 HLLittleDream[3359:1167278] 1------<NSThread: 0x1c4075a40>{number = 1, name = main}
     2018-06-20 09:33:49.786284+0800 HLLittleDream[3359:1167278] 1------<NSThread: 0x1c4075a40>{number = 1, name = main}
     2018-06-20 09:33:49.786563+0800 HLLittleDream[3359:1167278] 2------<NSThread: 0x1c4075a40>{number = 1, name = main}
     2018-06-20 09:33:49.786811+0800 HLLittleDream[3359:1167278] 2------<NSThread: 0x1c4075a40>{number = 1, name = main}
     2018-06-20 09:33:49.787061+0800 HLLittleDream[3359:1167278] 3------<NSThread: 0x1c4075a40>{number = 1, name = main}
     2018-06-20 09:33:49.787296+0800 HLLittleDream[3359:1167278] 3------<NSThread: 0x1c4075a40>{number = 1, name = main}

     */
}

//全局队列-同步-相互等待-卡死闪退
- (void)tableView5:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"mainQueue_sync_start");
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_sync(mainQueue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    NSLog(@"mainQueue_sync_end");
}
    
//全局队列-异步
- (void)tableView6:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2. 异步执行
    for (int i = 0; i < 10; ++i) {
        dispatch_async(q, ^{
            NSLog(@"asyncGloba：%@ %d", [NSThread currentThread], i);
        });
    }
    NSLog(@"come here");
    
    //开辟子线程，没有顺序执行。
    
}
//线程间通讯
- (void)tableView7:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //在主线程中执行任务
    dispatch_async(queue, ^{
        NSLog(@"开始执行任务 - %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];//执行任务的时间-模拟
        NSLog(@"任务执行结束 - %@",[NSThread currentThread]);
        
        ///回到主线程中刷新UI
        dispatch_async(mainQueue, ^{
            NSLog(@"UI开始刷新 - %@",[NSThread currentThread]);
            [NSThread sleepForTimeInterval:2];
            NSLog(@"UI刷新结束 - %@",[NSThread currentThread]);
        });
        
    });
    
    
}






























































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
