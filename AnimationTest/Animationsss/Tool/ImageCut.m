//
//  ImageCut.m
//  Animationsss
//
//  Created by fuchun on 2017/10/21.
//  Copyright © 2017年 le. All rights reserved.
//

#import "ImageCut.h"

@implementation ImageCut

+(NSArray *)imageCutWithImage:(UIImage *)image count:(NSInteger)imageCount{
    
    if (image == nil || imageCount == 0) {
        return nil;
    }
    
    NSMutableArray *images = [NSMutableArray array];
    
    CGSize imageSize = image.size;
    CGFloat oneImageWidth = image.size.width / imageCount;

    for (int i = 0 ; i < imageCount; i++) {
        CGRect cutFrame = CGRectMake(oneImageWidth * i, 0, oneImageWidth, imageSize.height);
        CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, cutFrame);
        [images addObject:[UIImage imageWithCGImage:imageRef]];
    }
    
    return images;
}

@end
