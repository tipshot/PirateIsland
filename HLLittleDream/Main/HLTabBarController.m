//
//  HLTabBarController.m
//  HLLittleDream
//
//  Created by asd on 2018/4/2.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "HLTabBarController.h"
#import "HLNavigationController.h"
#import "HLOneVC.h"
#import "HLTwoVC.h"
#import "HLThreeVC.h"
#import "HLFourVC.h"

@interface HLTabBarController ()

@end

@implementation HLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChild];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addChild
{
    [self setChilldrenVCName:@"HLOneVC" andTitle:@"One" andImageName:@"" andSeletedImageName:@""];
    [self setChilldrenVCName:@"HLTwoVC" andTitle:@"Two" andImageName:@"" andSeletedImageName:@""];
    [self setChilldrenVCName:@"HLThreeVC" andTitle:@"Three" andImageName:@"" andSeletedImageName:@""];
    [self setChilldrenVCName:@"HLFourVC" andTitle:@"Four" andImageName:@"" andSeletedImageName:@""];
}

- (void)setChilldrenVCName:(NSString *)childrenVCName andTitle:(NSString *)title andImageName:(NSString *)imageName andSeletedImageName:(NSString *)seletedImageName
{
    
    id class = NSClassFromString(childrenVCName);
    HLBaseViewController * VC = [[class alloc]init];
    VC.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:imageName];
    VC.tabBarItem.imageInsets = UIEdgeInsetsMake(-0, 0, 0, 0);
    [VC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(-4, -4)];
    if ([title isEqualToString:@""]) {
        VC.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //设置选中图片并改变系统的默认渲染。
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:seletedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置标题颜色等
    NSMutableDictionary * tabbarColourDict = [NSMutableDictionary dictionary];
    tabbarColourDict [NSForegroundColorAttributeName] = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];//设置标题颜色为灰色
    tabbarColourDict [NSForegroundColorAttributeName] = [UIColor blackColor];
    [VC.tabBarItem setTitleTextAttributes:tabbarColourDict forState:UIControlStateNormal];
    //    [VC.tabBarItem setImage:[UIImage imageNamed:@""]];
    
    //    设置标题选中颜色
    NSMutableDictionary * tabbarSeletedColourDict = [NSMutableDictionary dictionary];
    tabbarSeletedColourDict [NSForegroundColorAttributeName] = [UIColor clearColor];
    [VC.tabBarItem setTitleTextAttributes:tabbarSeletedColourDict forState:UIControlStateSelected];
    //    包装NAV
    HLNavigationController * nav = [[HLNavigationController alloc]initWithRootViewController:VC];
    
    [self addChildViewController:nav];
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
