//
//  LocusView.h
//  SONiX－飞控
//
//  Created by zxc-02 on 16/8/15.
//  Copyright © 2016年 黎峰麟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)(NSMutableArray *aArr,CGFloat time);
@interface LocusView : UIView

@property(nonatomic,strong)Block callblock;

@property (nonatomic, strong) NSMutableArray *resultArr;


//清除路径
-(void)clearView;

//返回上次路径
-(void)lastTimeView;

@end
