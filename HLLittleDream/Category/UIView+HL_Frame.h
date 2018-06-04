//
//  UIView+HL_Frame.h
//  HLLittleDream
//
//  Created by asd on 2018/6/4.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HL_Frame)

@property (nonatomic) CGFloat hl_x;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat hl_y;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat hl_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat hl_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat hl_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat hl_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat hl_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat hl_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint hl_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  hl_size;        ///< Shortcut for frame.size.

@end
