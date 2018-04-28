//
//  HLMapTypeTableViewCell.h
//  HLLittleDream
//
//  Created by asd on 2018/4/25.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

typedef void(^HLMapTypeBlock)(MAMapType mapType);

@interface HLMapTypeTableViewCell : UITableViewCell
/**<#message#>*/
@property (nonatomic,copy) HLMapTypeBlock mapTypeBlock;
@end
