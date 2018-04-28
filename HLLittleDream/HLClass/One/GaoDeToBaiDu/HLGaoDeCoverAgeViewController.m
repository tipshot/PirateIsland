//
//  HLGaoDeCoverAgeViewController.m
//  HLLittleDream
//
//  Created by asd on 2018/4/24.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "HLGaoDeCoverAgeViewController.h"
#import "HLMapTypeTableViewCell.h"

@interface HLGaoDeCoverAgeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *gaodeCoverAgeTableView;
@end

@implementation HLGaoDeCoverAgeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        [self setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.4f alpha:0.3];
    self.gaodeCoverAgeTableView.delegate = self;
    self.gaodeCoverAgeTableView.dataSource = self;
    [self.gaodeCoverAgeTableView registerNib:[UINib nibWithNibName:@"HLMapTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HLMapTypeTableViewCell"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0 && indexPath.row == 0) {
        HLMapTypeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HLMapTypeTableViewCell"];
        if (cell == nil) {
            cell= [[[NSBundle  mainBundle]  loadNibNamed:@"HLMapTypeTableViewCell" owner:self options:nil]  lastObject];
        }
        cell.mapTypeBlock = ^(MAMapType mapType) {
            NSLog(@"%ld",mapType);
            if (mapType == 0) {//普通地图
                self.mapView.mapType = MAMapTypeStandard;
            }else if (mapType == 1){//卫星地图
                self.mapView.mapType = MAMapTypeSatellite;
            }else if (mapType == 3){//公交视图
                self.mapView.mapType = MAMapTypeBus;
            }
        };
        return cell;
        
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        }
        
        return cell;
    }
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}







@end
