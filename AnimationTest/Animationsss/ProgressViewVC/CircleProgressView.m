//
//  CircleProgressView.m
//  ProgressView
//
//  Created by zhao on 16/9/13.
//  Copyright © 2016年 zhaoName. All rights reserved.
//  正常的圆形进度条

#import "CircleProgressView.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@implementation CircleProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if([super initWithFrame:frame])
    {
        [self initData];
    }
    return self;
}

- (instancetype)init
{
    if([super init])
    {
        [self initData];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if([super initWithCoder:aDecoder])
    {
        [self initData];
    }
    return self;
}

/** 初始化数据*/
- (void)initData
{
    self.progressWidth = 3.0;
    self.progressColor = [UIColor redColor];
    self.progressBackgroundColor = [UIColor grayColor];
    self.percent = 0.0;
    self.clockwise = 0;
    
    self.labelbackgroundColor = [UIColor clearColor];
    self.textColor = [UIColor blackColor];
    self.textFont = [UIFont systemFontOfSize:15];
}

- (void)layoutSubviews
{
    [super addSubview:self.centerLabel];
    self.centerLabel.backgroundColor = self.labelbackgroundColor;
    self.centerLabel.textColor = self.textColor;
    self.centerLabel.font = self.textFont;
    [self addSubview:self.centerLabel];
}

#pragma mark -- 画进度条

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShouldAntialias(context, YES); // 平滑
    CGContextAddArc(context, WIDTH/2, HEIGHT/2, (WIDTH-self.progressWidth)/2, 0, M_PI*2, 0);
    [self.progressBackgroundColor setStroke];
    CGContextSetLineWidth(context, self.progressWidth);
    CGContextStrokePath(context);
    
    if(self.percent)
    {
        // 模拟时钟，注意修改0.05（定时器累加进度）效果和HemicycleLoadProgressView一样
        if (self.loopMove) {
            CGFloat angle = 2*M_PI- 2 * self.percent * M_PI;
            CGFloat angle1 = 2*M_PI- 2 * (self.percent-0.05) * M_PI;

            CGContextAddArc(context, WIDTH/2, HEIGHT/2, (WIDTH-self.progressWidth)/2,angle1, angle, 0);
            [self.progressColor setStroke];
            CGContextSetLineWidth(context, self.progressWidth);
            CGContextStrokePath(context);
            return;
        }
        
        CGFloat angle = 2*M_PI- 2 * self.percent * M_PI;
        //反方向--起点为最右边：0, angle, 起点为最顶端-M_PI/2, angle-M_PI/2
        //正方向--起点为最右边：0, -angle, 起点为最顶端-M_PI/2, -angle-M_PI/2
        if(self.clockwise) {// 反方向

             CGContextAddArc(context, WIDTH/2, HEIGHT/2, (WIDTH-self.progressWidth)/2,0, angle, 0);
        } else {// 正方向
            
            CGContextAddArc(context, WIDTH/2, HEIGHT/2, (WIDTH-self.progressWidth)/2, 0,  -angle, 1);
        }
        
//    原始代码
//        CGFloat angle = 2 * self.percent * M_PI - M_PI_2;
//        if(self.clockwise) {// 反方向
//             CGContextAddArc(context, WIDTH/2, HEIGHT/2, (WIDTH-self.progressWidth)/2, ((int)self.percent == 1 ? -M_PI_2 : angle), -M_PI_2, 0);
//
//        } else {// 正方向
//             CGContextAddArc(context, WIDTH/2, HEIGHT/2, (WIDTH-self.progressWidth)/2, -M_PI_2, angle, 0);
//
//        }
        
        
        [self.progressColor setStroke];
        CGContextSetLineWidth(context, self.progressWidth);
        CGContextStrokePath(context);
    }
}

#pragma mark -- 中间label的点击事件

- (void)touchCenterLabel:(UITapGestureRecognizer *)tap
{
    if([self.delegate respondsToSelector:@selector(theCallbackOfClickCenterLabel)])
    {
        [self.delegate theCallbackOfClickCenterLabel];
    }
}

#pragma mark -- setter或getter

- (void)setPercent:(float)percent
{
    if(self.percent < 0) return;
    _percent = percent;
    
    [self setNeedsDisplay];
}

- (UILabel *)centerLabel
{
    if(!_centerLabel)
    {
        _centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.progressWidth + 5, 0, WIDTH - (self.progressWidth +5) * 2, HEIGHT/2)];
        _centerLabel.center = CGPointMake(WIDTH/2, HEIGHT/2);
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.userInteractionEnabled = YES;
        _centerLabel.layer.cornerRadius = 5.0;
        _centerLabel.clipsToBounds = YES;
        [_centerLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCenterLabel:)]];
    }
    return _centerLabel;
}

@end
