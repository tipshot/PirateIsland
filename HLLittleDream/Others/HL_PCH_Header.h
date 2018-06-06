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

//所引用
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif




//高德地图的Key
#define AMapkey @"1a7f1f9106e1e8d0385816699879040a"

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



