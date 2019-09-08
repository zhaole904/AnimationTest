//
//  LayerAnimationVC.m
//  Animationsss
//
//  Created by fuchun on 2017/10/19.
//  Copyright © 2017年 le. All rights reserved.
//

#import "LayerAnimationVC.h"
#import <Foundation/Foundation.h>

@interface LayerAnimationVC ()
@property (nonatomic, strong) UIView *fireView;
@end

@implementation LayerAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self getCAEmitterLayer];
    [self getCAEmitterLayer1];
    [self getReplicatorLayer];
    [self getCAGradientLayer];
}

#pragma mark - 粒子发射层
- (void)getCAEmitterLayer
{
    self.fireView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.fireView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.fireView];

    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    
    //发射源的位置
    emitterLayer.emitterPosition = self.fireView.center;
    //发射源的形状
    emitterLayer.emitterShape = kCAEmitterLayerCircle;
    //发射源渲染模式
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell *emitterCell = [[CAEmitterCell alloc] init];
    //粒子的创建速率，默认为1/s。
    emitterCell.birthRate = 200;
    //粒子的生存时间
    emitterCell.lifetime = 0.5;
    //粒子的生存时间容差
    emitterCell.lifetimeRange = 0.2;
    
    emitterCell.color = [UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1].CGColor;
    emitterCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"fire"].CGImage);
    emitterCell.name = @"fire";
    // 粒子的速度
    emitterCell.velocity = 35;
    // 粒子动画的速度容差
    emitterCell.velocityRange = 10;
    // 粒子在xy平面的发射角度
    emitterCell.emissionLongitude = M_PI + M_PI_2;
    // 粒子发射角度的容差
    emitterCell.emissionRange = M_PI_2;
    // 缩放速度
    emitterCell.scaleSpeed = 0.3;
    
    emitterLayer.emitterCells = @[emitterCell];
    [self.fireView.layer addSublayer:emitterLayer];

}

- (void)getCAEmitterLayer1
{
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width / 2.0, -10);
    //指定发射源的大小
    snowEmitter.emitterSize  = CGSizeMake(self.view.bounds.size.width, 0.0);
    //指定发射源的形状和模式
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    snowEmitter.emitterMode  = kCAEmitterLayerOutline;
    [self.view.layer addSublayer:snowEmitter];
    
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    snowflake.birthRate = 5;
    snowflake.lifetime = 50.0;
    //初速度
    snowflake.velocity = 10;//因为动画属于落体效果，所以我们只需要设置它在 y 方向上的加速度就行了。
    //初速度范围
    snowflake.velocityRange = 5;
    //y方向的加速度
    snowflake.yAcceleration = 2;
    //
    snowflake.emissionRange = 0;
    
    snowflake.contents  = (id) [[UIImage imageNamed:@"rmb.jpg"] CGImage];
    //缩小
    snowflake.scale = 0.5;
    snowflake.spin = 0.5;
    // 旋转度
    snowflake.spin = 0.3;
    snowEmitter.emitterCells = @[snowflake];
}

#pragma mark - 拷贝视图容器
- (void)getReplicatorLayer
{
    CALayer *tLayer = [CALayer layer];
    tLayer.frame = CGRectMake(10, 20, 5, 40);
    tLayer.backgroundColor = [UIColor whiteColor].CGColor;
    
    
    CAReplicatorLayer *musicLayer = [CAReplicatorLayer layer];
    [musicLayer addSublayer:tLayer];
    musicLayer.frame = CGRectMake(0, 0, 65, 50);
    musicLayer.position = CGPointMake(200, 50);
    //设置复制层里面包含的子层个数
    musicLayer.instanceCount = 5;
    //设置下个子层相对于前一个的偏移量
    musicLayer.instanceTransform = CATransform3DMakeTranslation(10, 0, 0);     //每个layer的间距。
    //设置下一个层相对于前一个的延迟时间
    musicLayer.instanceDelay = 0.2;
    musicLayer.backgroundColor = [UIColor redColor].CGColor;
    musicLayer.masksToBounds = YES;
    [self.view.layer addSublayer:musicLayer];
    
    
    
    CABasicAnimation *musicAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    musicAnimation.duration = 0.5;
    musicAnimation.fromValue = @(tLayer.frame.size.height);
//    musicAnimation.toValue = @(tLayer.frame.size.height - 10);
    musicAnimation.byValue = @(20);
    musicAnimation.autoreverses = YES;
    musicAnimation.repeatCount = MAXFLOAT;
    
    [tLayer addAnimation:musicAnimation forKey:@"musicAnimation"];

}

#pragma mark - 波浪动画 见ProgressViewVC--
- (void)getCAShapeLayer
{

}

#pragma mark - 渐变色
- (void)getCAGradientLayer
{
    //创建圆弧路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:45 startAngle:- 7.0 / 6 * M_PI endAngle:M_PI / 6 clockwise:YES];
    
    //配置左色块CAGradientLayer
    CAGradientLayer *leftL = [self createGradientLayerWithColors:@[(id)[UIColor redColor].CGColor,(id)[UIColor yellowColor].CGColor]];
    leftL.position = CGPointMake(25, 40);
    
    //配置右色块CAGradientLayer
    CAGradientLayer *rightL = [self createGradientLayerWithColors:@[(id)[UIColor greenColor].CGColor,(id)[UIColor yellowColor].CGColor]];
    rightL.position = CGPointMake(75, 40);
    
    //将两个色块拼接到同一个layer并添加到self.view
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 80);
    layer.position = CGPointMake(60, 150);
    [layer addSublayer:leftL];
    [layer addSublayer:rightL];
    [self.view.layer addSublayer:layer];
    
    //创建一个ShapeLayer作为mask
    CAShapeLayer *mask = [self createShapeLayerWithPath:path];
    mask.position = CGPointMake(50, 40);
    layer.mask = mask;
}

//依照路径创建并返回一个CAShapeLayer
-(CAShapeLayer *)createShapeLayerWithPath:(UIBezierPath *)path {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.bounds = CGRectMake(0, 0, 100, 75);
    layer.position = CGPointMake(100, 200);
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineCap = @"round";
    layer.lineWidth = 10;
    
    return layer;
}

//依照给定的颜色数组创建并返回一个CAGradientLayer
-(CAGradientLayer *)createGradientLayerWithColors:(NSArray *)colors {
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = @[@0,@0.8];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(0, 0);
    gradientLayer.bounds = CGRectMake(0, 0, 50, 80);
    
    return gradientLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
