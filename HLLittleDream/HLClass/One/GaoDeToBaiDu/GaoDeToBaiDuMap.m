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
@property (nonatomic,strong) UIButton * addBtn;//加号按钮
@property (nonatomic,strong) UIButton * minusBtn;//减号按钮
@property (nonatomic,assign) CGFloat zoom;
@end

@implementation GaoDeToBaiDuMap

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"高德模仿百度地图";
    self.zoom = 17.5;
    [self creatAndShowMap];
}


#pragma mark - 创建并展示地图
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
    [_mapView setZoomLevel:17.5 animated:YES];
    [self.mapView setZoomLevel:_zoom animated:YES];
    [self creatSinceTheRoads];//创建路况
    [self creatCoverageBtn];//图层按钮
    [self creatZoomBtn];//创建加减号按钮
    [self creatUserLocationBtn];//创建用户定位按钮

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 开启定位
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;

}

#pragma mark - 创建路况按钮
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

#pragma mark - 创建图层按钮
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
    
    HLGaoDeCoverAgeViewController * coverAgeVC = [HLGaoDeCoverAgeViewController new];
    coverAgeVC.mapView = self.mapView;
    [self.navigationController presentViewController:coverAgeVC animated:YES completion:nil];
//    [self ShareBtnClick:sender];
    
}

#pragma mark - 创建放大缩小按钮
- (void)creatZoomBtn
{
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mapView addSubview:self.addBtn];
    [self.addBtn setBackgroundColor:KRandomColor];
    [self.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.coverageBtn.mas_bottom).offset(80);
        make.width.height.mas_equalTo(30);
    }];
    
    self.minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mapView addSubview:self.minusBtn];
    [self.minusBtn setBackgroundColor:KRandomColor];
    [self.minusBtn addTarget:self action:@selector(minusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.minusBtn setTitle:@"-" forState:UIControlStateNormal];
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.addBtn.mas_bottom).offset(20);
        make.width.height.mas_equalTo(30);
    }];
    
}
- (void)addBtnClick:(UIButton *)sender
{
    if (_zoom < 19) {
        _zoom += 1;
    }else{
        
    }
    [self changeZoom];
}

- (void)minusBtnClick:(UIButton *)sender
{
    if (_zoom > 3) {
        _zoom -= 1;
    }
    [self changeZoom];
}

- (void)changeZoom
{
    [self.mapView setZoomLevel:_zoom animated:YES];
    
}



#pragma mark - 创建定位点
- (void)creatUserLocationBtn
{
    UIButton * userLocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mapView addSubview:userLocationBtn];
    [userLocationBtn setBackgroundColor:KRandomColor];
    [userLocationBtn setTitle:@"定位" forState:UIControlStateNormal];
    [userLocationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    userLocationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [userLocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-100);
        make.left.mas_equalTo(30);
        make.width.height.mas_equalTo(30);
    }];
}
- (void)locationBtnClick:(UIButton *)sender
{
    if(self.mapView.userLocation.updating && self.mapView.userLocation.location) {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
        [sender setSelected:YES];
    }
}


- (void)ShareBtnClick:(UIButton*)sender
{
    NSString*textToShare = @"ceshi 分享内容";
    NSString* imageStr =@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1525235722748&di=0ea8ea16b71ea50e8f848e1b9c275a1c&imgtype=0&src=http%3A%2F%2Fold.bz55.com%2Fuploads%2Fallimg%2F150210%2F139-150210134411-50.jpg";
    UIImage*imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]]];
    NSURL*urlToShare = [NSURL URLWithString:imageStr];
    NSArray*activityItems =@[textToShare, imageToShare, urlToShare];
    UIActivityViewController*activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    
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

    
//    activityVC.excludedActivityTypes=@[
//                                       UIActivityTypePostToFacebook,
//                                       UIActivityTypePostToTwitter,
//                                       UIActivityTypePostToWeibo,
//                                       UIActivityTypeMessage,
//                                       UIActivityTypeMail,
//                                       UIActivityTypePrint,
//                                       UIActivityTypeCopyToPasteboard,
//                                       UIActivityTypeAssignToContact,
//                                       UIActivityTypeSaveToCameraRoll,
//                                       UIActivityTypeAddToReadingList,
//                                       UIActivityTypePostToFlickr,
//                                       UIActivityTypePostToVimeo,
//                                       UIActivityTypePostToTencentWeibo,
//                                       UIActivityTypeAirDrop,
//                                       UIActivityTypeOpenInIBooks,
//                                       UIActivityTypeMarkupAsPDF
//                                       ];
    
    [self presentViewController:activityVC animated:TRUE completion:nil];
    //SLComposeViewController *shareVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
}





@end
