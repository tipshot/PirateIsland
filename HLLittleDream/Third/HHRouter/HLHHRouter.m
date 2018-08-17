//
//  HLHHRouter.m
//  HLLittleDream
//
//  Created by asd on 2018/4/17.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "HLHHRouter.h"
#import "GaoDeToBaiDuMap.h"
#import "HLPayVC.h"//支付页面
#import "HLMapSearchResultViewController.h"//地图搜索页面
#import "HLTwoMultithreadingViewController.h"//多线程
#import "HLThreadVC.h"//多线程
#import "HLGCDVC.h"//多线程
#import "HLNSOperationVC.h"//多线程
#import "AAChartViewController.h"//图标工具
@implementation HLHHRouter


+ (void)HHRouterMap
{
    [[HHRouter shared] map:GaoDeToBaiDuMapName toControllerClass:[GaoDeToBaiDuMap class]];//使用高德地图仿照百度地图
    [[HHRouter shared] map:HLPayVCName toControllerClass:[HLPayVC class]];//支付宝和微信支付
    [[HHRouter shared] map:HLMapSearchResultVCName toControllerClass:[HLMapSearchResultViewController class]];//地图搜索结果页面
    [[HHRouter shared] map:HLMultithreadingVCName toControllerClass:[HLTwoMultithreadingViewController class]];//多线程
    [[HHRouter shared] map:HLThreadVCName toControllerClass:[HLThreadVC class]];//Thread多线程
    [[HHRouter shared] map:HLGCDVCName toControllerClass:[HLGCDVC class]];//GCD多线程
    [[HHRouter shared] map:HLNSOperationVCName toControllerClass:[HLNSOperationVC class]];//NSOperation多线程
    [[HHRouter shared] map:AAChartVCName toControllerClass:[AAChartViewController class]];//图表 工具
}
@end
