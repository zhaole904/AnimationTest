//
//  CAShapeLayer+ChatViewMask.h
//  Animationsss
//
//  Created by fuchun on 2017/10/17.
//  Copyright © 2017年 le. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CAShapeLayer (ChatViewMask)
+ (instancetype)createMaskLayerWithView:(UIView *)view;
//-(void)refreshVoiceUIWithView:(UIView *)view voicePower:(NSInteger)voicePower;
@end
