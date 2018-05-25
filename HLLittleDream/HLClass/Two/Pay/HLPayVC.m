//
//  HLPayVC.m
//  HLLittleDream
//
//  Created by asd on 2018/4/17.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "HLPayVC.h"

@interface HLPayVC ()
@property (nonatomic,strong)UIButton * ALiPayBtn;
@property (nonatomic,strong)UIButton * WeChatBtn;
@end

@implementation HLPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KRandomColor;
    self.title = @"支付宝、微信支付";//主干提交
}




@end
