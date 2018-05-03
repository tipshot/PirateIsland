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
#import <AMapSearchKit/AMapSearchKit.h>

@interface GaoDeToBaiDuMap ()<MAMapViewDelegate,AMapSearchDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic,strong) UIButton * SinceTheRoadsBtn;//路况按钮
@property (nonatomic,strong) UIButton * coverageBtn;//图层按钮
@property (nonatomic,strong) UIButton * addBtn;//加号按钮
@property (nonatomic,strong) UIButton * minusBtn;//减号按钮
@property (nonatomic,assign) CGFloat zoom;//缩放比例
@property (nonatomic,strong) UIView * searchBackView;//搜索背景View
@property (nonatomic,strong) UITextField * searchTextField;//搜索输入框
@property (nonatomic,strong) UIButton * searchButton;//搜索按钮
@property (nonatomic,strong)AMapSearchAPI * searchApi;//搜索对象
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
    [self creatSearchAPI];
    [self creatSearchView];//创建搜索框

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

#pragma mark - 创建搜索

- (void)creatSearchAPI
{
    self.searchApi = [[AMapSearchAPI alloc]init];
    self.searchApi.delegate = self;
    [AMapServices sharedServices].apiKey = AMapkey;
}

- (void)creatSearchView
{
    self.searchBackView = [UIView new];
    [self.mapView addSubview:self.searchBackView];
    self.searchBackView.backgroundColor = [UIColor whiteColor];
    [self.searchBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBackView addSubview:self.searchButton];
    [self.searchButton setBackgroundColor:KRandomColor];
    [self.searchButton addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(80);
    }];
    
    
    self.searchTextField = [[UITextField alloc]init];
    [self.searchBackView addSubview:self.searchTextField];
    self.searchTextField.placeholder = @"请输入要搜索的地方";
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-80);
    }];
    

    
}

- (void)searchBtnClick:(UIButton *)sender
{
    if (!self.searchTextField.text || !self.searchTextField.text.length) {
        NSLog(@"请输入关键字");
        return;
    }
    
    [self.searchTextField endEditing:YES];
    
    AMapPOIKeywordsSearchRequest * request = [AMapPOIKeywordsSearchRequest new];
    request.keywords = self.searchTextField.text;
    
    [self.searchApi AMapPOIKeywordsSearch:request];
    
    
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
 
    NSLog(@"request = %@,response = %@",request,response);
    NSLog(@"response.pois = %@",response.pois);
}




@end
