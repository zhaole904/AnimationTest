//
//  KeyAnimationVC.m
//  Animationsss
//
//  Created by fuchun on 2017/10/19.
//  Copyright © 2017年 le. All rights reserved.
//

#import "KeyAnimationVC.h"
#import "LocusView.h"
#import "Dview.h"
@interface KeyAnimationVC ()

@end

@implementation KeyAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.layer.backgroundColor = [UIColor orangeColor].CGColor;
//    LocusView *locusView = [[LocusView alloc] initWithFrame:self.view.bounds];
    LocusView *locusView = [[LocusView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    locusView.layer.backgroundColor = [UIColor redColor].CGColor;

//    locusView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:locusView];
    locusView.layer.frame = CGRectMake(0, 0, 100, 100);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 100, 200)];
    view.layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view addSubview:view];
    
    Dview *v = [[Dview alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    [self.view addSubview:v];
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
