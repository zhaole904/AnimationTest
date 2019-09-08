//
//  LocusView.m
//  SONiX－飞控
//
//  Created by zxc-02 on 16/8/15.
//  Copyright © 2016年 黎峰麟. All rights reserved.
//

#import "LocusView.h"
//#import "UIImage+MJ.h"

@interface LocusView ()<CAAnimationDelegate>
{
    CGPoint _currentPoint;
    CGFloat x;
    CGFloat y;
    
    CGFloat xx;
    CGFloat yy;
    
    CGFloat time;
}

@property(nonatomic,strong) NSMutableArray *paths;
@property (nonatomic, strong) UIImageView *flyView;

@property(nonatomic,strong) NSMutableArray *pointArr;
@property (nonatomic, strong) NSMutableArray *sumArr;

@property (nonatomic, assign) double lastTime;

@property (nonatomic, strong) UIBezierPath *path;
@end


@implementation LocusView

- (NSMutableArray *)paths
{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (NSMutableArray *)resultArr
{
    if (_resultArr == nil) {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}

- (NSMutableArray *)pointArr
{
    if (_pointArr == nil) {
        _pointArr = [NSMutableArray array];
    }
    return _pointArr;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearView];
    
    UITouch *touch = [touches anyObject];
    CGPoint strat = [touch locationInView:touch.view];
    self.path = [UIBezierPath bezierPath];
    [self.path moveToPoint:strat];
    [self.path setLineWidth:5.0];
    [self.path setLineCapStyle:kCGLineCapRound];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint move = [touch locationInView:touch.view];
    [self.path addLineToPoint:move];
    [self setNeedsDisplay];
    
    _currentPoint = self.path.currentPoint;
    
    NSString *pointStr = NSStringFromCGPoint(_currentPoint);
    for (int i = 0; i < 4; i ++) {
        [self.pointArr addObject:pointStr];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint end = [touch locationInView:touch.view];
    [self.path addLineToPoint:end];
    [self setNeedsDisplay];
  
    _sumArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.pointArr.count - 1; i ++) {
        NSString *str1 = self.pointArr[i];
        NSString *str2 = self.pointArr[i+1];
        CGPoint point1 = CGPointFromString(str1);
        CGPoint point2 = CGPointFromString(str2);
        CGFloat yValue = point2.y-point1.y;
        CGFloat xValue = point2.x-point1.x;
        CGFloat value;
        value = yValue / xValue;
        
        CGFloat l = sqrt(pow(xValue, 2) + pow(yValue, 2));
        NSString *str = [NSString stringWithFormat:@"%f",l];
        [_sumArr addObject:str];
    }
    
    
    //    NSNumber *sum = [_sumArr valueForKeyPath:@"@sum.floatValue"];
    //    NSLog(@"resultArr.cound==%ld pointArr.cound==%ld,%f",self.resultArr.count,self.pointArr.count,[sum floatValue]);
    
    _flyView = [[UIImageView alloc] init];
    _flyView.center = CGPointMake(-50,-50);
    _flyView.bounds = CGRectMake(0, 0, 40, 40);
    _flyView.image = [UIImage imageNamed:@"12"];
    [self addSubview:_flyView];
    
        CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        pathAnimation.calculationMode = kCAAnimationPaced;  //平均
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.repeatCount = 0;
        pathAnimation.duration = 3;
        //设置运转动画的路径
        pathAnimation.path = self.path.CGPath;
        pathAnimation.rotationMode = kCAAnimationRotateAuto;
        pathAnimation.delegate = self;
        [_flyView.layer addAnimation:pathAnimation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        [self clearView];
        [_flyView removeFromSuperview];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@1 forKey:@"animationDidFinished"];
    }
    
    self.resultArr = nil;
}

- (void)animationDidStart:(CAAnimation *)anim
{
    if (self.callblock) {
        self.callblock(self.resultArr,0.0);
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
}

- (void)drawRect:(CGRect)rect
{
    
    [[UIColor orangeColor] set];
    [self.path stroke];
}

- (void)clearView
{
    [self.paths removeAllObjects];
    [self.path removeAllPoints];
    self.path = nil;
    self.layer.sublayers= nil;
    [self.pointArr removeAllObjects];
    [_flyView removeFromSuperview];
    [self.layer removeAllAnimations];
    [self setNeedsDisplay];
}

- (void)lastTimeView
{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}
/*
 若要实时画图，不能使用gestureRecognizer，只能使用touchbegan等方法来掉用setNeedsDisplay实时刷新屏幕
 首先两个方法都是异步执行的。而setNeedsDisplay会调用自动调用drawRect方法，这样可以拿到UIGraphicsGetCurrentContext，就可以画画了。而setNeedsLayout会默认调用layoutSubViews，
  就可以  处理子视图中的一些数据。
 综上所诉，setNeedsDisplay方便绘图，而layoutSubViews方便出来数据
 */
@end
