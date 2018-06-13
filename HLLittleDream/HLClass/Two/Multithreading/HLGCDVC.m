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
    self.dataArray = [NSArray arrayWithObjects:@"并发队列-同步",@"并发队列-异步",@"串行队列-同步",@"串行队列-异步",@"", nil];
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
    [self.view makeToast:[self.dataArray objectAtIndex:indexPath.row]];
    if (indexPath.row == 0) {
        [self tableView0:tableView didSelectRowAtIndexPath:indexPath];
    }
}

//同步-并发
- (void)tableView0:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
