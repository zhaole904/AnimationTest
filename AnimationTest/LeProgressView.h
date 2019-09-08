//
//  LeProgressView.h
//  Animationsss
//
//  Created by fuchun on 2017/10/13.
//  Copyright © 2017年 le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeProgressView : UIView
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, assign) float progressValue;
@property (nonatomic, strong) UIColor *topColor;
@property (nonatomic, strong) NSArray *progressColors;
@property (nonatomic, strong) NSTimer *timer;

- (instancetype)initWithFrame:(CGRect)frame WithIsCycle:(BOOL)isCycle;
@end
