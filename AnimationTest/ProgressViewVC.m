//
//  ProgressViewVC.m
//  Animationsss
//
//  Created by fuchun on 2017/10/19.
//  Copyright © 2017年 le. All rights reserved.
//

#import "ProgressViewVC.h"
#import "LeProgressView.h"
#import "CircleProgressView.h"
#import "WaveProgressView.h"
#import "LoadProgressView.h"
#import "HemicycleLoadProgressView.h"
#import "AiQIYiLoadProgerssView.h"
#import "ColorProgressView.h"

@interface ProgressViewVC ()<CircleProgressViewDelegate>
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) LeProgressView *progressView;
@property (nonatomic, strong) CircleProgressView *circleProgress;
@property (nonatomic, strong) CircleProgressView *anticlockwiseProgress;
@property (nonatomic, strong) WaveProgressView *noWaveProgress;
@property (nonatomic, strong) WaveProgressView *waveProgress;
@property (nonatomic, strong) LoadProgressView *loadProgress;
@property (nonatomic, strong) HemicycleLoadProgressView *cycleLoadProgress;
@property (nonatomic, strong) AiQIYiLoadProgerssView *aiqiyiProgress;
@property (nonatomic, strong) ColorProgressView *colorProgress;

@property (nonatomic, strong) LeProgressView *progressView1;
@end

@implementation ProgressViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timergo:) userInfo:nil repeats:YES];
//    [self.timer fire];
    
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.circleProgress];
    
    self.anticlockwiseProgress.delegate = self;
    self.anticlockwiseProgress.centerLabel.text = @"跳过";
    [self.view addSubview:self.anticlockwiseProgress];
    
    [self.view addSubview:self.noWaveProgress];
    [self.view addSubview:self.waveProgress];
    
    [self.view addSubview:self.loadProgress];
    [self.loadProgress addNotificationObserver];
    
    [self.view addSubview:self.cycleLoadProgress];
    [self.cycleLoadProgress addNotificationObserver];
    
    [self.view addSubview:self.aiqiyiProgress];
    [self.aiqiyiProgress addNotificationObserver];
    
    [self.view addSubview:self.colorProgress];
    [self createColorButton];
    
    [self.view addSubview:self.progressView1];
}

- (void)timergo:(NSTimer *)timer
{
    self.progressView.progressValue += 0.05;
    self.progressView1.progressValue += 0.05;
    self.circleProgress.percent += 0.05;
    self.circleProgress.centerLabel.text = [NSString stringWithFormat:@"%.02f%%", self.circleProgress.percent*100];
    
    self.anticlockwiseProgress.percent += 0.05;
    
    self.noWaveProgress.percent += 0.05;
    self.noWaveProgress.centerLabel.text = [NSString stringWithFormat:@"%.02f%%", self.noWaveProgress.percent*100];
    
    self.waveProgress.percent += 0.05;
    self.waveProgress.centerLabel.text = [NSString stringWithFormat:@"%.02f%%", self.waveProgress.percent*100];
    
    if (self.progressView.progressValue > 0.9) {
        [self.timer invalidate];
    }
    
}

#pragma mark - 仿OC自带进度条
- (LeProgressView *)progressView
{
    if (!_progressView) {
        self.progressView = [[LeProgressView alloc] initWithFrame:CGRectMake(20, 20, 260, 20) WithIsCycle:NO];
        self.progressView.topColor = [UIColor redColor];
        self.progressView.backgroundColor = [UIColor grayColor];
    }
    return _progressView;
}

- (LeProgressView *)progressView1
{
    if (!_progressView1) {
        self.progressView1 = [[LeProgressView alloc] initWithFrame:CGRectMake(230, 430, 60, 60) WithIsCycle:YES];
        self.progressView1.progressColors = @[[UIColor redColor], [UIColor blueColor], [UIColor orangeColor], [UIColor greenColor]];
    }
    return _progressView1;
}
- (CircleProgressView *)circleProgress
{
    if(!_circleProgress)
    {
        _circleProgress = [[CircleProgressView alloc] initWithFrame:CGRectMake(50, 80, 80, 80)];
        _circleProgress.progressColor = [UIColor orangeColor];
        _circleProgress.progressBackgroundColor = [UIColor blueColor];
        _circleProgress.backgroundColor = [UIColor clearColor];
        _circleProgress.clockwise = 1;
        //        _circleProgress.loopMove = 1;
    }
    return _circleProgress;
}

- (CircleProgressView *)anticlockwiseProgress
{
    if(!_anticlockwiseProgress)
    {
        _anticlockwiseProgress = [[CircleProgressView alloc] initWithFrame:CGRectMake(200, 80, 80, 80)];
        _anticlockwiseProgress.clockwise = YES;
        _anticlockwiseProgress.backgroundColor = [UIColor clearColor];
        _anticlockwiseProgress.progressBackgroundColor = [UIColor greenColor];
        _anticlockwiseProgress.progressColor = [UIColor grayColor];
        
    }
    return _anticlockwiseProgress;
}

- (WaveProgressView *)noWaveProgress
{
    if(!_noWaveProgress)
    {
        _noWaveProgress  = [[WaveProgressView alloc] initWithFrame:CGRectMake(50, 200, 80, 80)];
        _noWaveProgress.isShowWave = NO;
    }
    return _noWaveProgress;
}

- (WaveProgressView *)waveProgress
{
    if(!_waveProgress)
    {
        _waveProgress = [[WaveProgressView alloc] initWithFrame:CGRectMake(200, 200, 80, 80)];
    }
    return _waveProgress;
}

- (LoadProgressView *)loadProgress
{
    if (!_loadProgress) {
        _loadProgress = [[LoadProgressView alloc] initWithFrame:CGRectMake(50, 320, 50, 50)];
        _loadProgress.progressColors = @[[UIColor redColor], [UIColor blueColor], [UIColor orangeColor], [UIColor greenColor]];
    }
    return _loadProgress;
}

- (HemicycleLoadProgressView *)cycleLoadProgress
{
    if(!_cycleLoadProgress)
    {
        _cycleLoadProgress = [[HemicycleLoadProgressView alloc] initWithFrame:CGRectMake(50, 400, 50, 50)];
    }
    return _cycleLoadProgress;
}

- (AiQIYiLoadProgerssView *)aiqiyiProgress
{
    if(!_aiqiyiProgress)
    {
        _aiqiyiProgress = [[AiQIYiLoadProgerssView alloc] initWithFrame:CGRectMake(50, 480, 50, 50)];
    }
    return _aiqiyiProgress;
}

- (ColorProgressView *)colorProgress
{
    if(!_colorProgress)
    {
        _colorProgress = [[ColorProgressView alloc] initWithFrame:CGRectMake(200, 320, 100, 100)];
    }
    return _colorProgress;
}

- (void)createColorButton
{
    UIButton *colorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colorBtn.frame = CGRectMake(0, 0, 20, 20);
    colorBtn.center = CGPointMake(250, 323);
    colorBtn.layer.cornerRadius = CGRectGetWidth(colorBtn.frame)/2;
    colorBtn.backgroundColor = [self.colorProgress colorWithCirclePoint:CGPointMake(250-200, 323-320)];;
    [colorBtn addTarget:self action:@selector(touchColorBtn: event:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:colorBtn];
}

- (void)touchColorBtn:(UIButton *)colorBtn event:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint btnPoint = [touch locationInView:self.view];
    //随着拖拽按钮改变按钮的位置
    colorBtn.center = [self.colorProgress getColorBtnCenterWithDragBtnPoint:btnPoint centerOfCircle:self.colorProgress.center];
    CGPoint center = colorBtn.center;
    //注意 你获取的是self.colorProgress上的颜色，所以你的坐标应该是self.colorProgress为父视图的坐标
    center.x -= CGRectGetMinX(self.colorProgress.frame);
    center.y -= CGRectGetMinY(self.colorProgress.frame);
    colorBtn.backgroundColor = [self.colorProgress colorWithCirclePoint:center];
}

#pragma mark -- CircleProgressViewDelegate
- (void)theCallbackOfClickCenterLabel
{
    NSLog(@"点击了中间按钮");
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.timer) {
        [self.timer invalidate];
    }
    [self.loadProgress.timer invalidate];
    [self.progressView1.timer invalidate];
}

- (void)dealloc
{
    NSLog(@"dealloc--dealloc");
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
