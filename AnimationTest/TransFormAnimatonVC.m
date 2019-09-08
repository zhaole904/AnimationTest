
//
//  TransFormAnimatonVC.m
//  Animationsss
//
//  Created by fuchun on 2017/10/19.
//  Copyright © 2017年 le. All rights reserved.
//

#import "TransFormAnimatonVC.h"
#import "ImageCut.h"

#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height)
#define imageWidth 20
#define imageHeight 150

static float angle = 0;
static int num = 48;

@interface TransFormAnimatonVC ()<CAAnimationDelegate>
{
    CGFloat angleChange;  //角度变化
    CGFloat angleY;  //Y轴
    CGFloat angleX;  //X轴
    CGFloat le;  //Z轴方向便宜的距离
    
    CGPoint gestureStartPoint;
    CATransform3D trans;
}
@property (nonatomic ,strong) UIImageView *imageV;
@property (nonatomic ,strong) NSMutableArray *imageNameM;

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation TransFormAnimatonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.logoView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    self.logoView.image = [UIImage imageNamed:@"le"];
    [self.view addSubview:self.logoView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startAnimation:) userInfo:nil repeats:YES];
    
    
    
    angleX = 0.0;
    angleY = 1.0;
    
    trans = CATransform3DIdentity;
    trans = CATransform3DMakeRotation(100 , 1 , 0 , 0);
    self.view.layer.sublayerTransform = trans;
    
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    _imageNameM = [[NSMutableArray alloc]init];
    for (int i = 0; i < num; i++) {
        CGFloat imageX = (SCREEN_W - imageWidth)/2.0;
        CGFloat imageY = (SCREEN_H - imageHeight)/2.0;
        
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, imageY, imageWidth, imageHeight)];
        _imageV.image = [ImageCut imageCutWithImage:image count:num][i];
        
        [self.view addSubview:_imageV];
        [_imageNameM addObject:_imageV];
        
    }
}

- (void)startAnimation:(NSTimer *)timer
{
    [self logoanimation];
}

- (void)logoanimation
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
    [self.logoView.layer addAnimation:animationGroup forKey:@"FristAnimation"];
}

- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        if (anim == [self.logoView.layer animationForKey:@"FristAnimation"])
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
            [self.logoView.layer addAnimation:animation forKey:@"SecondAnimation"];
        }
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [self move];
}

#pragma mark － CATransform3D方法
//CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
//{
//    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, imageHeight/2.0);
//    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, imageHeight/2.0);
//    CATransform3D scale = CATransform3DIdentity;
//    scale.m34 = -1.0f/disZ;   //透视效果  m34负责z轴方向的translation（移动）,m34= -1/D,默认值是0。
//    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
//}

//CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
//{
//    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
//}

//center指的是相机的位置  CATransform3DIdentity
- (CATransform3D)CATransform3DMakePerspectiveWithCenter:(CGPoint)center
                                                   disZ:(NSInteger)disZ
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, le/2.0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, le/2.0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;   //透视效果  m34负责z轴方向的translation（移动）,m34= -1/D,默认值是0。
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

- (CATransform3D)CATransform3DPerspect:(CATransform3D)t center:(CGPoint)center disZ:(NSInteger)disZ
{
    return CATransform3DConcat(t, [self CATransform3DMakePerspectiveWithCenter:center disZ:disZ]);
}

#pragma mark － image移动方法
- (void)move
{
    //变化的角度
    angle += angleChange;
    
    //计算移动的距离： tan((M_PI*2/num)/2) = (imageWidth/2)/L - 0.5(减少误差)
    le = imageWidth/2/tan(M_PI/num)-0.5;
    
    //CATransform3DMakeTranslation(tx:：x平移。  ty：y平移。  tz：z平移)
    CATransform3D move = CATransform3DMakeTranslation( 0, 0, le);
    CATransform3D back = CATransform3DMakeTranslation( 0, 0, -le);
    
    //CATransform3DConcat:将两个transform3D对象变换属性进行叠加，返回一个新的transform3D对象
    for (int i=0; i < num; i++) {
        UIImageView *imagevv = _imageNameM[i];
        CATransform3D rotateName = CATransform3DMakeRotation((M_PI*2/num *i)-angle, angleX, angleY, 0);
        CATransform3D matName = CATransform3DConcat(CATransform3DConcat(move, rotateName), back);
        imagevv.layer.transform = [self CATransform3DPerspect:matName center:CGPointZero disZ:5000000000];
    }
}


#pragma mark － 开始触摸屏幕方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    gestureStartPoint = [touch locationInView:self.view.superview];
}


#pragma mark － 正在触摸屏幕方法
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view.superview];
    CGFloat deltaX = gestureStartPoint.x - currentPosition.x;
    CGFloat deltaY = gestureStartPoint.y - currentPosition.y;
    CGFloat minDistance = 1.0;
    
    //上下滑动 fabs－－取绝对值，当y轴的偏移量大于x轴时，判断为上下滑动。
    if(fabs(deltaY) > fabs(deltaX))
    {
        
        //向上滑动
        if (deltaY > minDistance)
        {
            NSLog(@"up");
            //angleChange 角度变化 即旋转速度
            angleChange = deltaY/5000.0;
            
            trans = CATransform3DRotate(trans, angleChange , 1, 0 , 0);
            self.view.layer.sublayerTransform = CATransform3DRotate(trans, angleChange , 1, 0 , 0);
            
        }
        
        //向下滑动
        else if (deltaY < -minDistance)
        {
            NSLog(@"down");
            angleChange = deltaY/5000.0;
            
            trans = CATransform3DRotate(trans, angleChange , 1, 0 , 0);
            self.view.layer.sublayerTransform = trans;
        }
        
    }
    
    //左右滑动
    else if(fabs(deltaX) > fabs(deltaY))
    {
        
        //向左滑动
        if (deltaX > minDistance)
        {
            NSLog(@"left");
            angleY = 1.0;
            angleX = 0.0;
            angleChange = deltaX/5000.0;
            [self move];
        }
        
        //向右滑动
        else if (deltaX < -minDistance)
        {
            NSLog(@"right");
            angleY = 1.0;
            angleX = 0.0;
            angleChange = deltaX/5000.0;
            [self move];
        }
        
    }
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
