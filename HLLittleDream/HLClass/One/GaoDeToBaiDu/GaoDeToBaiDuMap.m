//
//  GaoDeToBaiDuMap.m
//  HLLittleDream
//
//  Created by asd on 2018/4/2.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "GaoDeToBaiDuMap.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "HLGaoDeCoverAgeViewController.h"//图层VC
@interface GaoDeToBaiDuMap ()<MAMapViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic,strong) UIButton * SinceTheRoadsBtn;//路况按钮
@property (nonatomic,strong) UIButton * coverageBtn;//图层按钮
@end

@implementation GaoDeToBaiDuMap

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"高德模仿百度地图";
    [self creatAndShowMap];
}

//创建并展示地图
- (void)creatAndShowMap
{
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    self.mapView = [[MAMapView alloc] init];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(64);
    }];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    [self.mapView setZoomLevel:17.5 animated:YES];
    [self creatSinceTheRoads];//创建路况
    [self creatCoverageBtn];//图层按钮

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 开启定位
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;

}
//创建路况按钮
- (void)creatSinceTheRoads
{
    self.SinceTheRoadsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mapView addSubview:self.SinceTheRoadsBtn];
    [self.SinceTheRoadsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(70);
        make.width.height.mas_equalTo(60);
    }];
    [self.SinceTheRoadsBtn setTitle:@"展示路况" forState:UIControlStateNormal];
    [self.SinceTheRoadsBtn setTitle:@"正展示路况" forState:UIControlStateSelected];
    [self.SinceTheRoadsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.SinceTheRoadsBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    self.SinceTheRoadsBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.SinceTheRoadsBtn.backgroundColor = KRandomColor;
    [self.SinceTheRoadsBtn addTarget:self action:@selector(sinceTheRoadsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sinceTheRoadsBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.mapView.showTraffic = sender.selected;
    
}
//创建图层按钮
- (void)creatCoverageBtn
{
    self.coverageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mapView addSubview:self.coverageBtn];
    [self.coverageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.SinceTheRoadsBtn.mas_bottom).offset(20);
        make.width.height.mas_equalTo(60);
    }];
    [self.coverageBtn setTitle:@"图层" forState:UIControlStateNormal];
    self.coverageBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.coverageBtn.backgroundColor = KRandomColor;
    [self.coverageBtn addTarget:self action:@selector(coverageBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)coverageBtnClick:(UIButton *)sender
{
    NSLog(@"%@",sender);
    HLGaoDeCoverAgeViewController * coverAgeVC = [HLGaoDeCoverAgeViewController new];
    coverAgeVC.mapView = self.mapView;
    [self.navigationController presentViewController:coverAgeVC animated:YES completion:nil];
//    [self ShareBtnClick:sender];
    
}

- (void)creatZoomBtn
{
    [_mapView setZoomLevel:17.5 animated:YES];
}


- (void)ShareBtnClick:(UIButton*)sender

{
    
    //非空判断
    
//    if(!self.goodsInformationModel.name) {
//
//        UIAlertView* alertView = [[UIAlertViewalloc]initWithTitle:@"西门吸雪"message:@"请等待加载数据，亦或是后台没有数据，请稍后重试"delegate:nilcancelButtonTitle:nilotherButtonTitles:@"朕知道了",nil];[alertViewshow];
//
//        return;
//
//    }
    
    NSString*textToShare = @"ceshi 分享内容";
    
    NSString* imageStr;
    
    //非空判断
    
//    if(!self.goodsInformationModel.image_default_id) {
    
        imageStr =@"https://upload-images.jianshu.io/upload_images/2208060-d753c69d336646ae.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/456";
        
//    }else{
//
//        imageStr = [self.goodsInformationModel.image_default_idobjectAtIndex:1];
//
//    }
    
    UIImage*imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]]];
    
    NSURL*urlToShare = [NSURL URLWithString:imageStr];
    
    NSArray*activityItems =@[textToShare, imageToShare, urlToShare];
    
    UIActivityViewController*activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems
                                           
                                                                          applicationActivities:nil];
    
    //不出现在活动项目
/*
 
 UIKIT_EXTERN UIActivityType const UIActivityTypePostToFacebook     NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypePostToTwitter      NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypePostToWeibo        NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;    // SinaWeibo
 UIKIT_EXTERN UIActivityType const UIActivityTypeMessage            NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypeMail               NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypePrint              NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypeCopyToPasteboard   NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypeAssignToContact    NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypeSaveToCameraRoll   NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypeAddToReadingList   NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypePostToFlickr       NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypePostToVimeo        NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypePostToTencentWeibo NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypeAirDrop            NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypeOpenInIBooks       NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED;
 UIKIT_EXTERN UIActivityType const UIActivityTypeMarkupAsPDF        NS_AVAILABLE_IOS(11_0) __TVOS_PROHIBITED;
 */

    
    activityVC.excludedActivityTypes=@[UIActivityTypePostToFacebook,
                                       UIActivityTypePostToTwitter,
                                       UIActivityTypePostToWeibo,
                                       UIActivityTypeMessage,
                                       UIActivityTypeMail,
                                       UIActivityTypePrint,
                                       UIActivityTypeCopyToPasteboard,
                                       UIActivityTypeAssignToContact,
                                       UIActivityTypeSaveToCameraRoll,
                                       UIActivityTypeAddToReadingList,
                                       UIActivityTypePostToFlickr,
                                       UIActivityTypePostToVimeo,
                                       UIActivityTypePostToTencentWeibo,
//                                       UIActivityTypeAirDrop,
//                                       UIActivityTypeOpenInIBooks,
                                       UIActivityTypeMarkupAsPDF];
    
    [self presentViewController:activityVC animated:TRUE completion:nil];
    //SLComposeViewController *shareVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
}





@end
