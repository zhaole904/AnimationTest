//
//  Letimer.h
//  Animationsss
//
//  Created by fuchun on 2017/10/18.
//  Copyright © 2017年 le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Letimer : NSTimer
+ (NSTimer *)lescheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats;
@end
