//
//  ViewController.m
//  Animationsss
//
//  Created by fuchun on 2017/10/13.
//  Copyright © 2017年 le. All rights reserved.
//

#import "ViewController.h"
#import "LeProgressView.h"
#import "CAShapeLayer+ChatViewMask.h"
#import "Letimer.h"

@interface ViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UILabel *lab;

@property (nonatomic, strong) LeProgressView *progressView;
@property (nonatomic, assign) int value;
@property (nonatomic, strong) UIView *voiceView;
@property (nonatomic, assign) CAShapeLayer *voiceLayer;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIImageView *imageV1;
@property (nonatomic, assign) BOOL front;
@property (nonatomic, strong) NSArray *valueArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [Letimer lescheduledTimerWithTimeInterval:1 block:^{
//        NSLog(@"001");
//    } repeats:YES];
//
//    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"002");
//    }];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(20, 90, 200, 100)];
    view.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:view];
//    self.voiceView = view;
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, 100, 100)];
    self.imageV.image = [UIImage imageNamed:@"001"];
    [self.view addSubview:self.imageV];
    
    self.imageV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 80)];
    self.imageV1.image = [UIImage imageNamed:@"011"];
//    [view addSubview:self.imageV1];

//        [self refreshVoiceUIWithView];
//    [self drawArcwithshapeLayer];
//    [self creatChatViewMask];
//    [self ss];
//    [self ee];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerGo ) userInfo:nil repeats:YES];

    self.valueArr = @[@90,@5,@10,@20,@40];
}

- (void)btnClick:(UIButton *)btn
{
    [self animationDaDaLogo];
    
}
- (void) animationDaDaLogo
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = - 1 / 100.0f;   // 设置视点在Z轴正方形z=100
    
    // 动画结束时，在Z轴负方向60
    CATransform3D startTransform = CATransform3DTranslate(transform, 0, 0, -60);
    // 动画结束时，绕Y轴逆时针旋转90度
    CATransform3D firstTransform = CATransform3DRotate(startTransform, M_PI_2, 0, 1, 0);
    
    // 通过CABasicAnimation修改transform属性
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform"];
    // 向后移动同时绕Y轴逆时针旋转90度
    animation1.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation1.toValue = [NSValue valueWithCATransform3D:firstTransform];
    
    // 虽然只有一个动画，但用Group只为以后好扩展
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:animation1, nil];
    animationGroup.duration = 0.5f;
    animationGroup.delegate = self;     // 动画回调，在动画结束调用animationDidStop
    animationGroup.removedOnCompletion = NO;    // 动画结束时停止，不回复原样
    
    // 对logoImg的图层应用动画
    [self.imageV.layer addAnimation:animationGroup forKey:@"FristAnimation"];
}

- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        if (anim == [self.imageV.layer animationForKey:@"FristAnimation"])
        {
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = - 1 / 100.0f;   // 设置视点在Z轴正方形z=100
            
            // 动画开始时，在Z轴负方向60
            CATransform3D startTransform = CATransform3DTranslate(transform, 0, 0, -60);
            // 动画开始时，绕Y轴顺时针旋转90度
            CATransform3D secondTransform = CATransform3DRotate(startTransform, -M_PI_2, 0, 1, 0);
            
            // 通过CABasicAnimation修改transform属性
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            // 向前移动同时绕Y轴逆时针旋转90度
            animation.fromValue = [NSValue valueWithCATransform3D:secondTransform];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
            animation.duration = 0.5f;
            
            // 对logoImg的图层应用动画
            [self.imageV.layer addAnimation:animation forKey:@"SecondAnimation"];
        }
    }
}
- (void)timerGo
{
    [self animationDaDaLogo];
}
//直接使用layer代替view
- (void)viewWillAppear:(BOOL)animated
{

//    CALayer *layer = [CALayer layer];
//    layer.frame = CGRectMake(100, 100, 100, 100);
//    layer.masksToBounds = YES;
//    layer.cornerRadius = 10.0;
//    layer.backgroundColor = [UIColor redColor].CGColor;
//    [self.view.layer addSublayer:layer];
}


- (void)viewDidLayoutSubviews
{
    NSLog(@"viewDidLayoutSubviews");
}
- (void)ee {
    
    CGPoint originalCenter = self.imageV.center;
    __weak typeof(self) weakSelf = self;
    [UIView animateKeyframesWithDuration:1.5 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.35 animations:^{
            self.imageV.center = CGPointMake(originalCenter.x+140, originalCenter.y-20);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.5 animations:^{
            self.imageV.transform = CGAffineTransformMake(0, 0, -0.5, 0, 0, 1) ;
        }];

        [UIView addKeyframeWithRelativeStartTime:0.35 relativeDuration:0.45 animations:^{
            self.imageV.center = CGPointMake(originalCenter.x+220, originalCenter.y-50);
            self.imageV.alpha = 0.0;
        }];

        [UIView addKeyframeWithRelativeStartTime:0.81 relativeDuration:0.01 animations:^{
            self.imageV.transform = CGAffineTransformIdentity;
            self.imageV.center = CGPointMake(0.0, originalCenter.y);
        }];

        [UIView addKeyframeWithRelativeStartTime:0.85 relativeDuration:0.45 animations:^{
            self.imageV.alpha = 1.0;
            self.imageV.center = originalCenter;
        }];
    } completion:^(BOOL finished) {
        
    }];
    //animateKeyframesWithDuration
//    [UIView animateWithDuration:1 delay:0.2 options:0 animations:^{
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//    [UIView transitionWithView:view duration:1 options:0 animations:^{
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//    [UIView animateWithDuration:1 delay:0.2 usingSpringWithDamping:0.5 initialSpringVelocity:0.2 options:0 animations:^{
//        
//    } completion:^(BOOL finished) {
//        
//    }];
    
    //   创建路径
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(CGRect){0,0,200,100} byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:(CGSize){30,0}];
//    
//    CAShapeLayer *pathLayer = [CAShapeLayer layer];
//    pathLayer.lineWidth = 2.0;
//    pathLayer.strokeColor = [UIColor grayColor].CGColor;
//    pathLayer.path = path.CGPath;
//    pathLayer.fillColor = [UIColor orangeColor].CGColor;
//    
//    [self.voiceView.layer addSublayer:pathLayer];
//    self.voiceView.backgroundColor = [UIColor redColor];
//    self.voiceView.layer.mask = pathLayer;
}


- (void)ss
{
    CGPoint point1 = CGPointMake(10, 10);
    CGPoint point2 = CGPointMake(150, 10);
    CGPoint point3 = CGPointMake(300, 100);
    CGPoint point4 = CGPointMake(50, 100);
    CGPoint point5 = CGPointMake(50, 50);
    CGPoint point6 = CGPointMake(10, 10);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor greenColor].CGColor;
    layer.position = CGPointMake(50, 50);
    [self.voiceView.layer addSublayer:layer];
    
//    self.voiceView.layer.mask = layer;
    self.voiceView.backgroundColor = [UIColor redColor];
}

- (void)creatChatViewMask
{
    CAShapeLayer *layer = [CAShapeLayer createMaskLayerWithView:self.voiceView];
    [self.voiceView.layer addSublayer:layer];
    
//    self.voiceView.layer.mask = layer;
//    self.voiceView.backgroundColor = [UIColor orangeColor];
}

- (void)refreshVoiceUIWithView
{
    LeProgressView *progressView = [[LeProgressView alloc] initWithFrame:CGRectMake(20, 50, 200, 20)];
    progressView.topColor = [UIColor orangeColor];
    progressView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    self.progressView.progressValue = 0.0;
    
    self.voiceView.layer.masksToBounds = YES;
    self.voiceView.layer.cornerRadius = 30.0;
    self.voiceView.backgroundColor = [UIColor redColor];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(change:) userInfo:nil repeats:YES];
    
}

- (void)change:(NSTimer *)timer {
    
    self.progressView.progressValue += 0.1;
    if (self.progressView.progressValue > 0.9) {
        [self.timer invalidate];
    }
    
    _value += 1;
    [self refreshVoiceUIWithView:self.voiceView voicePower:_value];
}

//masksToBounds   view.clipsToBounds
- (void)drawArcwithshapeLayer
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.frame = self.voiceView.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.voiceView.bounds];
    
    shapeLayer.path = path.CGPath;
//    shapeLayer.strokeStart = 0.0;
//    shapeLayer.strokeEnd = 0.8;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    [self.voiceView.layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 2.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:0.8f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    
    CABasicAnimation *startAni = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    startAni.fromValue = @0.0;
    startAni.toValue = @0.8;
    startAni.duration = 2.0;
    startAni.beginTime = 2.0;
    startAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[pathAnima, startAni];
    group.repeatCount = MAXFLOAT;
    group.fillMode = kCAFillModeForwards;
    group.duration = 4.0;
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.progressWidth, self.progressWidth, LOAD_WIDTH-self.progressWidth*2, LOAD_HEIGHT-self.progressWidth*2)];
    shapeLayer.path = path.CGPath;
    
    [shapeLayer addAnimation:group forKey:@"group"];
//    [self.layer addSublayer:shapeLayer];


}

-(void)refreshVoiceUIWithView:(UIView *)view voicePower:(int)voicePower
{
//    CGFloat height = (voicePower)*(CGRectGetHeight(view.frame));
    int height = [self.valueArr[voicePower%5] intValue];
    NSLog(@"uu=%d %d",voicePower%5,[self.valueArr[voicePower%5] intValue]);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, CGRectGetHeight(view.frame)-height, CGRectGetWidth(view.frame), height) cornerRadius:0];
    self.voiceLayer.path = path.CGPath;
    [view.layer addSublayer:self.voiceLayer];
    
}

- (CAShapeLayer *)voiceLayer
{
    if(!_voiceLayer)
    {
        _voiceLayer = [CAShapeLayer layer];
        _voiceLayer.fillColor = [UIColor blueColor].CGColor;
    }
    return _voiceLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
