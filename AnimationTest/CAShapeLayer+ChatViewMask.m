//
//  CAShapeLayer+ChatViewMask.m
//  Animationsss
//
//  Created by fuchun on 2017/10/17.
//  Copyright © 2017年 le. All rights reserved.
//链接：http://www.jianshu.com/p/a1e88a277975

#import "CAShapeLayer+ChatViewMask.h"

@implementation CAShapeLayer (ChatViewMask)

+ (instancetype)createMaskLayerWithView:(UIView *)view
{
    
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    
    CGFloat rightSpace = 10.;
    CGFloat topSpace = 15.;
    
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth-rightSpace, 0);
    CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);
    CGPoint point4 = CGPointMake(viewWidth, topSpace);
    CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+10.);
    CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight);
    CGPoint point7 = CGPointMake(0, viewHeight);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
    //当外面[view.layer addSublayer:layer]; 下面代码生效，如果外面view.layer.mask = layer;显示view.backgroundColor
    layer.fillColor = [UIColor greenColor].CGColor;
    return layer;
}


@end
