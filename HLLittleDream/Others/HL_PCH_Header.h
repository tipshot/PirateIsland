//
//  HL_PCH_Header.h
//  HLLittleDream
//
//  Created by asd on 2018/4/2.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#ifndef HL_PCH_Header_h
#define HL_PCH_Header_h


#endif /* HL_PCH_Header_h */

//屏幕相关
#define KScreenBounds [UIScreen mainScreen].bounds
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
//颜色相关
#define KRandomColor [UIColor colorWithRed:KRandomNum(255)/255.0 green:KRandomNum(255)/255.0 blue:KRandomNum(255)/255.0 alpha:1]/**随机颜色*/
#define KTitleColor333333 [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]/**用于一级文字信息-标题、title、内容主题等*/
#define KTitleColor666666 [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]/**二级文字*/
#define KTitleColor999999 [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]/**三级文字*/
#define KbtnEndebleColor [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]/**按钮的禁用背景颜色*/
//随机数字
#define KRandomNum(x) arc4random_uniform(x)/**随机数*/



