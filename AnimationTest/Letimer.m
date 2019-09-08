//
//  Letimer.m
//  Animationsss
//
//  Created by fuchun on 2017/10/18.
//  Copyright © 2017年 le. All rights reserved.
//

#import "Letimer.h"

@implementation Letimer
+ (NSTimer *)lescheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(blockInvoke:) userInfo:[block copy] repeats:repeats];
    
}

+ (void)blockInvoke:(NSTimer *)timer {
    void (^ block)() = timer.userInfo;
    if (block) {
        block();
    }
}
@end
