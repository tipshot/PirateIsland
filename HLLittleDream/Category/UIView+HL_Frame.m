//
//  UIView+HL_Frame.m
//  HLLittleDream
//
//  Created by asd on 2018/6/4.
//  Copyright © 2018年 HLRen. All rights reserved.
//

#import "UIView+HL_Frame.h"

@implementation UIView (HL_Frame)

- (CGFloat)hl_x{
    return self.frame.origin.x;
}
- (void)setHl_x:(CGFloat)hl_x
{
    CGRect frame = self.frame;
    frame.origin.x = hl_x;
    self.frame = frame;
}
- (CGFloat)hl_y{
    return self.frame.origin.y;
}
- (void)setHl_y:(CGFloat)hl_y{
    CGRect frame = self.frame;
    frame.origin.y = hl_y;
    self.frame = frame;
}
- (CGFloat)hl_right
{
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setHl_right:(CGFloat)hl_right
{
    CGRect frame = self.frame;
    frame.origin.x = hl_right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)hl_bottom
{
    return self.frame.origin.y - self.frame.size.height;
}
- (void)setHl_bottom:(CGFloat)hl_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = hl_bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)hl_width
{
    return self.frame.size.width;
}
- (void)setHl_width:(CGFloat)hl_width
{
    CGRect frame = self.frame;
    frame.size.width = hl_width;
    self.frame = frame;
}
- (CGFloat)hl_height
{
    return self.frame.size.height;
}
- (void)setHl_height:(CGFloat)hl_height
{
    CGRect frame = self.frame;
    frame.size.height = self.frame.size.height;
    self.frame = frame;
}
- (CGFloat)hl_centerX
{
    return self.center.x;
}
- (void)setHl_centerX:(CGFloat)hl_centerX
{
    self.center = CGPointMake(hl_centerX, self.center.y);
}
- (CGFloat)hl_centerY
{
    return self.center.y;
}
- (void)setHl_centerY:(CGFloat)hl_centerY
{
    self.center = CGPointMake(self.center.x, hl_centerY);
}
- (CGPoint)hl_origin
{
    return self.frame.origin;
}
- (void)setHl_origin:(CGPoint)hl_origin
{
    CGRect frame = self.frame;
    frame.origin = frame.origin;
    self.frame= frame;
}

- (CGSize)hl_size
{
    return self.frame.size;
}
- (void)setHl_size:(CGSize)hl_size
{
    CGRect frame = self.frame;
    frame.size = hl_size;
    self.frame = frame;
}

@end
