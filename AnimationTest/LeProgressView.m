//
//  LeProgressView.m
//  Animationsss
//
//  Created by fuchun on 2017/10/13.
//  Copyright © 2017年 le. All rights reserved.
//

#import "LeProgressView.h"

@interface LeProgressView ()
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) BOOL isCycle;
@end

@implementation LeProgressView

- (instancetype)initWithFrame:(CGRect)frame WithIsCycle:(BOOL)isCycle
{
    if([super initWithFrame:frame])
    {
        [self initDataWithIsCycle:isCycle];
        self.isCycle = isCycle;
    }
    return self;
}

- (void)initDataWithIsCycle:(BOOL)isCycle {
    
    if (!isCycle) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)+10, 0, 60, 20)];
        lab.backgroundColor = [UIColor redColor];
        [self addSubview:lab];
        self.lab = lab;
        
        [self addSubview:self.topView];
    } else {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeColor:) userInfo:nil repeats:YES];
    }
    
}

- (void)setProgressValue:(float)progressValue
{
    _progressValue = progressValue;
    
    self.topView.frame = CGRectMake(0, 0, self.frame.size.width*_progressValue, self.frame.size.height);
    self.lab.text = [NSString stringWithFormat:@"%.1f%%",_progressValue*100];
    self.topView.backgroundColor = self.topColor;
}

- (void)changeColor:(NSTimer *)timer
{
    self.num ++;
    [self setNeedsDisplay];

}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] init];
       
    }
    return _topView;
}

- (void)drawRect:(CGRect)rect
{
    if (self.isCycle) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
//        CGContextSetShouldAntialias(context, YES); // 平滑
        
        CGContextAddArc(context, self.bounds.size.width/2.0, self.bounds.size.height/2, (self.bounds.size.width-2)/2,0, 2*M_PI, 0);
        [self.progressColors[self.num % self.progressColors.count] setStroke];
        CGContextSetLineWidth(context, 2);
        CGContextStrokePath(context);
    }
}

- (void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
//- (void)layoutSubviews
//{
//    NSLog(@"layoutSubviews");
//}
@end
