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
@implementation HLHHRouter
+ (void)HHRouterMap
{
    [[HHRouter shared] map:GaoDeToBaiDuMapName toControllerClass:[GaoDeToBaiDuMap class]];//使用高德地图仿照百度地图
    [[HHRouter shared] map:HLPayVCName toControllerClass:[HLPayVC class]];//支付宝和微信支付
    [[HHRouter shared] map:HLMapSearchResultVCName toControllerClass:[HLMapSearchResultViewController class]];//地图搜索结果页面
    
}
@end
