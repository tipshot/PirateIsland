//
//  HLMapTypeTableViewCell.m
//  HLLittleDream
//
//  Created by asd on 2018/4/25.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "HLMapTypeTableViewCell.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface HLMapTypeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *weiXingBtn;


@property (weak, nonatomic) IBOutlet UIButton *TwoDBtn;


@property (weak, nonatomic) IBOutlet UIButton *ThreeDBtn;




@end
@implementation HLMapTypeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)weiXingBtnClick:(UIButton *)sender {
    sender.selected = YES;
    [self changeStateWithBtn:sender];
    if (self.mapTypeBlock) {
        self.mapTypeBlock(MAMapTypeSatellite);
    }
}


- (IBAction)TwoDBtnClick:(UIButton *)sender {
    sender.selected = YES;
    [self changeStateWithBtn:sender];
    if (self.mapTypeBlock) {
        self.mapTypeBlock(MAMapTypeStandard);
    }
}

- (IBAction)ThreeDBtnClick:(UIButton *)sender {
    sender.selected = YES;
    [self changeStateWithBtn:sender];
    if (self.mapTypeBlock) {
        self.mapTypeBlock(MAMapTypeNavi);
    }
}
- (void)changeStateWithBtn:(UIButton*)btn
{
    self.weiXingBtn.selected = NO;
    self.TwoDBtn.selected = NO;
    self.ThreeDBtn.selected = NO;
    btn.selected = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
